//
//  FSPPhotoView.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/21.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSPPhoto;

@interface FSPPhotoView : UIImageView

@property (nonatomic, retain) FSPPhoto *photo;
@property (nonatomic, retain) UIImageView *gifView;

@end
