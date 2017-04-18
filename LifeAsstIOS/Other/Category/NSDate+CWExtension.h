//
//  NSDate+CWExtension.h
//  
//
//  Created by kingcong on 16/2/5.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (CWExtension)

/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;


@end
