//
//  NAHEncryptedMessage.h
//  NAHCrypto
//
//  Created by David Wagner on 08/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NAHEncryptedMessage : NSObject

@property (nonatomic, readonly) NSData *encryptedData;
@property (nonatomic, readonly) NSData *iv;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithEncryptedData:(NSData *)encryptedData iv:(NSData *)iv;

@end

NS_ASSUME_NONNULL_END
