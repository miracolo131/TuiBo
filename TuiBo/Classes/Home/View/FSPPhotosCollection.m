//
//  FSPPhotosCollection.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/21.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPPhotosCollection.h"
#import "FSPPhotoView.h"
#import "FSPPhoto.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

#define FSPPhotoWidth 70
#define FSPPhotoHeight 70
#define FSPPhotoBorder 10

@implementation FSPPhotosCollection

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 最多9个图片
        for (int i = 0; i<9; i++) {
            FSPPhotoView *photoView = [[FSPPhotoView alloc] init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)photoTap:(UITapGestureRecognizer *)recognizer
{
    //    DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"哈哈" contentText:@"废话速度快回家繁华的时刻分开后" leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
    //    [alertView show];
    //
    int count = self.photos.count;
    
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        
        mjphoto.srcImageView = self.subviews[i]; // 来源于哪个UIImageView
        
        FSPPhoto *photo = self.photos[i];
        NSString *photoUrl = [photo.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recognizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    for (int i = 0; i<self.subviews.count; i++) {
        // 取出i位置对应的imageView
        FSPPhotoView *photoView = self.subviews[i];
        
        // 判断这个imageView是否需要显示数据
        if (i < photos.count) {
            // 显示图片
            photoView.hidden = NO;
            
            // 传递模型数据
            photoView.photo = photos[i];
            
            // 设置子控件的frame
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (FSPPhotoWidth + FSPPhotoBorder);
            CGFloat photoY = row * (FSPPhotoHeight + FSPPhotoBorder);
            photoView.frame = CGRectMake(photoX, photoY, FSPPhotoWidth, FSPPhotoHeight);
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        } else { // 隐藏imageView
            photoView.hidden = YES;
        }
    }
}

+ (CGSize)photosViewSizeWithPhotosCount:(int)count
{
    // 一行最多有3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //  总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * FSPPhotoHeight + (rows - 1) * FSPPhotoBorder;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    // 宽度
    CGFloat photosW = cols * FSPPhotoWidth + (cols - 1) * FSPPhotoBorder;
    
    return CGSizeMake(photosW, photosH);
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
