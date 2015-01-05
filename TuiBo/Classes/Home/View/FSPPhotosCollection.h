//
//  FSPPhotosCollection.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/21.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSPPhotosCollection : UIView

@property (nonatomic, strong) NSArray *photos;

// 根据图片的个数返回相册的最终尺寸
+ (CGSize)photosCollectionSizeWithPhotosCount:(int)count;


@end
