//
//  FSPDetailViewController.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSPStatus;
@class FSPStatusFrame;

@interface FSPDetailViewController : UITableViewController

@property (nonatomic, retain) FSPStatus *status;
@property (nonatomic, retain) FSPStatusFrame *statusFrame;
@property (nonatomic, retain) NSString *urlStr;
@property (nonatomic, retain) NSString *uidStr;
@property (nonatomic, retain) NSString *idStr;
@end
