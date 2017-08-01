//
//  NAHEcho.m
//  NAHCrypto
//
//  Created by David Wagner on 01/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

@import os.log;
#import "NAHEcho.h"

extern double NAHCryptoVersionNumber;
extern const unsigned char NAHCryptoVersionString[];

@implementation NAHEcho

+ (NSString *)echo:(NSString *)message
{
    NSString *echo = [NSString stringWithFormat:@"[Version: %f, Strversion: %s] %@", NAHCryptoVersionNumber, NAHCryptoVersionString, message];
    return echo;
}


@end
