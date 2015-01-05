//
//  FSPBaseParam.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/22.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSPBaseParam : NSObject

@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;

@end
