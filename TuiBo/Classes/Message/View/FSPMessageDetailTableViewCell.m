//
//  FSPMessageDetailTableViewCell.m
//  TuiBo
//
//  Created by 逄 on 14/12/14.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPMessageDetailTableViewCell.h"

@implementation FSPMessageDetailTableViewCell

-(void)dealloc
{
    [_nameLabel release];
    [_created_atLabel release];
    [_bmiddle_picView release];
    [_avatar_largeImageView release];
    [_myTextLabel release];
    [_contentLabel release];
    [_myNameLabel release];
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
    _myTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 40, 235, 70) ];
    _myTextLabel.font = [UIFont systemFontOfSize:15];
    _myTextLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_myTextLabel];
    _avatar_largeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 45, 45)];
    [self.contentView addSubview:_avatar_largeImageView];
    _bmiddle_picView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 120, 100, 82)];
    [self.contentView addSubview:_bmiddle_picView];
    
    _myNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 120, 200, 15)];
    _myNameLabel.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:_myNameLabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 135, 200, 67)];
    _contentLabel.font = [UIFont systemFontOfSize:12.5];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    

    
}
- (void)setMyTextLabelText:(NSString *)text
{
    CGRect frame = [self frame];
    self.myTextLabel.text = text;
    self.myTextLabel.numberOfLines = 1000;
    CGSize size = CGSizeMake(235, 10000);
//    UIFont *font = self.myTextLabel.font;
//    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self.myTextLabel.text];
//    self.myTextLabel.text = attrStr;
//    NSRange range = NSMakeRange(0, attrStr.length);
//    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    CGSize labelSize = [self.myTextLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSAttachmentAttributeName: [UIFont systemFontOfSize:15]} context:nil].size;
    self.myTextLabel.frame = CGRectMake(self.myTextLabel.frame.origin.x, self.myTextLabel.frame.origin.y, labelSize.width,labelSize.height);
    frame.size.height = labelSize.height;
    self.frame = frame;
    
}

//+ (CGFloat) myTextHeight:(NSString *)text
//{
//    NSDictionary *textDic = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
//    CGRect textRect = [text boundingRectWithSize:CGSizeMake(235, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
//    
//    return textRect.size.height;
//    
//}
//+(CGFloat)cellHeight
//{
//    CGFloat unchangeHeight = 130;
//    CGFloat textHeight =
//    return 210;
//}
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
