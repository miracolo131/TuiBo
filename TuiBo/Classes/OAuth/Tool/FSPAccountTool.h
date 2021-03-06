//
//  FSPAccountTool.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/11.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FSPAccount;

@interface FSPAccountTool : NSObject

// 存储账号信息
+ (void)saveAccount:(FSPAccount *)account;

// 返回账号信息
+ (FSPAccount *)account;

// 选择开始页面
+ (void)chooseRootController;
@end
