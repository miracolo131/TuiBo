//
//  FSPPhoto.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/21.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPPhoto.h"

@implementation FSPPhoto

- (void)dealloc
{
    [_thumbnail_pic release];
    [super dealloc];
}

@end
