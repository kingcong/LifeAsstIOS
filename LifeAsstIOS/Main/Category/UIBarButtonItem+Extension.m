//
//  UIBarButtonItem+Extension.m
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/5.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image andSelectedImage:(NSString *)selectedImage andAction:(SEL)action andTarget:(id)target
{
    UIButton * rightBtn = [[UIButton alloc] init];
    [rightBtn setBackgroundImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageWithName:selectedImage] forState:UIControlStateHighlighted];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    rightBtn.size = rightBtn.currentBackgroundImage.size;
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    return rightBtnItem;
}

@end
