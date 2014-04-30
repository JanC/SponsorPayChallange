//
// Created by Jan on 26/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPSHA1Signer.h"
#include <CommonCrypto/CommonDigest.h>

@implementation SPSHA1Signer
{
}

- (NSString *)signText:(NSString *)text withSecretToken:(NSString *)token
{

    NSAssert(token, @"The token must be supplied.");

    token = token ? token : @""; // safety

    // append the secret token to the text to be signed and make the hash

    // Concatenate the resulting string with & and the API Key handed out to you by SponsorPay.
    NSString *stringForDigest = [NSString stringWithFormat:@"%@&%@", text, token];
    return [self calculateSHA1forString:stringForDigest];
}

- (BOOL)signatureValid:(NSString *)signature forText:(NSString *)text secretToken:(NSString *)token
{
    NSString *calculatedSignature = [self signText:text withSecretToken:token];
    return [signature isEqualToString:calculatedSignature];
}

#pragma mark - Private

- (NSString *)calculateSHA1forString:(NSString *)string
{

    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(data.bytes, data.length, digest);

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }

    return output;
}

@end