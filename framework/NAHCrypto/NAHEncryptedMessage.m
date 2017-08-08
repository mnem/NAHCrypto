//
//  NAHEncryptedMessage.m
//  NAHCrypto
//
//  Created by David Wagner on 08/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import "NAHEncryptedMessage.h"

@implementation NAHEncryptedMessage

- (instancetype)initWithEncryptedData:(NSData *)encryptedData iv:(NSData *)iv
{
    self = [super init];
    if (self) {
        _encryptedData = [encryptedData copy];
        _iv = [iv copy];
    }
    return self;
}

@end
