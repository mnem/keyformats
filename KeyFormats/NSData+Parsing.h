//
//  NSData+Parsing.h
//  KeyFormats
//
//  Created by David Wagner on 29/06/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Parsing)

/// Converts a hex string into data.
///
/// Malformed data isn't handled terribly well.
///
/// @param hexString the hex string to convert
+ (instancetype)dataFromHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
