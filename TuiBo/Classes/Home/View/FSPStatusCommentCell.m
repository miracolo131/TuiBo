//
//  FSPStatusCommentCell.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/21.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPStatusCommentCell.h"
#import "FSPCommentFrame.h"
#import "FSPComment.h"
#import "UIImage+Resize.h"
#import "UIImageView+WebCache.h"
#import "FSPUser.h"

@implementation FSPStatusCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupCommentSubviews];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"comment";
    FSPStatusCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FSPStatusCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupCommentSubviews
{
    
    /** 2.头像 */
    UIImageView *avatarView = [[UIImageView alloc] init];
    [self.contentView addSubview:avatarView];
    self.avatarView = avatarView;
    
    /** 5.昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = FSPCommentNameFont;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 6.时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = FSPSCommentTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 8.正文\内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = FSPCommentContentFont;
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += FSPCommentTableBorder;
    frame.origin.x = FSPCommentTableBorder;
    frame.size.width -= 2 * FSPCommentTableBorder;
    frame.size.height -= FSPCommentTableBorder;
    [super setFrame:frame];
}


/**
 *  传递模型数据
 */
- (void)setCommentFrame:(FSPCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    
    [self setupStatusCommentData];
}

- (void)setupStatusCommentData
{
    FSPComment *comment = self.commentFrame.comment;
    FSPUser *user = comment.user;
    
    // 2.头像
    [self.avatarView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.avatarView.frame = self.commentFrame.avatarViewFrame;
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.commentFrame.nameLabelFrame;
    
    // 5.时间
    self.timeLabel.text = comment.created_at;
    self.timeLabel.frame = self.commentFrame.timeLabelFrame;
    
    // 7.正文
    self.contentLabel.text = comment.text;
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.frame = self.commentFrame.contentLabelFrame;
    
    
}




- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
