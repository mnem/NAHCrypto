//
//  NAHKeyProviding.h
//  NAHCrypto
//
//  Created by David Wagner on 03/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NAHKeyProviderBlock)(NSData * _Nullable key, NSError * _Nullable error);

@protocol NAHKeyProviding <NSObject>

- (void)provideKeyInBlock:(NAHKeyProviderBlock)block;

@end

NS_ASSUME_NONNULL_END
