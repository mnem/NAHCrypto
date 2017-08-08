//
//  NAHAESCryptorTests.m
//  NAHCryptoTests
//
//  Created by David Wagner on 08/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NAHAESCrypto.h"

@interface NAHAESCryptoTests : XCTestCase

@end

@implementation NAHAESCryptoTests

- (void)testAES128 {
    id<NAHCryptor> cryptor = [NAHAESCrypto AES128CryptorWithPassword:@"foo"];
    
    NSString *message = @"Fiddlesticks";
    NSData *messageData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NAHEncryptedMessage *encrypted = [cryptor encrypt:messageData error:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(encrypted);
    XCTAssertNotEqual(encrypted.encryptedData, messageData);

    error = nil;
    NSData *unencrypted = [cryptor decrypt:encrypted error:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(unencrypted);
    XCTAssertEqualObjects(unencrypted, messageData);

    error = nil;
    NAHEncryptedMessage *encrypted2 = [cryptor encrypt:messageData error:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(encrypted);
    XCTAssertNotEqual(encrypted.encryptedData, encrypted2.encryptedData);
}

@end
