//
//  LALoginController.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/2/28.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LALoginController.h"
#import "LATabBarController.h"

@interface LALoginController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation LALoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - 登录注册事件

- (IBAction)login:(UIButton *)sender {
    NSLog(@"开始登录");
    
    LATabBarController *tabbarVc = [[LATabBarController alloc] init];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = tabbarVc;
}

- (IBAction)registe:(UIButton *)sender {
}


#pragma mark - 代理事件

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

@end
