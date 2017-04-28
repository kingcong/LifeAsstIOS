//
//  WKWebViewController.h
//  Faith in life
//
//  Created by 王聪 on 16/4/27.
//  Copyright © 2016年 allan. All rights reserved.
//


@interface WKWebViewController : UIViewController

/** 链接 */
@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) BOOL isHideToolbar;

- (instancetype)initWithUrlStr:(NSString *)urlStr;


@end
