//
//  LALoginController.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/2/28.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LALoginController.h"
#import "LATabBarController.h"

#import "WSLoginView.h"

@interface LALoginController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation LALoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WSLoginView *wsLoginV = [[WSLoginView alloc]initWithFrame:self.view.bounds];
    wsLoginV.titleLabel.text = @"高教区生活助手";
    wsLoginV.titleLabel.textColor = [UIColor grayColor];
    wsLoginV.hideEyesType = AllEyesHide;
    [self.view addSubview:wsLoginV];
    
    [wsLoginV setClickBlock:^(NSString *textField1Text, NSString *textField2Text) {
        
        if ([textField1Text  isEqual: @"wangcong"] && [textField2Text  isEqual: @"123456"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"userName" forKey:@"wangcong"];
            [[NSUserDefaults standardUserDefaults] setObject:@"password" forKey:@"123456"
            ];
            
            LATabBarController *tabbarVc = [[LATabBarController alloc] init];
            
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            keyWindow.rootViewController = tabbarVc;
        } else {
            [MBProgressHUD sr_showErrorWithMessage:@"用户名或密码错误，请重新输入"];
        }
        

    }];
}

#pragma mark - 登录注册事件

- (IBAction)login:(UIButton *)sender {
    NSLog(@"开始登录");
    
    if ([self.userTextField.text  isEqual: @"wangcong"] && [self.passwordTextField.text  isEqual: @"123456"]) {
        LATabBarController *tabbarVc = [[LATabBarController alloc] init];
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        keyWindow.rootViewController = tabbarVc;
    } else {
        [MBProgressHUD sr_showErrorWithMessage:@"用户名或密码错误，请重新输入"];
    }
   
}

- (IBAction)registe:(UIButton *)sender {
}


#pragma mark - 代理事件

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

@end
