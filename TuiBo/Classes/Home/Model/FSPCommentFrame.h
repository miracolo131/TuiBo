//
//  FSPCommentFrame.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/21.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FSPComment;

/** 昵称的字体 */
#define FSPCommentNameFont [UIFont systemFontOfSize:13]

/** 时间的字体 */
#define FSPSCommentTimeFont [UIFont systemFontOfSize:12]
/** 正文字体 */
#define FSPCommentContentFont [UIFont systemFontOfSize:13]

/** cell的边框宽度 */
#define FSPCommentCellBorder 10

/** 表格的边框宽度 */
#define FSPCommentTableBorder 10


@interface FSPCommentFrame : NSObject

@property (nonatomic, retain) FSPComment *comment;

@property (nonatomic, assign, readonly) CGRect avatarViewFrame;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelFrame;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelFrame;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelFrame;
/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;


@end
