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

@interface SponsorPaySDKParserTests : XCTestCase

@end

@implementation SponsorPaySDKParserTests

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

- (void)testParseJSON
{
    id<SPDataParser> dataParser = [[SPJSONDataParser alloc] init];
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"response" ofType:@"json"];

    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:0 error:nil];

    SPOfferResponse *offerResponse = [dataParser parseOfferListResponse:[NSData dataWithContentsOfFile:path]];

    XCTAssert(offerResponse, @"%@ must parse a non nil %@", NSStringFromClass([dataParser class]), NSStringFromClass([SPOfferResponse class]));

    //
    // Check
    //
    NSDictionary *modelDictionary = json;
    XCTAssertEqualObjects(modelDictionary[@"code"], offerResponse.code, @"should be equal");
    XCTAssertEqualObjects(modelDictionary[@"message"], offerResponse.message, @"should be equal");
    XCTAssertTrue([modelDictionary[@"count"] integerValue] == offerResponse.count, @"should be equal");
    XCTAssertTrue([modelDictionary[@"pages"] integerValue] == offerResponse.pages, @"should be equal");

    //
    // Check SPOfferResponseInformation properties
    //
    modelDictionary = json[@"information"];
    XCTAssertEqualObjects(modelDictionary[@"app_name"], offerResponse.information.appName, @"should be equal");
    XCTAssertEqualObjects(modelDictionary[@"appid"], offerResponse.information.appId, @"should be equal");
    XCTAssertEqualObjects(modelDictionary[@"virtual_currency"], offerResponse.information.virtualCurrency, @"should be equal");
    XCTAssertEqualObjects(modelDictionary[@"country"], offerResponse.information.country, @"should be equal");
    XCTAssertEqualObjects(modelDictionary[@"language"], offerResponse.information.language, @"should be equal");

    //
    // Check the offers count
    //
    NSArray *jsonOffersArray = json[@"offers"];
    XCTAssertTrue(jsonOffersArray.count == offerResponse.offers.count, @"should be equal");

    [offerResponse.offers enumerateObjectsUsingBlock:^(SPOffer * offer, NSUInteger idx, BOOL *stop) {
        NSDictionary *offerDictionary = jsonOffersArray[idx];
        XCTAssertEqualObjects(offerDictionary[@"title"], offer.title, @"should be equal");
        XCTAssertEqualObjects(offerDictionary[@"teaser"], offer.teaser, @"should be equal");
        XCTAssertEqualObjects(offerDictionary[@"required_action"], offer.requiredActions, @"should be equal");
    }];

}

@end
