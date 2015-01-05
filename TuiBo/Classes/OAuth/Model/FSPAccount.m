//
//  FSPAccount.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/11.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPAccount.h"

@implementation FSPAccount

- (void)dealloc
{
    [_access_token release];
    [_uid release];
    [_expiresTime release];
    [_remind_in release];
    [super dealloc];
}

#warning autorelease可能出现隐患
+ (instancetype)accountWithDic:(NSDictionary *)dic
{
    return [[[self alloc] initwithDic:dic] autorelease];
}

- (instancetype)initwithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


// 从文件解析对象的时候调用
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
//        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expiresTime = [aDecoder decodeObjectForKey:@"expiresTime"];
        self.remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
    }
    return self;
}

// 将对象写入文件时调用
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
//    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    NSLog(@"UID = %@",self.uid);
    [aCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [aCoder encodeObject:self.remind_in forKey:@"remind_in"];
}

@end
