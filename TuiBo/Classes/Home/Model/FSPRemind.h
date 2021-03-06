//
//  FSPRemind.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//
//  消息未读数返回数据结构
//  字段详细说明：http://open.weibo.com/wiki/%E5%B8%B8%E8%A7%81%E8%BF%94%E5%9B%9E%E5%AF%B9%E8%B1%A1%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84#.E6.B6.88.E6.81.AF.E6.9C.AA.E8.AF.BB.E6.95.B0.EF.BC.88remind.EF.BC.89

#import <Foundation/Foundation.h>

@interface FSPRemind : NSObject

@property (nonatomic, assign) int status;
@property (nonatomic, assign) int follower;
@property (nonatomic, assign) int cmt;
@property (nonatomic, assign) int dm;
@property (nonatomic, assign) int metion_status;
@property (nonatomic, assign) int mention_cmt;
@property (nonatomic, assign) int group;
@property (nonatomic, assign) int private_group;
@property (nonatomic, assign) int notice;
@property (nonatomic, assign) int invite;
@property (nonatomic, assign) int badge;
@property (nonatomic, assign) int photo;
@property (nonatomic, assign) int msgbox;

@end
