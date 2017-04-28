//
//  LAHomeHeaderView.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/18.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LAHomeHeaderView.h"
#import "XMGPageView.h"

@implementation LAHomeHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self addScrollPageView];
}

- (void)addScrollPageView
{
    
    XMGPageView *pageView = [XMGPageView pageView];
    pageView.frame = CGRectMake(0, 0, kScreenWidth, 150);
    pageView.imageNames = @[@"img_00", @"img_01", @"img_02", @"img_03", @"img_04"];
    pageView.otherColor = [UIColor grayColor];
    pageView.currentColor = [UIColor orangeColor];
    [self.pageView addSubview:pageView];
}


- (IBAction)btnClickWeather:(UIButton *)sender {
    [self tapThisView];
}


- (void)tapThisView {
    NSLog(@"ffff");
    if ([self.delegate respondsToSelector:@selector(tapHeaderView)]) {
        [self.delegate tapHeaderView];
    }
}

+ (instancetype)headerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)lifestyleClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(styleClick:)]) {
        [self.delegate styleClick:sender.tag];
    }
}


@end
