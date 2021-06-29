//
//  RSAKeyParser.h
//  KeyFormats
//
//  Created by David Wagner on 29/06/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSAKeyParser : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (nullable SecKeyRef)newSecKeyWithModulus:(NSData *)modulus exponent:(NSData *)exponent error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
