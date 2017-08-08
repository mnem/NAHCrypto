//
//  NAHAESCryptor.h
//  NAHCrypto
//
//  Created by David Wagner on 03/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAHCryptor.h"
#import "NAHKeyProviding.h"
#import "NAHIVGenerating.h"

@interface NAHAESCryptor : NSObject <NAHCryptor>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithKeyProvider:(id<NAHKeyProviding>)keyProvider initializationVectorGenerator:(id<NAHIVGenerating>)ivGenerator;

@end
