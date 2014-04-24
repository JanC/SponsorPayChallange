//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOfferResponseInformation.h"

@implementation SPOfferResponseInformation {

}
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];

    if (self)
    {
        _appName = dictionary[@"app_name"];
        _appId = dictionary[@"appid"];
        _virtualCurrency = dictionary[@"virtual_currency"];
        _country = dictionary[@"country"];
        _language = dictionary[@"language"];
        _supportURL = dictionary[@"support_url"] ? [NSURL URLWithString:dictionary[@"support_url"]] : nil;

    }

    return self;
}
@end