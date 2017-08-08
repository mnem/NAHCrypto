//
//  NAHStringPasswordKeyProviderTests.m
//  NAHCryptoTests
//
//  Created by David Wagner on 08/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CommonCrypto/CommonCrypto.h>
#import "NAHStringPasswordKeyProvider.h"

@interface NAHStringPasswordKeyProviderTests : XCTestCase

@end

@implementation NAHStringPasswordKeyProviderTests

- (void)testAES128KeySize
{
    NSString *password = @"password";
    NSData *salt = [@"salt" dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger keyLength = kCCKeySizeAES128;
    NAHStringPasswordKeyProvider *provider = [[NAHStringPasswordKeyProvider alloc] initWithPassword:password salt:salt keyLength:keyLength];
    
    [provider provideKeyInBlock:^(NSData * _Nullable key, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(key);
        XCTAssertEqual(16, key.length);
    }];
}

- (void)testAES192KeySize
{
    NSString *password = @"password";
    NSData *salt = [@"salt" dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger keyLength = kCCKeySizeAES192;
    NAHStringPasswordKeyProvider *provider = [[NAHStringPasswordKeyProvider alloc] initWithPassword:password salt:salt keyLength:keyLength];
    
    [provider provideKeyInBlock:^(NSData * _Nullable key, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(key);
        XCTAssertEqual(24, key.length);
    }];
}

- (void)testAES256KeySize
{
    NSString *password = @"password";
    NSData *salt = [@"salt" dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger keyLength = kCCKeySizeAES256;
    NAHStringPasswordKeyProvider *provider = [[NAHStringPasswordKeyProvider alloc] initWithPassword:password salt:salt keyLength:keyLength];
    
    [provider provideKeyInBlock:^(NSData * _Nullable key, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(key);
        XCTAssertEqual(32, key.length);
    }];
}

- (void)testKeyDeterminism
{
    NSString *password = @"password";
    NSData *salt = [@"salt" dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger keyLength = kCCKeySizeAES256;
    NAHStringPasswordKeyProvider *provider = [[NAHStringPasswordKeyProvider alloc] initWithPassword:password salt:salt keyLength:keyLength];
    __block NSData *key1;
    
    [provider provideKeyInBlock:^(NSData * _Nullable key, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(key);
        XCTAssertEqual(32, key.length);
        
        key1 = [key copy];
    }];

    NAHStringPasswordKeyProvider *provider2 = [[NAHStringPasswordKeyProvider alloc] initWithPassword:password salt:salt keyLength:keyLength];
    __block NSData *key2;
    
    [provider2 provideKeyInBlock:^(NSData * _Nullable key, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(key);
        XCTAssertEqual(32, key.length);
        
        key2 = [key copy];
    }];
    XCTAssertEqualObjects(key1, key2);

    NSData *salt3 = [@"salt3" dataUsingEncoding:NSUTF8StringEncoding];
    NAHStringPasswordKeyProvider *provider3 = [[NAHStringPasswordKeyProvider alloc] initWithPassword:password salt:salt3 keyLength:keyLength];
    __block NSData *key3;
    
    [provider3 provideKeyInBlock:^(NSData * _Nullable key, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(key);
        XCTAssertEqual(32, key.length);
        
        key3 = [key copy];
    }];
    XCTAssertNotEqualObjects(key1, key3);


    NSString *password4 = @"password4";
    NAHStringPasswordKeyProvider *provider4 = [[NAHStringPasswordKeyProvider alloc] initWithPassword:password4 salt:salt keyLength:keyLength];
    __block NSData *key4;
    
    [provider4 provideKeyInBlock:^(NSData * _Nullable key, NSError * _Nullable error) {
        XCTAssertNil(error);
        XCTAssertNotNil(key);
        XCTAssertEqual(32, key.length);
        
        key4 = [key copy];
    }];
    XCTAssertNotEqualObjects(key1, key3);
}


@end

