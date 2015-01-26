//
//  ZMBNetworkController.m
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/18/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import "ZMBNetworkController.h"
#import "ZMBWeatherModel.h"

@interface ZMBNetworkController () <NSURLSessionDelegate>

@property (strong, nonatomic) NSTimer *myTimer;

@end

@implementation ZMBNetworkController

+ (ZMBNetworkController *)sharedController {
    static dispatch_once_t pred;
    static ZMBNetworkController *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[ZMBNetworkController alloc] init];
        NSLog(@"alloc'ed and init'ed a ZMBNetwork Controller");
    });
    
    return shared;
}

- (void)startTimer {
    self.myTimer = [NSTimer timerWithTimeInterval:1800 target:self selector:@selector(downloadDataFromURL:withCompletionHandler:) userInfo:nil repeats:YES];
    
}

- (void)downloadWeatherDataWithCompletion:(ZMBDownloadCompletion)completion {
    
    
    
}

- (void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void (^)(NSData *data))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
            NSLog(@"HTTP status code %ld", (long)HTTPStatusCode);
        }
        
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        //ZMBWeatherModel *weatherModel = [[ZMBWeatherModel alloc] initWithJSONDict:JSON];
        self.weatherModel = [[ZMBWeatherModel alloc] initWithJSONDict:JSON];
        //self.weatherModel = weatherModel;
    
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.delegate updateWeatherWithModel:self.weatherModel];
            
            
        }];
    }];
    [dataTask resume];
}

- (ZMBWeatherModel *)dataFromJSON:(NSDictionary *)JSON {
   
    NSDictionary *myJSON = [[NSDictionary alloc] initWithDictionary:JSON];
    NSArray *currentWeather = [[NSArray alloc] initWithArray:[myJSON objectForKey:@"curren_weather"]];
    
    
//    NSNumber *currentTemperature = [currentWeather valueForKey:@"temp"];
   
    
    ZMBWeatherModel *weatherModel = [[ZMBWeatherModel alloc] init];
//    weatherModel.currentTemperature = currentTemperature;
    
    
    return weatherModel;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
}


@end
