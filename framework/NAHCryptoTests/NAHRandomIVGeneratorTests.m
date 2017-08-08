//
//  NAHRandomIVTests.m
//  NAHCryptoTests
//
//  Created by David Wagner on 08/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NAHRandomIVGenerator.h"

@interface NAHRandomIVGeneratorTests : XCTestCase

@end

@implementation NAHRandomIVGeneratorTests

- (void)testSomeIVLengths
{
    NAHRandomIVGenerator *generator = [[NAHRandomIVGenerator alloc] initWithVectorByteLength:1];
    XCTAssertNotNil(generator);
    NSError *error = nil;
    NSData *iv = [generator generateWithError:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(iv);
    XCTAssertEqual(iv.length, 1);

    generator = [[NAHRandomIVGenerator alloc] initWithVectorByteLength:2];
    XCTAssertNotNil(generator);
    error = nil;
    iv = [generator generateWithError:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(iv);
    XCTAssertEqual(iv.length, 2);

    generator = [[NAHRandomIVGenerator alloc] initWithVectorByteLength:3];
    XCTAssertNotNil(generator);
    error = nil;
    iv = [generator generateWithError:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(iv);
    XCTAssertEqual(iv.length, 3);

    generator = [[NAHRandomIVGenerator alloc] initWithVectorByteLength:4];
    XCTAssertNotNil(generator);
    error = nil;
    iv = [generator generateWithError:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(iv);
    XCTAssertEqual(iv.length, 4);

    generator = [[NAHRandomIVGenerator alloc] initWithVectorByteLength:8];
    XCTAssertNotNil(generator);
    error = nil;
    iv = [generator generateWithError:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(iv);
    XCTAssertEqual(iv.length, 8);

    generator = [[NAHRandomIVGenerator alloc] initWithVectorByteLength:16];
    XCTAssertNotNil(generator);
    error = nil;
    iv = [generator generateWithError:&error];
    XCTAssertNil(error);
    XCTAssertNotNil(iv);
    XCTAssertEqual(iv.length, 16);
}

- (void)testSomeIVUniqueness
{
    NAHRandomIVGenerator *generator = [[NAHRandomIVGenerator alloc] initWithVectorByteLength:16];
    XCTAssertNotNil(generator);
    static const int TestElementSize = 1000;
    NSMutableArray<NSData *> *ivs = [NSMutableArray arrayWithCapacity:TestElementSize];
    
    for (int i = 0; i < TestElementSize; i++) {
        NSError *error = nil;
        NSData *iv = [generator generateWithError:&error];
        XCTAssertNil(error);
        XCTAssertNotNil(iv);
        XCTAssertEqual(iv.length, 16);
        
        XCTAssertTrue([ivs indexOfObject:iv] == NSNotFound);
        XCTAssertEqual(i, ivs.count);
        [ivs addObject:iv];
    }
}

@end
