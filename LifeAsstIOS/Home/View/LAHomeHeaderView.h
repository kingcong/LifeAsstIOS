//
//  LAHomeHeaderView.h
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/18.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LAHomeHeaderViewDelegate <NSObject>

- (void)tapHeaderView;

- (void)styleClick:(NSInteger)type;

@end

@interface LAHomeHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIView *pageViewClick;

@property (assign, nonatomic) id<LAHomeHeaderViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *pageView;


+ (instancetype)headerView;


@end
