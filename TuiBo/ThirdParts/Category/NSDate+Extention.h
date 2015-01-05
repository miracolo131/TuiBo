//
//  NSDate+Extention.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/11/20.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extention)

/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;


@end
