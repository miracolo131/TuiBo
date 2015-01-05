//
//  FSPMessageDetailTableViewCell.h
//  TuiBo
//
//  Created by 逄 on 14/12/14.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSPMessageDetailTableViewCell : UITableViewCell

//内容图片
@property(nonatomic,retain)UIImageView *bmiddle_picView;
//头像
@property(nonatomic,retain)UIImageView *avatar_largeImageView;

//评论用户名
@property(nonatomic,retain)UILabel *nameLabel;
//账户
@property(nonatomic,retain)UILabel *myNameLabel;

//shijian
@property(nonatomic,retain)UILabel *created_atLabel;

//评论内容
@property(nonatomic,retain)UILabel *myTextLabel;

//微博内容
@property(nonatomic,retain)UILabel *contentLabel;



//+(CGFloat)cellHeight;
- (void)setMyTextLabelText:(NSString *)text;
@end
