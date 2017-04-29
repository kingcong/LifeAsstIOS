//
//  LASplitViewCell.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/28.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LASplitViewCell.h"

@implementation LASplitViewCell

+ (instancetype)splitView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSplitModel:(LASplitModel *)splitModel
{
    _splitModel = splitModel;
    
    self.titleLab.text = splitModel.title == nil ? @"中国科学技术大学苏州研究院" : splitModel.title;
    
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:splitModel.thumbnail_pic_s]];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:splitModel.thumbnail_pic_s02]];
    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:splitModel.thumbnail_pic_s03]];

    if (splitModel.author_name == nil || splitModel.author_name.length == 0) {
        self.authorLab.text = @"王聪";
    } else{
        self.authorLab.text = splitModel.author_name;
    }
    self.timeLab.text = splitModel.date;
}

@end
