//
//  UtilsHeader.h
//  Faith in life
//
//  Created by allan on 16/7/21.
//  Copyright © 2016年 Xindun. All rights reserved.
//

#ifndef UtilsHeader_h
#define UtilsHeader_h


//屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


//设备分类
#define iPhone4s  [UIScreen mainScreen].bounds.size.height == 480
#define iPhone5  [UIScreen mainScreen].bounds.size.height == 568
#define iPhone6  [UIScreen mainScreen].bounds.size.height == 667
#define iPhone6Plus  [UIScreen mainScreen].bounds.size.height == 736

//随机色
#define kColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)];

#define HexRGBColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//字体颜色
#define kBorderColor [[UIColor colorWithRed:105 /255.0 green:105 /255.0 blue:105 /255.0 alpha:1.0]CGColor]

//背景颜色
#define kBackColor [UIColor colorWithRed:240 /255.0 green:239 /255.0 blue:244 /255.0 alpha:1.0]

//Page颜色
#define kPageCurrentColor [[UIColor colorWithRed:255.0 /255.0 green:158.0 /255.0 blue:4.0 /255.0 alpha:1.0]CGColor]

//字体
#define kFontWithSize(Size) [UIFont systemFontOfSize:Size]
#define kBoldFontWithSize(Size) [UIFont boldSystemFontOfSize:Size]

//iOS7系统
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//通知中心
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//偏好设置
#define kNSUserDefaults [NSUserDefaults standardUserDefaults]

// 颜色改变
#define App_Color 10

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



//#define APP_PAGE_COLOR                  RGBACOLOR(243.0,244.0,245.0,1.0)
#define APP_PAGE_COLOR                  UIColorFromRGB(0xEFEFF4)
#define APP_LINE_COLOR                  UIColorFromRGB(0xC8C7CC)
#define APP_Button_COLOR                RGBACOLOR(243.0,157.0,58.0,1.0)

#define APP_THEME_COLOR_NORMAL          RGBACOLOR(102, 102, 102, 1.0)
#define APP_THEME_COLOR                 UIColorFromRGB(0xFE8000)
#define APP_THEME_COLOR_HIGHLIGHT       UIColorFromRGB(0xE07100)
#define COLOR_TEXT_I                    UIColorFromRGB(0x323232)


/***** 设备信息 *****/

#define kWindowWidth   [UIApplication sharedApplication].keyWindow.frame.size.width
#define kWindowHeight  [UIApplication sharedApplication].keyWindow.frame.size.height

#define SCREEN_MAX_LENGTH (MAX(kWindowWidth, kWindowHeight))

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4  (fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON)
#define IS_IPHONE_5  (fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON)
#define IS_IPHONE_6  (fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)


#endif /* UtilsHeader_h */
