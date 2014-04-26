//
// Created by Jan on 26/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPSigner <NSObject>

@required

/**
 *
 * HASH(text+token)
 */

/**
 *   Creates a HASH of the supplied text concatenated with the secret token
 *
 *  @param text  the text to be signed
 *  @param token the secret token
 *
 *  @return HASH(text+token)
 */
- (NSString *)signText:(NSString *)text withSecretToken:(NSString *)token;


/**
 * Verifies the supplied signature.
 *
 *  @param signature to verify
 *  @param text      text used for verification
 *  @param token     token used for verification
 *
 *  @return YES if signature = HASH(text+token)
 */
- (BOOL)signatureValid:(NSString *)signature forText:(NSString *)text secretToken:(NSString *)token;

@end