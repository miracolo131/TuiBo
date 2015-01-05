//
//  FSPPrivacy.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//  隐私设置返回数据结构
//  详细字段说明：http://open.weibo.com/wiki/%E5%B8%B8%E8%A7%81%E8%BF%94%E5%9B%9E%E5%AF%B9%E8%B1%A1%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84#.E9.9A.90.E7.A7.81.E8.AE.BE.E7.BD.AE.EF.BC.88privacy.EF.BC.89

#import <Foundation/Foundation.h>

@interface FSPPrivacy : NSObject

@property (nonatomic, assign) int comment;
@property (nonatomic, assign) int geo;
@property (nonatomic, assign) int message;
@property (nonatomic, assign) int realname;
@property (nonatomic, assign) int badge;
@property (nonatomic, assign) int mobile;
@property (nonatomic, assign) int webim;

@end
