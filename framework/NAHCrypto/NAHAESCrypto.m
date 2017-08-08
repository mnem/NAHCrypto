//
//  NAHAESCrypto.m
//  NAHCrypto
//
//  Created by David Wagner on 08/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <CommonCrypto/CommonCrypto.h>
#import "NAHAESCrypto.h"
#import "NAHAESCryptor.h"
#import "NAHRandomIVGenerator.h"
#import "NAHStringPasswordKeyProvider.h"

@implementation NAHAESCrypto

+ (NSData *)randomSalt
{
    const int SaltLength = 32;
    NSMutableData *salt = [NSMutableData dataWithLength:SaltLength];
    int result = SecRandomCopyBytes(kSecRandomDefault,
                                    SaltLength,
                                    salt.mutableBytes);
    NSAssert(result == errSecSuccess, @"Failed to generate random salt.");
    return [salt copy];
}

+ (id<NAHCryptor>)AESCryptorWithPassword:(NSString *)password keyLength:(int)keyLength
{
    NSData *salt = [self randomSalt];
    NAHStringPasswordKeyProvider *keyProvider = [[NAHStringPasswordKeyProvider alloc] initWithPassword:password salt:salt keyLength:keyLength];
    NAHRandomIVGenerator *ivGenerator = [[NAHRandomIVGenerator alloc] initWithVectorByteLength:kCCBlockSizeAES128];

    return [[NAHAESCryptor alloc] initWithKeyProvider:keyProvider initializationVectorGenerator:ivGenerator];
}


+ (id<NAHCryptor>)AES128CryptorWithPassword:(NSString *)password
{
    return [self AESCryptorWithPassword:password keyLength:kCCKeySizeAES128];
}

+ (id<NAHCryptor>)AES192CryptorWithPassword:(NSString *)password
{
    return [self AESCryptorWithPassword:password keyLength:kCCKeySizeAES192];
}

+ (id<NAHCryptor>)AES256CryptorWithPassword:(NSString *)password
{
    return [self AESCryptorWithPassword:password keyLength:kCCKeySizeAES256];
}

@end
