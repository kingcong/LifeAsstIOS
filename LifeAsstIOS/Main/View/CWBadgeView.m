//
//  CWBadgeView.m
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/18.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import "CWBadgeView.h"

@implementation CWBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
//        [self setBackgroundImage:[UIImage resizedImage:@"main_badge"] forState:UIControlStateNormal];
        // 按钮的高度就是背景图片的高度
        self.height = self.currentBackgroundImage.size.height;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    // 根据文字计算自己的尺寸
    CGSize titleSize = [badgeValue sizeWithFont:self.titleLabel.font];
    CGFloat bgW = self.currentBackgroundImage.size.width;
    if (titleSize.width < bgW) {
        self.width = bgW;
    } else {
        self.width = titleSize.width + 10;
    }
}

@end
