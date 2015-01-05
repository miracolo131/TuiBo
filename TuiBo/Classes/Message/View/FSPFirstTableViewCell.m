//
//  FSPFirstTableViewCell.m
//  TuiBo
//
//  Created by 逄 on 14/12/19.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPFirstTableViewCell.h"

@implementation FSPFirstTableViewCell
-(void)dealloc
{
    [_nameLabel release];
    [_created_atLabel release];
    [_bmiddle_picView release];
    [_avatar_largeImageView release];
    [_myTextLabel release];
    [_contentLabel release];
    [_myNameLabel release];
    [_userNameLabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 10, 100, 15)];
    _nameLabel.font = [UIFont systemFontOfSize:12.5];
    [self.contentView addSubview:_nameLabel];
    _created_atLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 35, 155, 15)];
    _created_atLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:_created_atLabel];
    _myTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 40, 235, 50) ];
    _myTextLabel.font = [UIFont systemFontOfSize:15];
    _myTextLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_myTextLabel];
    _avatar_largeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 45, 45)];
    [self.contentView addSubview:_avatar_largeImageView];
    _bmiddle_picView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 100, 82)];
    [self.contentView addSubview:_bmiddle_picView];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 100, 100, 20)];
    _userNameLabel.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:_userNameLabel];
    
    _myNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 100, 200, 15)];
    _myNameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentLabel addSubview:_myNameLabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 120, 200, 67)];
    _contentLabel.font = [UIFont systemFontOfSize:12.5];
    _contentLabel.numberOfLines = 0;
    _myNameLabel.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_contentLabel];
    
    
    
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
