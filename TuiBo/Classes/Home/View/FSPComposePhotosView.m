//
//  FSPComposePhotosView.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/22.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPComposePhotosView.h"

@implementation FSPComposePhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat imageViewWidth = 70;
    CGFloat imageViewHeight = imageViewWidth;
    int maxColumns = 4; // 一行最多显示4张图片
    CGFloat margin = (self.frame.size.width - maxColumns * imageViewWidth) / (maxColumns + 1);
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        
        CGFloat imageViewX = margin + (i % maxColumns) * (imageViewWidth + margin);
        CGFloat imageViewY = (i / maxColumns) * (imageViewHeight + margin);
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewWidth, imageViewHeight);
    }
}

- (NSArray *)totalImages
{
    NSMutableArray *images = [NSMutableArray array];
    
    for (UIImageView *imageView in self.subviews) {
        [images addObject:imageView.image];
    }
    
    return images;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
