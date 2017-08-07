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
@property (nonatomic) id<NAHInitializationVectorGenerating>ivGenerator;
@end


@implementation NAHAESCryptor

- (instancetype)initWithKeyProvider:(id<NAHKeyProviding>)keyProvider initializationVectorGenerator:(id<NAHInitializationVectorGenerating>)ivGenerator
{
    self = [super init];
    if (self) {
        _keyProvider = keyProvider;
        _ivGenerator = ivGenerator;
    }
    return self;
}

- (nullable NSData *)decrypt:(nonnull NSData *)encryptedData error:(NSError * _Nullable __autoreleasing * _Nullable)error
{
    if (error != NULL) {
        *error = nil;
    }
    
    NSMutableData *outData = [NSMutableData dataWithLength:encryptedData.length + kCCBlockSizeAES128];
    
    [self.keyProvider provideKeyInBlock:^(NSData * _Nullable key, NSError * _Nullable error) {
        NSAssert(error == nil, @"Error getting key");
        NSAssert(key != nil, @"Key cannot be nil");
        
        NSError *generateIVError = nil;
        NSData *iv = [self.ivGenerator generateWithError:&generateIVError];
        NSAssert(generateIVError == nil, @"Could not generate IV");
        NSAssert(iv != nil, @"IV cannot be nil");
        NSAssert(iv.length == kCCBlockSizeAES128, @"IV is the wrong length");
        
        size_t outDataSize = 0;
        CCCryptorStatus result = CCCrypt(kCCDecrypt,
                                         kCCAlgorithmAES,
                                         kCCOptionPKCS7Padding,
                                         key.bytes, key.length,
                                         iv.bytes,
                                         encryptedData.bytes, encryptedData.length,
                                         outData.mutableBytes, outData.length,
                                         &outDataSize);
        NSAssert(result == kCCSuccess, @"Operation failed");
        outData.length = outDataSize;
    }];
    
    return [outData copy];
}

- (nullable NSData *)encrypt:(nonnull NSData *)clearData error:(NSError * _Nullable __autoreleasing * _Nullable)error
{
    if (error != NULL) {
        *error = nil;
    }
    
    NSMutableData *outData = [NSMutableData dataWithLength:clearData.length + kCCBlockSizeAES128];
    
    [self.keyProvider provideKeyInBlock:^(NSData * _Nullable key, NSError * _Nullable error) {
        NSAssert(error == nil, @"Error getting key");
        NSAssert(key != nil, @"Key cannot be nil");
        
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
    }];
    
    return [outData copy];
}

@end
