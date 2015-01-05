//
//  FSPUrlShort.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPUrlShort.h"

@implementation FSPUrlShort

- (void)dealloc
{
    [_url_long release];
    [_url_short release];
    [super dealloc];
}

@end
