//
// Created by Jan Chaloupecky on 29/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (SPUIError)

+ (void)SPShowGenericError;
+ (void)SPShowErrorWithTitle:(NSString *)title message:(NSString *) message;

@end