//
//  FSPComposeToolBar.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/22.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSPComposeToolBar;

typedef enum {
    FSPComposeToolbarButtonTypeCamera,
    FSPComposeToolbarButtonTypePicture,
    FSPComposeToolbarButtonTypeMention,
    FSPComposeToolbarButtonTypeTrend,
    FSPComposeToolbarButtonTypeEmotion
} FSPComposeToolbarButtonType;

@protocol FSPComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(FSPComposeToolBar *)toolbar didClickedButton:(FSPComposeToolbarButtonType)buttonType;
@end

@interface FSPComposeToolBar : UIView

@property (assign, nonatomic) id<FSPComposeToolbarDelegate> delegate;

@end
