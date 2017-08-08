//
//  NAHCryptor.h
//  NAHCrypto
//
//  Created by David Wagner on 01/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAHEncryptedMessage.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NAHCryptor <NSObject>

- (nullable NAHEncryptedMessage *)encrypt:(NSData *)clearData error:(NSError **)error;
- (nullable NSData *)decrypt:(NAHEncryptedMessage *)encryptedData error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
