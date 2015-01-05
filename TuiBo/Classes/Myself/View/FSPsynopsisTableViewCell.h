//
//  FSPsynopsisTableViewCell.h
//  TuiBo
//
//  Created by Tonfan on 14/12/13.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSPsynopsisTableViewCell : UITableViewCell
@property(nonatomic,retain)UIImageView *headPortrait;//头像
@property(nonatomic,retain)UILabel *nameLabel;//昵称
@property(nonatomic,retain)UILabel *genderLable;//性别
@property(nonatomic,retain)UILabel *cityLabel;//城市
@property(nonatomic,retain)UILabel *areaLabel;//区

@property(nonatomic,retain)UILabel *weboNumabeLabel;//微博数量
@property(nonatomic,retain)UILabel *attentionLable;//关注数量
@property(nonatomic,retain)UILabel *fansLabel;//粉丝数量
@end
