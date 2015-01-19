//
//  ZMBNetworkController.h
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/18/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMBNetworkController : NSObject

+ (ZMBNetworkController *)sharedController;

- (void)downloadWeatherData;

@end
