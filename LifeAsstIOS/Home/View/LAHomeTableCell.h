//
//  LAHomeTableCell.h
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/18.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LASplitModel.h"

@interface LAHomeTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@property (nonatomic, strong) LASplitModel *splitModel;

@end
