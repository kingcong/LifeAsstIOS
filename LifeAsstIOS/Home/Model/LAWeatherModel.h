//
//  LAWeatherModel.h
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/29.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LAWeatherModel : NSObject

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *tmp;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *txt;

@property (nonatomic, copy) NSString *pm25;

@property (nonatomic, copy) NSString *qlty;

@property (nonatomic, copy) NSString *weathercode;

- (id)initWithDict:(NSDictionary *)dict;

@end
