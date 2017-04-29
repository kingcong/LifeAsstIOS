//
//  LAHelpViewController.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/29.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LAHelpViewController.h"

@interface LAHelpViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;



@end

@implementation LAHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)commitInfo:(UIButton *)sender {
    if (self.textView.text.length == 0) {
        [MBProgressHUD sr_showErrorWithMessage:@"请填写信息"];
        return;
    }
    
//    [MBProgressHUD sr_showMessage:@"我们已收到您的请求，谢谢！"];
    [MBProgressHUD sr_showSuccessWithMessage:@"我们已收到您的请求，谢谢！"];
    self.textView.text = nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textView endEditing:YES];
}


@end
