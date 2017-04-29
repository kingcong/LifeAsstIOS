//
//  LAWeatherModel.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/29.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LAWeatherModel.h"

@implementation LAWeatherModel

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.imageName = dict[@"imageName"];
        self.tmp = dict[@"tmp"];
        self.code = dict[@"code"];
        self.txt = dict[@"txt"];
        self.pm25 = dict[@"pm25"];
        self.qlty = dict[@"qlty"];
        self.weathercode = dict[@"weathercode"];
    }
    return  self;
}

@end
