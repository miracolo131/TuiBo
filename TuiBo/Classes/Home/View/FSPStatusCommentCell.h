//
//  FSPStatusCommentCell.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/21.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSPCommentFrame;

@interface FSPStatusCommentCell : UITableViewCell

@property (nonatomic, retain) FSPCommentFrame *commentFrame;

@property (nonatomic,retain) UIImageView *avatarView;
/** 昵称 */
@property (nonatomic,retain) UILabel *nameLabel;
/** 时间 */
@property (nonatomic,retain) UILabel *timeLabel;
/** 正文\内容 */
@property (nonatomic,retain) UILabel *contentLabel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
