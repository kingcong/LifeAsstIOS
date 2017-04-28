//
//  UIBarButtonItem+Extension.h
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/5.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image andSelectedImage:(NSString *)selectedImage andAction:(SEL)action andTarget:(id)target;

@end
