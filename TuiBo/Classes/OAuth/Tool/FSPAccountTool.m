//
//  FSPAccountTool.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/11.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPAccountTool.h"
#import "FSPAccount.h"
#import "FSPMainViewController.h"

#define FSPAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation FSPAccountTool

+ (void)saveAccount:(FSPAccount *)account
{
    // 计算账号的过期时间
    NSDate *now = [NSDate date];
    long long expires = account.expires_in ;
    account.expiresTime = [now dateByAddingTimeInterval:expires];
    [NSKeyedArchiver archiveRootObject:account toFile:FSPAccountFile];
}

+ (FSPAccount *)account
{
    // 取出账号
    FSPAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:FSPAccountFile];
    NSLog(@"%lld", account.expires_in);
    NSLog(@"access_token = %@", account.uid);
    // 判断账号是否过期
    NSDate *now = [NSDate date];
    NSLog(@"expiresTime = %@", account.expiresTime);
    if ([now compare:account.expiresTime] == NSOrderedAscending) {
        return account;
    }else{
        return nil;
    }
}

+ (void)chooseRootController
{
    FSPMainViewController *mainVC = [[FSPMainViewController alloc] init];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
    [mainVC release];
}
@end
