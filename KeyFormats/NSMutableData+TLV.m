//
//  NSMutableData+TLV.m
//  KeyFormats
//
//  Created by David Wagner on 29/06/2021.
//

#import "NSMutableData+TLV.h"

@implementation NSMutableData (TLV)

- (void)appendTLVWithTag:(uint8_t)tag value:(NSData *)value {
    [self appendBytes:&tag length:1];
    
    // Work out if we can use the short form
    uint64_t valueLength = value.length;
    if (valueLength < 128) {
        uint8_t length = (uint8_t)(valueLength & 0x7f);
        [self appendBytes:&length length:1];
    } else {
        // Dang, we have to use long form
        
        // Append the byte encoding the length bytes, uh, length
        uint8_t lengthBytesCount = (uint8_t)(log2((double)valueLength) / 8) + 1;
        uint8_t encodedLengthBytesCount = lengthBytesCount | 0x80;
        [self appendBytes:&encodedLengthBytesCount length:1];

        // Append the length bytes
        uint8_t *lengthBytes = calloc(lengthBytesCount, 1);
        for (size_t i = 0; i < lengthBytesCount; i++) {
            lengthBytes[lengthBytesCount - i - 1] = (uint8_t)(valueLength & 0xff);
            valueLength >>= 8;
        }
        [self appendBytes:lengthBytes length:lengthBytesCount];
        free(lengthBytes);
    }
    
    // Finally, append the value
    [self appendData:value];
}

@end
