//
//  NSMutableData+TLV.h
//  KeyFormats
//
//  Created by David Wagner on 29/06/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableData (TLV)

- (void)appendTLVWithTag:(uint8_t)tag value:(NSData *)value;

@end

NS_ASSUME_NONNULL_END
