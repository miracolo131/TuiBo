//
//  FSPStatusFrame.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/20.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 昵称的字体 */
#define FSPStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define FSPRetweetStatusNameFont FSPStatusNameFont

/** 时间的字体 */
#define FSPStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define FSPStatusSourceFont FSPStatusTimeFont

/** 正文字体 */
#define FSPStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define FSPRetweetStatusContentFont FSPStatusContentFont

/** cell的边框宽度 */
#define FSPStatusCellBorder 5

/** 表格的边框宽度 */
#define FSPStatusTableBorder 5

@class FSPStatus;

@interface FSPStatusFrame : NSObject

@property (nonatomic, retain) FSPStatus *status;

/** 顶部的view */
//@property (nonatomic, assign, readonly) CGRect topViewFrame;
@property (nonatomic, assign, readonly) CGRect statusViewFrame;
/** 头像 */
//@property (nonatomic, assign, readonly) CGRect iconViewFrame;
@property (nonatomic, assign, readonly) CGRect avatarViewFrame;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewFrame;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photoViewFrame;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelFrame;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelFrame;
/** 来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelFrame;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelFrame;

/** 被转发微博的view(父控件) */
@property (nonatomic, assign, readonly) CGRect retweetViewFrame;
/** 被转发微博作者的昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelFrame;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelFrame;
/** 被转发微博的配图 */
@property (nonatomic, assign, readonly) CGRect retweetPhotoViewFrame;

/** 微博的工具条 */
//@property (nonatomic, assign, readonly) CGRect statusToolbarFrame;
@property (nonatomic, assign, readonly) CGRect moreBarFrame;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
