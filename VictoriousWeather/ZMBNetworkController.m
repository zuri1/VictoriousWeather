//
//  ZMBNetworkController.m
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/18/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import "ZMBNetworkController.h"

@interface ZMBNetworkController () <NSURLSessionDelegate>

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

- (void)downloadWeatherData {
    NSURL *downloadURL = [NSURL URLWithString:@"http://www.myweather2.com/developer/forecast.ashx?uac=KDrRbvwbAt&output=json&query=97006&temp_unit=f"];
    [self downloadDataFromURL:downloadURL withCompletionHandler:^(NSData *data) {
        if (data != nil) {
            
            NSError *error;
//            NSDictionary *weatherDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            } else {
              
                /*
                self.weatherDict = [weatherDict objectForKey:@"weather"];
                NSString *temperatureValue = [[self.weatherDict objectForKey:@"curren_weather"][0] objectForKey:@"temp"];
                self.temperature.text = [NSString stringWithFormat:@"%@F", temperatureValue];
                self.weatherDescription.text = [[self.weatherDict  objectForKey:@"curren_weather"][0] objectForKey:@"weather_text"];
                 */
            }
        }
    }];
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
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(data);
        }];
    }];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
}


@end
