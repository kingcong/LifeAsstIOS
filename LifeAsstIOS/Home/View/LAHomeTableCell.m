//
//  LAHomeTableCell.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/18.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LAHomeTableCell.h"

@implementation LAHomeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSplitModel:(LASplitModel *)splitModel
{
    _splitModel = splitModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:splitModel.thumbnail_pic_s]];
    self.titleLab.text = splitModel.title;
    self.timeLab.text = splitModel.date;
}

@end
