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

- (NSData *)encrypt:(NSData *)clearData;
- (NSData *)decrypt:(NSData *)encryptedData;

@end

NS_ASSUME_NONNULL_END
