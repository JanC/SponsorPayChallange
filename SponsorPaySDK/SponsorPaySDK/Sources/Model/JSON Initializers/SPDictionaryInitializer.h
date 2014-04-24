//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPDictionaryInitializer <NSObject>

@required

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end