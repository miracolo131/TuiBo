//
//  FSPUser.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//  用户返回对象数据结构
//  详细字段见：http://open.weibo.com/wiki/%E5%B8%B8%E8%A7%81%E8%BF%94%E5%9B%9E%E5%AF%B9%E8%B1%A1%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84#.E7.94.A8.E6.88.B7.EF.BC.88user.EF.BC.89

#import <Foundation/Foundation.h>
@class FSPStatus;

@interface FSPUser : NSObject
//{
//    long long _id;
//}
//@property (nonatomic, assign) long long ID;
//@property (nonatomic, copy) NSString *idstr;
//@property (nonatomic, copy) NSString *screen_name;
//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, assign) int province;
//@property (nonatomic, assign) int city;
//@property (nonatomic, copy) NSString *location;
//@property (nonatomic, copy) NSString *description;
//@property (nonatomic, copy) NSString *url;
//@property (nonatomic, copy) NSString *profile_image_url;
//@property (nonatomic, copy) NSString *profile_url;
//@property (nonatomic, copy) NSString *domain;
//@property (nonatomic, copy) NSString *weihao;
//@property (nonatomic, copy) NSString *gender;
//@property (nonatomic, assign) int followers_count;
//@property (nonatomic, assign) int friends_count;
//@property (nonatomic, assign) int statuses_count;
//@property (nonatomic, assign) int favourites_count;
//@property (nonatomic, copy) NSString *create_at;
//@property (nonatomic, assign) BOOL allow_all_act_msg;
//@property (nonatomic, assign) BOOL geo_enabled;
//@property (nonatomic, assign) BOOL verified;
//@property (nonatomic, copy) NSString *remark;
//
//// object status 用户的最近一条微博信息字段
//@property (nonatomic, retain) FSPStatus *status;
//
//@property (nonatomic, assign) BOOL allow_all_comment;
//@property (nonatomic, copy) NSString *avatar_large;
//@property (nonatomic, copy) NSString *avatar_hd;
//@property (nonatomic, copy) NSString *verified_reason;
//@property (nonatomic, assign) BOOL follow_me;
//@property (nonatomic, assign) int online_status;
//@property (nonatomic, assign) BOOL bi_followers_count;
//@property (nonatomic, copy) NSString *lang;

/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;
/**
 *  是否为vip
 */
@property (nonatomic, assign, getter = isVip) BOOL vip;

/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  会员类型
 */
@property (nonatomic, assign) int mbtype;


+ (instancetype)userWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
