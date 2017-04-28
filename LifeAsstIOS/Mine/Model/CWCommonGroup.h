//
//  CWCommonGroup.h
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/18.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWCommonGroup : NSObject

// 头
@property (nonatomic,copy)NSString * header;

// 尾
@property (nonatomic,copy)NSString * footer;

// 这组的模型数组
@property (nonatomic,strong)NSArray * items;

+ (instancetype)group;

@end
