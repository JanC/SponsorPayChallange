//
// Created by Jan on 26/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPSHA1Signer.h"
#include <CommonCrypto/CommonDigest.h>


@implementation SPSHA1Signer {

}
- (NSString *)signText:(NSString *)text withSecretToken:(NSString *)token {

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

- (NSString *)calculateSHA1forString:(NSString *)text {
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [text dataUsingEncoding:NSUTF8StringEncoding];

    if (CC_SHA1([stringBytes bytes], (CC_LONG) [stringBytes length], digest)) {
        NSMutableString *hexDigest = [NSMutableString stringWithCapacity:10];

        /* SHA-1 hash has been calculated and stored in 'digest'. */
        for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
            [hexDigest appendString:[NSString stringWithFormat:@"%02x", digest[i]]];
        }
        return hexDigest;
    }
    return nil;
}

@end