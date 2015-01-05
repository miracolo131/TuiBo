//
//  FSPDetailStatusCell.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/21.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSPCommentFrame;

@interface FSPDetailStatusCell : UITableViewCell

@property (nonatomic, retain) FSPCommentFrame *commentFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
