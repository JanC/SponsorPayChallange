//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPJSONDataParser.h"
#import "SPOfferResponse.h"

@implementation SPJSONDataParser {

}
- (SPOfferResponse *)parseOfferListResponse:(NSData *)data
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

    SPOfferResponse *response = [[SPOfferResponse alloc] initWithDictionary:json];

    return response;
}

@end