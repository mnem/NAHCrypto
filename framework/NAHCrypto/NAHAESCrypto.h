//
//  NAHAESCrypto.h
//  NAHCrypto
//
//  Created by David Wagner on 08/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAHCryptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface NAHAESCrypto : NSObject

+ (id<NAHCryptor>)AES128CryptorWithPassword:(NSString *)password;
+ (id<NAHCryptor>)AES192CryptorWithPassword:(NSString *)password;
+ (id<NAHCryptor>)AES256CryptorWithPassword:(NSString *)password;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
