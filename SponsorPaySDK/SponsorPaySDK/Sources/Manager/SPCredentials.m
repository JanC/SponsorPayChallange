//
// Created by Jan on 28/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPCredentials.h"


@interface SPCredentials ()
@property(nonatomic, copy, readwrite) NSString *applicationId;
@property(nonatomic, copy, readwrite) NSString *userId;
@property(nonatomic, copy, readwrite) NSString *apiKey;
@end

@implementation SPCredentials {

}
- (instancetype)initWithApplicationId:(NSString *)applicationId userId:(NSString *)userId apiKey:(NSString *)apiKey {
    self = [super init];
    if (self) {
        self.applicationId = applicationId;
        self.userId = userId;
        self.apiKey = apiKey;
    }

    return self;
}

@end