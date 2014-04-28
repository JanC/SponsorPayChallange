//
// Created by Jan on 28/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SPCredentials : NSObject

@property(nonatomic, copy, readonly) NSString *applicationId;
@property(nonatomic, copy, readonly) NSString *userId;
@property(nonatomic, copy, readonly) NSString *apiKey;

- (instancetype)initWithApplicationId:(NSString *)applicationId userId:(NSString *)userId apiKey:(NSString *)apiKey;

@end