//
//  FSPComposeStatusParam.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/22.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPComposeStatusParam.h"

@implementation FSPComposeStatusParam

- (void)dealloc
{
    [_statusText release];
    
    [super dealloc];
}

@end
