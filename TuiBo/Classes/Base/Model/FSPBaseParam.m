//
//  FSPBaseParam.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/22.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPBaseParam.h"
#import "FSPAccount.h"
#import "FSPAccountTool.h"

@implementation FSPBaseParam

- (void)dealloc
{
    [_access_token release];
    
    [super dealloc];
}

- (id)init
{
    if (self = [super init]) {
        self.access_token = [FSPAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}


@end
