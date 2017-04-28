//
//  CWCommonItem.m
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/18.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import "CWCommonItem.h"

@implementation CWCommonItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    // 这里是self
    CWCommonItem * item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}

@end
