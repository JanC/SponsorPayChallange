//
// Created by Jan on 23/04/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "SPOfferClient.h"
#import "SPDataParser.h"
#import "SPJSONDataParser.h"
#import "SPOfferResponse.h"
#import "SPURLGenerator.h"

#pragma mark - Constants

// http://api.sponsorpay.com/feed/v1/offers.json?appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186 &ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&uid=player1 &timestamp=1312471066&hashkey=7a2b1604c03d46eec1ecd4a686787b75dd693c4d

NSString *const SPOfferClientBaseURL = @"http://api.sponsorpay.com/feed/v1/offers.json";

@interface SPOfferClient ()

@property(nonatomic, copy, readwrite) NSString *applicationId;
@property(nonatomic, copy, readwrite) NSString *userId;
@property(nonatomic, copy, readwrite) NSString *apiKey;

@property(nonatomic, strong) NSURLSession *urlSession;

@property(nonatomic, strong) id <SPDataParser> dataParser;
@property (nonatomic, strong) SPURLGenerator *urlGenerator;
@end

@implementation SPOfferClient {

}

#pragma mark - Public

- (instancetype)initWithApplicationId:(NSString *)applicationId userId:(NSString *)userId apiKey:(NSString *)apiKey
{
    self = [super init];

    if (self)
    {
        self.applicationId = applicationId;
        self.userId = userId;
        self.apiKey = apiKey;

        //
        // Setup network
        //
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];

        //
        // Setup parse
        //
        self.dataParser = [[SPJSONDataParser alloc] init];

        //
        // Setup URL Generator and response verifier
        //
        self.urlGenerator = [[SPURLGenerator alloc] initWithApplicationId:applicationId userId:userId apiKey:apiKey];

    }

    return self;
}

- (NSURLSessionTask *)listOffersWithCustomParameter:(NSDictionary *)customParameters completion:(SPOfferCompletionBlock)completion
{


    //
    // prepare request
    //
    NSString *parametersString = [self.urlGenerator offersURLWithParameters:customParameters];
    NSURL *requestUrl = [NSURL URLWithString: [NSString stringWithFormat:@"%@?%@", SPOfferClientBaseURL, parametersString]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:requestUrl];
    //
    // send request
    //

    NSURLSessionTask *sessionTask = [self.urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"Received HTTP %d", httpResponse.statusCode);
        if (httpResponse.statusCode == 200)
        {
            SPOfferResponse * offerResponse = [self.dataParser parseOfferListResponse:data];
            if(completion)
            {
                completion(offerResponse);
            }
        }
        else
        {
            NSLog(@"HTTP error %@", error);
            //
            // Handle known error code
            //
        }
    }];

    [sessionTask resume];

    return sessionTask;

}

#pragma mark
#pragma mark - Delegates

#pragma mark
#pragma mark - Private

@end