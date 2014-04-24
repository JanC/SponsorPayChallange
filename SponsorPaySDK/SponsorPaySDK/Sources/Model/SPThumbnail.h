//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPDictionaryInitializer.h"


@interface SPThumbnail : NSObject <SPDictionaryInitializer>

@property (nonatomic, strong, readonly) NSURL* lowresURL;
@property (nonatomic, strong, readonly) NSURL* highresURL;

@end