//
//  FSPStatusCell.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/20.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSPStatusFrame;

@interface FSPStatusCell : UITableViewCell

@property (nonatomic, retain) FSPStatusFrame *statusFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
