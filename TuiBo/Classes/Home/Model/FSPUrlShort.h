//
//  FSPUrlShort.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//  短链 对象返回数据结构
//  字段详情：http://open.weibo.com/wiki/%E5%B8%B8%E8%A7%81%E8%BF%94%E5%9B%9E%E5%AF%B9%E8%B1%A1%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84#.E7.9F.AD.E9.93.BE.EF.BC.88url_short.EF.BC.89

#import <Foundation/Foundation.h>

@interface FSPUrlShort : NSObject

@property (nonatomic, copy) NSString *url_short;
@property (nonatomic, copy) NSString *url_long;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) BOOL result;

@end
