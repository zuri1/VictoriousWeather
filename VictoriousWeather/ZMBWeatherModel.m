//
//  ZMBWeatherModel.m
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/18/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import "ZMBWeatherModel.h"


@implementation ZMBWeatherModel

- (id)init {
    if (self = [super init]) {
        self.todaysTemperature = _todaysTemperature;
        self.todaysWeatherDescription = _todaysWeatherDescription;
        self.tomorrowsTemperature = _tomorrowsTemperature;
        self.tomorrowsWeatherDescription = _tomorrowsWeatherDescription;
    }
    return self;
}

- (id)initWithJSONDict:(NSDictionary *)JSONDict {

    NSDictionary *todaysWeather = [[JSONDict objectForKey:@"weather"] objectForKey:@"curren_weather"][0];
    
    NSDictionary *tomorrowsWeather = [[JSONDict objectForKey:@"weather"] objectForKey:@"forecast"][1];
    
    if (self = [super init]) {
        self.todaysTemperature = [todaysWeather objectForKey:@"temp"];
        self.todaysWeatherDescription = [todaysWeather objectForKey:@"weather_text"];
        self.tomorrowsTemperature = [tomorrowsWeather objectForKey:@"day_max_temp"];
        self.tomorrowsWeatherDescription = [[tomorrowsWeather objectForKey:@"day"][0] objectForKey:@"weather_text"];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.todaysTemperature = [aDecoder decodeObjectForKey:@"todaysTemperature"];
        self.todaysWeatherDescription = [aDecoder decodeObjectForKey:@"todaysWeatherDescription"];
        self.tomorrowsTemperature = [aDecoder decodeObjectForKey:@"tomorrowsTemperature"];
        self.tomorrowsWeatherDescription = [aDecoder decodeObjectForKey:@"tomorrowsWeatherDescription"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    if (self.todaysTemperature != nil) [aCoder encodeObject:self.todaysTemperature forKey:@"todaysTemperature"];
    if (self.todaysWeatherDescription != nil) [aCoder encodeObject:self.todaysWeatherDescription forKey:@"todaysWeatherDescription"];
    if (self.tomorrowsTemperature != nil) [aCoder encodeObject:self.tomorrowsTemperature forKey:@"tomorrowsTemperature"];
    if (self.tomorrowsWeatherDescription != nil) [aCoder encodeObject:self.tomorrowsWeatherDescription forKey:@"tomorrowsWeatherDescription"];
}

@end
