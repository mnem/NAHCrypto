//
//  NAHRandomInitializationVector.m
//  NAHCrypto
//
//  Created by David Wagner on 07/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import "NAHRandomInitializationVector.h"

#import <CommonCrypto/CommonCrypto.h>


@interface NAHRandomInitializationVector ()
@property (nonatomic, readonly) NSUInteger vectorByteLength;
@end

@implementation NAHRandomInitializationVector

- (instancetype)initWithVectorByteLength:(NSUInteger)vectorByteLength
{
    self = [super init];
    if (self) {
        _vectorByteLength = vectorByteLength;
    }
    return self;
}


- (nullable NSData *)generateWithError:(NSError **)error
{
    if (error != NULL) {
        *error = nil;
    }
    
    NSMutableData *randomBytes = [NSMutableData dataWithLength:self.vectorByteLength];
    int result = SecRandomCopyBytes(kSecRandomDefault,
                                    self.vectorByteLength,
                                    randomBytes.mutableBytes);

    if (result == errSecSuccess) {
        return [randomBytes copy];
    } else {
        if (error != NULL) {
            *error = [NSError errorWithDomain:@"NAHCrypto"
                                         code:666
                                     userInfo:@{NSDebugDescriptionErrorKey: @"IV Generation failed"}];
        }
        return nil;
    }
}

@end
