//
//  ZMBWeatherModel.h
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/18/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMBWeatherModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *todaysTemperature;
@property (nonatomic, strong) NSString *todaysWeatherDescription;

@property (nonatomic, strong) NSString *tomorrowsTemperature;
@property (nonatomic, strong) NSString *tomorrowsWeatherDescription;

- (id)initWithJSONDict:(NSDictionary *)JSONDict;

@end
