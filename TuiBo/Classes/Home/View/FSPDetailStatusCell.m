//
//  FSPDetailStatusCell.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/21.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPDetailStatusCell.h"
//#import ""
@interface FSPDetailStatusCell ()

@property (nonatomic, assign, readonly) CGRect avatarViewFrame;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelFrame;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelFrame;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelFrame;

@end

@implementation FSPDetailStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


@end
