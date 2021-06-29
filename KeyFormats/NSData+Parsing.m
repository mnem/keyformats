//
//  NSData+Parsing.m
//  KeyFormats
//
//  Created by David Wagner on 29/06/2021.
//

#import "NSData+Parsing.h"

@implementation NSData (Parsing)

+ (instancetype)dataFromHexString:(NSString *)hexString {
    NSMutableData *data = [NSMutableData dataWithCapacity:hexString.length / 2 + 1]; // Will overallocate if even but 🤷‍♂️
    NSUInteger current = 0;
    uint8_t partValue = 0;
    char conversionBuffer[3] = {0};
    
    // We're converting to data 1 byte at a time. If we cared about efficiency
    // it would be better to convert as a single bytes until the remainder of the
    // hexstring can be walked a word at a time. Or you could be really fancy
    // and convert in the largest sub-word size steps to get to where you want
    // but it's getting a little silly at that point - there are better algorithms
    // to use.
    if (hexString.length & 0x01) {
        current = 1;
        conversionBuffer[0] = '0';
        conversionBuffer[1] = [hexString characterAtIndex:0];
        partValue = (uint8_t)(strtol(conversionBuffer, NULL, 16) & 0xff);
        [data appendBytes:&partValue length:1];
    }
    
    while (current < hexString.length) {
        conversionBuffer[0] = [hexString characterAtIndex:current];
        current++;
        conversionBuffer[1] = [hexString characterAtIndex:current];
        current++;
        
        partValue = (uint8_t)(strtol(conversionBuffer, NULL, 16) & 0xff);
        [data appendBytes:&partValue length:1];
    }
    
    return [data copy];
}

@end
