//
//  LAHomeHeaderView.h
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/18.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LAWeatherModel.h"

@protocol LAHomeHeaderViewDelegate <NSObject>

- (void)tapHeaderView;

- (void)styleClick:(NSInteger)type;

@end

@interface LAHomeHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIView *pageViewClick;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UILabel *currentTemp;

@property (weak, nonatomic) IBOutlet UILabel *airQuality;

@property (weak, nonatomic) IBOutlet UILabel *cityLab;


@property (weak, nonatomic) IBOutlet UILabel *locationLab;

@property (weak, nonatomic) IBOutlet UILabel *airStateLab;

@property (weak, nonatomic) IBOutlet UIImageView *airImageView;


@property (assign, nonatomic) id<LAHomeHeaderViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *pageView;

@property (nonatomic, strong) LAWeatherModel *weatherModel;


+ (instancetype)headerView;


@end
