//
//  ZMBNetworkController.h
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/18/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZMBWeatherModel;

@protocol WeatherDataDelegate <NSObject>

- (void)updateWeather;

@end

typedef void (^ZMBDownloadCompletion)(ZMBWeatherModel *data, NSError *error);

@interface ZMBNetworkController : NSObject

// In the absence of further information about this program, I've decided the simplest solution
// to temporarily store weather information is in a property on this network controller
@property (nonatomic, strong) ZMBWeatherModel *weatherModel;
@property (nonatomic, weak) id<WeatherDataDelegate>delegate;

+ (ZMBNetworkController *)sharedController;

- (void)startTimer;
- (void)downloadData;

@end
