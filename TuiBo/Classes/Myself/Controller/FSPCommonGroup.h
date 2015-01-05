//
//  FSPCommonGroup.h
//  TuiBo
//
//  Created by Tonfan on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSPCommonGroup : NSObject
/**用一个模型来描述每组的信息:组头,组尾,这组的所有行模型*/
@property(nonatomic,copy)NSString *groupheader;
@property(nonatomic,copy)NSString *groupfooter;

@property(nonatomic,strong)NSArray *iteams;

+(instancetype)group;

@end
