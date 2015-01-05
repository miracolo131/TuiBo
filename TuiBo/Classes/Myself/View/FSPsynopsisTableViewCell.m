//
//  FSPsynopsisTableViewCell.m
//  TuiBo
//
//  Created by Tonfan on 14/12/13.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPsynopsisTableViewCell.h"

@implementation FSPsynopsisTableViewCell
-(void)dealloc
{
    [_headPortrait release];
    [_nameLabel release];
    [_genderLable release];
    [_cityLabel release];
    [_areaLabel release];
    [_weboNumabeLabel release];
    [_attentionLable release];
    [_fansLabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setSubViews];
    }
    return self;
}
-(void)setSubViews
{

    
    
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
