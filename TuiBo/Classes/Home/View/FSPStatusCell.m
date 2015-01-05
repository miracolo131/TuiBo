//
//  FSPStatusCell.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/20.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPStatusCell.h"
#import "FSPStatusFrame.h"
#import "FSPStatus.h"
#import "FSPUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Resize.h"
#import "FSPMoreBar.h"

@interface FSPStatusCell ()

/** 顶部的view */
//@property (nonatomic, retain) UIImageView *topView;
@property (nonatomic, retain) UIImageView *statusView;
/** 头像 */
//@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, retain) UIImageView *avatarView;
/** 会员图标 */
@property (nonatomic, retain) UIImageView *vipView;
/** 配图 */
@property (nonatomic, retain) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, retain) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, retain) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, retain) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, retain) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, retain) UIImageView *retweetView;
/** 被转发微博作者的昵称 */
@property (nonatomic, retain) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, retain) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, retain) UIImageView *retweetPhotoView;

/** 微博的工具条 */
//@property (nonatomic, retain) UIImageView *statusToolbar;
@property (nonatomic, retain) FSPMoreBar *moreBar;

@end

@implementation FSPStatusCell

- (void)dealloc
{
    [_statusFrame release];
    
    [_statusView release];
    [_avatarView release];
    [_vipView release];
    [_photoView release];
    [_nameLabel release];
    [_timeLabel release];
    [_sourceLabel release];
    [_contentLabel release];
    [_photoView release];
    
    [_retweetNameLabel release];
    [_retweetContentLabel release];
    [_retweetPhotoView release];
    [_retweetView release];
    
    [_moreBar release];
    
    [super dealloc];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    FSPStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FSPStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // 1.添加原创微博内部的子控件
//        [self setupOriginalSubviews];
        [self setupStatusSubviews];
        
        // 2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        
        // 3.添加微博的工具条
//        [self setupStatusToolBar];
//        [self setupMoreBar];
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupStatusSubviews
{
    /** 1.顶部的view */
    UIImageView *statusView = [[UIImageView alloc] init];
    statusView.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
    [self.contentView addSubview:statusView];
    self.statusView = statusView;
    
    /** 2.头像 */
    UIImageView *avatarView = [[UIImageView alloc] init];
    [self.statusView addSubview:avatarView];
    self.avatarView = avatarView;
    
    /** 3.会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.statusView addSubview:vipView];
    self.vipView = vipView;
    
    /** 4.配图 */
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.statusView addSubview:photoView];
    self.photoView = photoView;
    
    /** 5.昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = FSPStatusNameFont;
    [self.statusView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 6.时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = FSPStatusTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.statusView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 7.来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = FSPStatusSourceFont;
    sourceLabel.textColor = [UIColor grayColor];
    sourceLabel.backgroundColor = [UIColor clearColor];
    [self.statusView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 8.正文\内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = FSPStatusContentFont;
    [self.statusView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

/**
 *  添加被转发微博内部的子控件
 */
- (void)setupRetweetSubviews
{
    /** 1.被转发微博的view(父控件) */
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
    [self.statusView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 2.被转发微博作者的昵称 */
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.font = FSPRetweetStatusNameFont;
    retweetNameLabel.textColor = [UIColor colorWithRed:67/255.0 green:107.0/255.0 blue:163.0/255.0 alpha:1.0];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    /** 3.被转发微博的正文\内容 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = FSPRetweetStatusContentFont;
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1.0];
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 4.被转发微博的配图 */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 *  添加微博的工具条
 */
- (void)setupMoreBar
{
    /** 1.微博的工具条 */
//    UIImageView *moreBar = [[UIImageView alloc] init];
//    moreBar.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
    /** 微博的工具条 */
    FSPMoreBar *moreBar = [[FSPMoreBar alloc] init];
    [self.contentView addSubview:moreBar];
    self.moreBar = moreBar;
    self.moreBar.frame = self.statusFrame.moreBarFrame;
}

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += FSPStatusTableBorder;
    frame.origin.x = FSPStatusTableBorder;
    frame.size.width -= 2 * FSPStatusTableBorder;
    frame.size.height -= FSPStatusTableBorder;
    [super setFrame:frame];
}


/**
 *  传递模型数据
 */
- (void)setStatusFrame:(FSPStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.原创微博
    [self setupStatusData];
    
    // 2.被转发微博
    [self setupRetweetData];
}

/**
 *  原创微博
 */
- (void)setupStatusData
{
    FSPStatus *status = self.statusFrame.status;
    FSPUser *user = status.user;
    NSLog(@"username = %@", status.user.name);
    
    // 1.topView
    self.statusView.frame = self.statusFrame.statusViewFrame;
    
    // 2.头像
    [self.avatarView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.avatarView.frame = self.statusFrame.avatarViewFrame;
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelFrame;
    
    // 4.vip
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:@"common_icon_membership"];
        self.vipView.frame = self.statusFrame.vipViewFrame;
    } else {
        self.vipView.hidden = YES;
    }
    
    // 5.时间
//    self.timeLabel.text = status.created_at;
//    self.timeLabel.frame = self.statusFrame.timeLabelFrame;
    self.timeLabel.text = status.created_at;
    NSLog(@"timelabel = %@", status.created_at);
//    self.timeLabel.text = @"dfdfd";
    CGFloat timeLabelX = self.statusFrame.nameLabelFrame.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelFrame) + FSPStatusCellBorder * 0.5;
    CGSize timeLabelSize = [status.created_at sizeWithFont:FSPStatusTimeFont];
//    CGSize timeLabelSize = [status.created_at sizeWithAttributes:[NSDictionary dictionaryWithObject:FSPStatusTimeFont forKey:NSFontAttributeName]];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    self.timeLabel.frame = CGRectMake(timeLabelX, timeLabelY, 50, 30);
    
//    // 6.来源
//    NSString *sourceText = [[NSString alloc] init];
//    int loc = [status.source rangeOfString:@">"].location + 1;
//    int length = [status.source rangeOfString:@"</"].location - loc;
//    NSLog(@"loc = %d, length = %d, %@", loc, length, sourceText);
////    sourceText = [status.source substringWithRange:NSMakeRange(loc, length)];
//    NSLog(@"loc = %d, length = %d, %@", loc, length, sourceText);
//    status.source = sourceText;
//    //    self.sourceLabel.text = [NSString stringWithFormat:@"来自 %@", sourceText];
////    self.sourceLabel.text = [NSString stringWithFormat:@"来自 %@", status.source];
//    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + FSPStatusCellBorder;
//    CGFloat sourceLabelY = timeLabelY;
//    CGSize sourceLabelSize = [sourceText sizeWithFont:FSPStatusSourceFont];
////    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
//#warning 来源宽度无法计算，固定写死
//    self.sourceLabel.frame = CGRectMake(sourceLabelX, sourceLabelY, 200, sourceLabelSize.height);
    // 6.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + FSPStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:FSPStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};

    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelFrame;
    
    // 8.配图
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewFrame;
        [self.photoView setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    } else {
        self.photoView.hidden = YES;
    }

}

/**
 *  被转发微博
 */
- (void)setupRetweetData
{
    FSPStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    FSPUser *user = retweetStatus.user;
    
    // 1.父控件
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewFrame;
        
        // 2.昵称
//        self.retweetNameLabel.text = user.name;
        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelFrame;
        
        // 3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelFrame;
        
        // 4.配图
        if (retweetStatus.thumbnail_pic) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewFrame;
            [self.retweetPhotoView setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        } else {
            self.retweetPhotoView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
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
