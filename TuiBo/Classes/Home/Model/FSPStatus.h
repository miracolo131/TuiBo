//
//  FSPStatus.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//  微博返回对象数据结构
//  详细字段见：http://open.weibo.com/wiki/%E5%B8%B8%E8%A7%81%E8%BF%94%E5%9B%9E%E5%AF%B9%E8%B1%A1%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84#.E5.BE.AE.E5.8D.9A.EF.BC.88status.EF.BC.89

#import <Foundation/Foundation.h>
@class FSPGeo;
@class FSPUser;

@interface FSPStatus : NSObject
//{
//    long long _id;
//}
//@property (nonatomic, copy) NSString *created_at;
//@property (nonatomic, assign) long long ID;
//@property (nonatomic, assign) long long mid;
//@property (nonatomic, copy) NSString *idstr;
//@property (nonatomic, copy) NSString *text;
//@property (nonatomic, copy) NSString *source;
//@property (nonatomic, assign) BOOL favorited;
//@property (nonatomic, assign) BOOL truncated;
//@property (nonatomic, copy) NSString *thumbnail_pic;
//@property (nonatomic, copy) NSString *bmiddle_pic;
//@property (nonatomic, copy) NSString *original_pic;
//@property (nonatomic, assign) int reposts_count;
//@property (nonatomic, assign) int comments_count;
//@property (nonatomic, assign) int attitudes_count;
//
//@property (nonatomic, retain)FSPGeo *geo;
//@property (nonatomic, retain)FSPUser *user;
//
//#warning 需要补齐
//// object retweeted_status
//@property (nonatomic, retain)FSPStatus *retweeted_status;
//// object visible
//// object pic_urls
//// object arrary ad


// 微博的内容
@property (nonatomic, copy) NSString *text;
/**
 *  微博的时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  微博的单张配图
 */
@property (nonatomic, copy) NSString *thumbnail_pic;

/**
 *  多张配图
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  微博的作者
 */
@property (nonatomic, strong) FSPUser *user;
/**
 *  被转发的微博
 */
@property (nonatomic, strong) FSPStatus *retweeted_status;

+ (instancetype)statusWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
