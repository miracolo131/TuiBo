//
//  FSPComposeTextView.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/22.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSPComposeTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;
@property (nonatomic, retain) UILabel *placeholderLabel;

@end
