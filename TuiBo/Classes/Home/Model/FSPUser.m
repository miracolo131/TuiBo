//
//  FSPUser.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPUser.h"
#import "FSPStatus.h"

@implementation FSPUser
//@synthesize ID = _id;

- (void)dealloc
{
//    [_idstr release];
//    [_screen_name release];
//    [_name release];
//    [_location release];
//    [_description release];
//    [_url release];
//    [_profile_image_url release];
//    [_profile_url release];
//    [_domain release];
//    [_weihao release];
//    [_gender release];
//    [_create_at release];
//    [_remark release];
//    [_status release];
//    [_avatar_large release];
//    [_avatar_hd release];
//    [_verified_reason release];
//    [_lang release];
    [_idstr release];
    [_name release];
    [_profile_image_url release];
    [super dealloc];
}

+ (instancetype)userWithDict:(NSDictionary *)dict
{
#warning autorelease可能造成崩溃
    return [[[self alloc] initWithDict:dict] autorelease];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        self.name = dict[@"name"];
        self.profile_image_url = dict[@"profile_image_url"];
    }
    return self;
}


@end
