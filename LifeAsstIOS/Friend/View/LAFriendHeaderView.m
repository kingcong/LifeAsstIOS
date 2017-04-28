//
//  LAFriendHeaderView.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/28.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LAFriendHeaderView.h"

@implementation LAFriendHeaderView


+ (instancetype)headerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
