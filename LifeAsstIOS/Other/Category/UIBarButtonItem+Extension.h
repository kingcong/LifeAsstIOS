//
//  UIBarButtonItem+Extension.h
//  
//
//  Created by kingcong on 16/2/2.
//
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
