//
//  NAHCryptor.h
//  NAHCrypto
//
//  Created by David Wagner on 01/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NAHCryptor <NSObject>

- (nullable NSData *)encrypt:(NSData *)clearData error:(NSError **)error;
- (nullable NSData *)decrypt:(NSData *)encryptedData error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
