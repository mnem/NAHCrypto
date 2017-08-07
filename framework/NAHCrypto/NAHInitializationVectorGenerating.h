//
//  NAHInitializationVectorProviding.h
//  NAHCrypto
//
//  Created by David Wagner on 07/08/2017.
//  Copyright © 2017 David Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NAHInitializationVectorGenerating <NSObject>

- (nullable NSData *)generateWithError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
