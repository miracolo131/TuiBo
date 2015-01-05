//
//  FSPMessageTableViewCell.m
//  TuiBo
//
//  Created by 逄 on 14/12/13.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPMessageTableViewCell.h"

@implementation FSPMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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
