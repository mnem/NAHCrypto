//
//  NAHPStringPasswordProvider.h
//  NAHCrypto
//
//  Created by David Wagner on 07/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAHKeyProviding.h"

NS_ASSUME_NONNULL_BEGIN

@interface NAHStringPasswordKeyProvider : NSObject <NAHKeyProviding>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithPassword:(NSString *)password salt:(NSData *)salt keyLength:(NSUInteger)keySize;

@end

NS_ASSUME_NONNULL_END
