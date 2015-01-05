//
//  FSPGeo.h
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//  地理信息对象数据结构
//  字段详情信息:http://open.weibo.com/wiki/%E5%B8%B8%E8%A7%81%E8%BF%94%E5%9B%9E%E5%AF%B9%E8%B1%A1%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84#.E5.9C.B0.E7.90.86.E4.BF.A1.E6.81.AF.EF.BC.88geo.EF.BC.89

#import <Foundation/Foundation.h>

@interface FSPGeo : NSObject

@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *province_name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, copy) NSString *more;

@end
