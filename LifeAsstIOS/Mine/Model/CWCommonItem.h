//
//  CWCommonItem.h
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/18.
//  Copyright (c) 2015年 王聪. All rights reserved.
// 用一个CWCommonItem模型来描述一个Cell的标题,右边的样式

#import <Foundation/Foundation.h>

@interface CWCommonItem : NSObject

// 图标
@property (nonatomic,copy)NSString * icon;
// 标题
@property (nonatomic,copy)NSString * title;
// 子标题
@property (nonatomic,copy)NSString * subtitle;
// 右边的数字标记
@property (nonatomic,copy)NSString * badgeValue;
// 点击这行跳转的控制器
@property (nonatomic,assign)Class destVcClass;
// 封装这行Cell想做的事情
@property (nonatomic,copy) void (^operation)();


+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

+ (instancetype)itemWithTitle:(NSString *)title;

@end
