//
//  NAHAESCryptor.m
//  NAHCrypto
//
//  Created by David Wagner on 03/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "NAHAESCryptor.h"

@interface NAHAESCryptor ()
@property (nonatomic) id<NAHKeyProviding>keyProvider;
@property (nonatomic) id<NAHIVGenerating>ivGenerator;
@end


@implementation NAHAESCryptor

- (instancetype)initWithKeyProvider:(id<NAHKeyProviding>)keyProvider initializationVectorGenerator:(id<NAHIVGenerating>)ivGenerator
{
    self = [super init];
    if (self) {
        _keyProvider = keyProvider;
        _ivGenerator = ivGenerator;
    }
    return self;
}

- (nullable NSData *)decrypt:(nonnull NAHEncryptedMessage *)encryptedMessage error:(NSError * _Nullable __autoreleasing * _Nullable)error
{
    if (error != NULL) {
        *error = nil;
    }
    
    NSMutableData *outData = [NSMutableData dataWithLength:encryptedMessage.encryptedData.length + kCCBlockSizeAES128];
    
    [self.keyProvider provideKeyInBlock:^(NSData * _Nullable key, NSError * _Nullable error) {
        NSAssert(error == nil, @"Error getting key");
        NSAssert(key != nil, @"Key cannot be nil");
        
        size_t outDataSize = 0;
        CCCryptorStatus result = CCCrypt(kCCDecrypt,
                                         kCCAlgorithmAES,
                                         kCCOptionPKCS7Padding,
                                         key.bytes, key.length,
                                         encryptedMessage.iv.bytes,
                                         encryptedMessage.encryptedData.bytes, encryptedMessage.encryptedData.length,
                                         outData.mutableBytes, outData.length,
                                         &outDataSize);
        NSAssert(result == kCCSuccess, @"Operation failed");
        outData.length = outDataSize;
    }];
    
    return [outData copy];
}

- (nullable NAHEncryptedMessage *)encrypt:(nonnull NSData *)clearData error:(NSError * _Nullable __autoreleasing * _Nullable)error
{
    if (error != NULL) {
        *error = nil;
    }
    
    __block NAHEncryptedMessage *encryptedMessage = nil;
    
    [self.keyProvider provideKeyInBlock:^(NSData * _Nullable key, NSError * _Nullable error) {
        NSAssert(error == nil, @"Error getting key");
        NSAssert(key != nil, @"Key cannot be nil");
        
        NSMutableData *outData = [NSMutableData dataWithLength:clearData.length + kCCBlockSizeAES128];
        
        NSError *generateIVError = nil;
        NSData *iv = [self.ivGenerator generateWithError:&generateIVError];
        NSAssert(generateIVError == nil, @"Could not generate IV");
        NSAssert(iv != nil, @"IV cannot be nil");
        NSAssert(iv.length == kCCBlockSizeAES128, @"IV is the wrong length");
        
        size_t outDataSize = 0;
        CCCryptorStatus result = CCCrypt(kCCEncrypt,
                                         kCCAlgorithmAES,
                                         kCCOptionPKCS7Padding,
                                         key.bytes, key.length,
                                         iv.bytes,
                                         clearData.bytes, clearData.length,
                                         outData.mutableBytes, outData.length,
                                         &outDataSize);
        NSAssert(result == kCCSuccess, @"Operation failed");
        outData.length = outDataSize;
        
        encryptedMessage = [[NAHEncryptedMessage alloc] initWithEncryptedData:outData iv:iv];
    }];
    
    return encryptedMessage;
}

@end
