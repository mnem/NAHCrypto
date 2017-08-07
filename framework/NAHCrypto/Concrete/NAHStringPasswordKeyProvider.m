//
//  NAHPStringPasswordProvider.m
//  NAHCrypto
//
//  Created by David Wagner on 07/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "NAHStringPasswordKeyProvider.h"

@interface NAHStringPasswordKeyProvider ()
@property (nonatomic, readonly) NSData *derivedKey;
@end

@implementation NAHStringPasswordKeyProvider

- (instancetype)initWithPassword:(NSString *)password salt:(NSData *)salt keySize:(NSUInteger)keySize
{
    NSAssert(salt.length > 0, @"Salt length must not be zero");
    
    self = [super init];
    if (self) {
        const unsigned int kRounds = 10000;
        NSMutableData *derivedKey = [NSMutableData dataWithLength:keySize];
        int result = CCKeyDerivationPBKDF(kCCPBKDF2,
                                          password.UTF8String,
                                          [password lengthOfBytesUsingEncoding:NSUTF8StringEncoding],
                                          salt.bytes,
                                          salt.length,
                                          kCCPRFHmacAlgSHA256,
                                          kRounds,
                                          derivedKey.mutableBytes,
                                          derivedKey.length);
        NSAssert(result == errSecSuccess, @"Failed to generate derived key from password and salt.");
        _derivedKey = [derivedKey copy];
    }
    return self;
}

- (void)provideKeyInBlock:(nonnull NAHKeyProviderBlock)block {
    block(self.derivedKey, nil);
}

@end
