//
//  LASplitViewCell.h
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/28.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LASplitModel.h"

@interface LASplitViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@property (weak, nonatomic) IBOutlet UILabel *authorLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@property (nonatomic, strong) LASplitModel *splitModel;

+ (instancetype)splitView;


@end
