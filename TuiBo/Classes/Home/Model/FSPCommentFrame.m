//
//  FSPCommentFrame.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/21.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPCommentFrame.h"
#import "FSPComment.h"
#import "FSPUser.h"

@implementation FSPCommentFrame

- (void)setComment:(FSPComment *)comment
{
    _comment = comment;
    
    // cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 2 * FSPCommentCellBorder;
    
    // 2.头像
    CGFloat avatarViewWH = 35;
    CGFloat avatarViewX = FSPCommentCellBorder;
    CGFloat avatarViewY = FSPCommentCellBorder;
    _avatarViewFrame = CGRectMake(avatarViewX, avatarViewY, avatarViewWH, avatarViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_avatarViewFrame) + FSPCommentCellBorder;
    CGFloat nameLabelY = avatarViewY;
#warning sizeWithFont 7.0被弃
    CGSize nameLabelSize = [comment.user.name sizeWithFont:FSPCommentNameFont];
    _nameLabelFrame = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 5.时间
    
#warning sizeWithFont 7.0被弃
    CGSize timeLabelSize = [comment.created_at sizeWithFont:FSPSCommentTimeFont];
    CGFloat timeLabelX = cellWidth - timeLabelSize.width - FSPCommentCellBorder;
    CGFloat timeLabelY = avatarViewY;
    _timeLabelFrame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    
    // 7.微博正文内容
    CGFloat contentLabelX = nameLabelX;
    CGFloat contentLabelY = CGRectGetMaxY(_nameLabelFrame) + FSPCommentCellBorder;
    CGFloat contentLabelMaxWidth = cellWidth - 2 * FSPCommentCellBorder;
#warning sizeWithFont 7.0被弃
    CGSize contentLabelSize = [comment.text sizeWithFont:FSPCommentContentFont constrainedToSize:CGSizeMake(contentLabelMaxWidth, MAXFLOAT)];
//    _contentLabelFrame = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    _contentLabelFrame = CGRectMake(contentLabelX, contentLabelY, 250, contentLabelSize.height);
    
    // 计算cell的高度
    _cellHeight = CGRectGetMaxY(_contentLabelFrame) + 20 ;
}


@end
