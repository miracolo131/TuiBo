//
//  FSPComment.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//  评论对象返回数据结构
//  详细字段说明:http://open.weibo.com/wiki/%E5%B8%B8%E8%A7%81%E8%BF%94%E5%9B%9E%E5%AF%B9%E8%B1%A1%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84#.E8.AF.84.E8.AE.BA.EF.BC.88comment.EF.BC.89


#import <Foundation/Foundation.h>
@class FSPUser;
@class FSPStatus;

@interface FSPComment : NSObject
{
    long long _id;
}
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, assign) long long ID;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, retain) FSPUser *user;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, retain) FSPStatus *status;

#warning 需要补齐
// object reply_comment

@end
