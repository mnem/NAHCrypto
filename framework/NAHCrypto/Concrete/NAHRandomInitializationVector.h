//
//  NAHRandomInitializationVector.h
//  NAHCrypto
//
//  Created by David Wagner on 07/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAHInitializationVectorGenerating.h"

NS_ASSUME_NONNULL_BEGIN

@interface NAHRandomInitializationVector : NSObject <NAHInitializationVectorGenerating>

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithVectorByteLength:(NSUInteger)vectorByteLength;

@end

NS_ASSUME_NONNULL_END
