//
// Created by Jan Chaloupecky on 29/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "NSError+SPUIError.h"

@implementation NSError (SPUIError)

+ (NSString *)SPGenericTitle {
    return  NSLocalizedString(@"error default title", nil);
}
+ (NSString *)SPGenericMessage {
    return NSLocalizedString(@"error default text", nil);
}

+ (void)SPShowGenericError {
    [self SPShowErrorWithTitle:[self SPGenericTitle] message:[self SPGenericMessage]];
}

+ (void)SPShowErrorWithTitle:(NSString *)title message:(NSString *) message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alertView show];
    });

}
@end