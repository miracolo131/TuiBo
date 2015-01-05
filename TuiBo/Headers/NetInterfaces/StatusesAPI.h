//
//  StatusesAPI.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/12.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#ifndef TuiBo_StatusesAPI_h
#define TuiBo_StatusesAPI_h

#pragma mark -------- 读取接口
//statuses/public_timeline	获取最新的公共微博
//statuses/friends_timeline	获取当前登录用户及其所关注用户的最新微博
//statuses/home_timeline	获取当前登录用户及其所关注用户的最新微博
//statuses/friends_timeline/ids	获取当前登录用户及其所关注用户的最新微博的ID
//statuses/user_timeline	获取用户发布的微博
//statuses/user_timeline/ids	获取用户发布的微博的ID
//
//statuses/repost_timeline	返回一条原创微博的最新转发微博
//statuses/repost_timeline/ids	获取一条原创微博的最新转发微博的ID
//statuses/mentions	获取@当前用户的最新微博
//statuses/mentions/ids	获取@当前用户的最新微博的ID
//statuses/bilateral_timeline	获取双向关注用户的最新微博
//statuses/show	根据ID获取单条微博信息
//
//statuses/querymid	通过id获取mid
//statuses/queryid	通过mid获取id
//statuses/count	批量获取指定微博的转发数评论数
//statuses/go	根据ID跳转到单条微博页
//emotions	获取官方表情
#define kStatuses_public_timeline @"https://api.weibo.com/2/statuses/public_timeline.json"
#define kStatuses_friends_timeline @"https://api.weibo.com/2/statuses/friends_timeline.json"
#define kStatuses_home_timeline @"https://api.weibo.com/2/statuses/home_timeline.json"
#define kStatuses_friends_timeline_ids @"https://api.weibo.com/2/statuses/friends_timeline/ids.json"
#define kStatuses_user_timeline @"https://api.weibo.com/2/statuses/user_timeline.json"
#define kStatuses_user_timeline_ids @"https://api.weibo.com/2/statuses/user_timeline/ids.json"
#define kStatuses_repost_timeline @"https://api.weibo.com/2/statuses/repost_timeline.json"
#define kStatuses_repost_timeline_ids @"https://api.weibo.com/2/statuses/repost_timeline/ids.json"
#define kStatuses_mentions @"https://api.weibo.com/2/statuses/mentions.json"
#define kStatuses_mentions_ids @"https://api.weibo.com/2/statuses/mentions/ids.json"
#define kStatuses_bilateral_timeline @"https://api.weibo.com/2/statuses/bilateral_timeline.json"
#define kStatuses_show @"https://api.weibo.com/2/statuses/show.json"
#define kStatuses_querymid @"https://api.weibo.com/2/statuses/querymid.json"
#define kStatuses_queryid @"https://api.weibo.com/2/statuses/queryid.json"
#define kStatuses_count @"https://api.weibo.com/2/statuses/count.json"
#define kStatuses_go @"https://api.weibo.com/2/statuses/go.json"
#define kStatuses_emotions @"https://api.weibo.com/2/statuses/emotions.json"

#pragma mark -------- 写入接口
//statuses/repost	转发一条微博信息
//statuses/destroy	删除微博信息
//statuses/update	发布一条微博信息
//statuses/upload	上传图片并发布一条微博

#define kStatuses_repost @"https://api.weibo.com/2/statuses/repost.json"
#define kStatuses_destroy @"https://api.weibo.com/2/statuses/destroy.json"
#define kStatuses_update @"https://api.weibo.com/2/statuses/update.json"
#define kStatuses_upload @"https://api.weibo.com/2/statuses/upload.json"

#endif
