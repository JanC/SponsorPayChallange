//
//  SponsorPaySDKParserTests.m
//  SponsorPaySDKParserTests
//
//  Created by Jan on 23/04/14.
//  Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SPDataParser.h"
#import "SPJSONDataParser.h"
#import "SPOfferResponse.h"
#import "SPOfferResponseInformation.h"
#import "SPOffer.h"
#import "SPURLGenerator.h"

@interface SPURLGenerator (Protected)

extern NSString *const SPURLOffersParamAppId;
extern NSString *const SPURLOffersParamUid;
extern NSString *const SPURLOffersParamLocale;
extern NSString *const SPURLOffersParamOsVersion;
extern NSString *const SPURLOffersParamTimeStamp;

@end

@interface SponsorPaySDKNetworkTests : XCTestCase

@end

@implementation SponsorPaySDKNetworkTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGenerateURL
{
    //
    // Generate the URL parameters and check that all required parameters are present.
    // We do not check for actual values
    //


    SPURLGenerator *urlGenerator = [[SPURLGenerator alloc] initWithApplicationId:@"MyAppId" userId:@"MyUserId" apiKey:@"MyAPIKey" signer:nil ];

    NSDictionary *customParameters = @{
            @"myCustomKey" : @"myCustomValue"
    };

    NSString *generatedURL = [urlGenerator offersURLWithParameters:customParameters];

    XCTAssert(generatedURL, @"Generated URL must not be nil");

    NSLog(@"generatedURL = %@", generatedURL);


    //
    // Check
    //
    NSArray *expectedKeys = @[@"myCustomKey", SPURLOffersParamAppId, SPURLOffersParamUid, SPURLOffersParamLocale, SPURLOffersParamOsVersion, SPURLOffersParamTimeStamp];

    [expectedKeys enumerateObjectsUsingBlock:^(NSString * parameterKey, NSUInteger idx, BOOL *stop) {

        NSString *urlParam =  [NSString stringWithFormat:@"%@=", parameterKey];
        XCTAssert( [generatedURL rangeOfString:urlParam].location != NSNotFound , @"%@ must be present in the generated URL", urlParam);

    }];

}

@end
