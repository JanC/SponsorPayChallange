//
// Created by Jan Chaloupecky on 29/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "NSError+SPError.h"

NSString * const SPErrorDomain = @"SPErrorDomain";

@implementation NSError (SPError)


+ (instancetype)errorWithSPCode:(SPErrorCode)errorCode;
{
    // if the error message plist hasn't been loaded yet, do it now


    NSString *errorMessageKey = [NSString stringWithFormat:@"error_%d", errorCode];

    NSString *message = NSLocalizedString(errorMessageKey, @"Error codes from the plist file");

    NSError *error = [NSError errorWithDomain:SPErrorDomain
                                         code:errorCode
                                     userInfo:@{ NSLocalizedDescriptionKey : message }];
    return error;
}




@end