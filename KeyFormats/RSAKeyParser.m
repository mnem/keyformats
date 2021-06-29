//
//  RSAKeyParser.m
//  KeyFormats
//
//  Created by David Wagner on 29/06/2021.
//

#import "RSAKeyParser.h"
#import "NSMutableData+TLV.h"

@implementation RSAKeyParser

+ (SecKeyRef)newSecKeyWithModulus:(NSData *)modulus exponent:(NSData *)exponent error:(NSError **)error {
    NSMutableData *der = [NSMutableData dataWithCapacity:modulus.length + exponent.length + 14];
    
    // Prefix the modulus with 0 to indicate a positive number
    NSMutableData *encodedModulus = [NSMutableData dataWithCapacity:modulus.length + 1];
    const uint8_t zeroByte = 0;
    [encodedModulus appendBytes:&zeroByte length:1];
    [encodedModulus appendData:modulus];
    
    // Encode the DER INTEGERS
    NSMutableData *derIntegers = [NSMutableData data];
    [derIntegers appendTLVWithTag:0x02 value:encodedModulus];
    [derIntegers appendTLVWithTag:0x02 value:exponent];
    
    // Encode the DER SEQUENCE
    [der appendTLVWithTag:0x30 value:derIntegers];
    
    // Create the SecKeyRef
    NSDictionary *attributes = @{
        (id)kSecAttrKeyType: (id)kSecAttrKeyTypeRSA,
        (id)kSecAttrKeyClass: (id)kSecAttrKeyClassPublic,
        (id)kSecAttrKeySizeInBits: @(modulus.length * 8),
    };
    
    CFErrorRef creationError = NULL;
    SecKeyRef key = SecKeyCreateWithData((__bridge CFDataRef)der, (__bridge CFDictionaryRef)attributes, &creationError);
    if (key == NULL) {
        if (error != NULL) {
            *error = CFBridgingRelease(creationError);
        } else {
            CFRelease(creationError);
        }
        
        return NULL;
    } else {
        return key;
    }
}

@end
