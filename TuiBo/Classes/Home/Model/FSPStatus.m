//
//  FSPStatus.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPStatus.h"
#import "FSPGeo.h"
#import "FSPUser.h"
#import "NSDate+Extention.h"

@implementation FSPStatus

//@synthesize ID = _id;

- (void)dealloc
{
//    [_created_at release];
//    [_idstr release];
//    [_text release];
//    [_source release];
//    [_thumbnail_pic release];
//    [_bmiddle_pic release];
//    [_original_pic release];
//    [_geo release];
//    [_user release];
    [_text release];
    [_created_at release];
    [_source release];
    [_idstr release];
    [_thumbnail_pic release];
    [_user release];
    [_retweeted_status release];
    [_pic_urls release];
    [super dealloc];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        self.text = dict[@"text"];
        self.source = dict[@"source"];
        self.reposts_count = [dict[@"reposts_count"] intValue];
        self.comments_count = [dict[@"comments_count"] intValue];
        self.user = [FSPUser userWithDict:dict[@"user"]];
    }
    return self;
}

- (NSString *)created_at
{
    // _created_at == Fri May 09 16:30:34 +0800 2014
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
// 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%d分钟前", createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}
//- (NSString *)source
//{
//    NSUInteger loc = [_source rangeOfString:@">"].location + 1;
//    NSUInteger length = [_source rangeOfString:@"</"].location - 60;
//    NSLog(@"loc = %lu, length = %lu", loc, length);
//    NSString *souceText = [NSString stringWithFormat:@"来自 %@", [_source substringWithRange:NSMakeRange(60, length)]];
////    NSString *souceText = @"aho";
//    return souceText;
//}
//- (void)setSource:(NSString *)source
//{
//    if (_source != source) {
//        [_source release];
//        int loc = [source rangeOfString:@">"].location + 1;
//        int length = [source rangeOfString:@"</"].location - loc;
//        source = [source substringWithRange:NSMakeRange(loc, length)];
//        NSString *tmp = source;
//        self.source = [tmp retain];
//    }else
//    {
////        _source = source;
//    }
//    int loc = [source rangeOfString:@">"].location + 1;
//    int length = [source rangeOfString:@"</"].location - loc;
//    source = [source substringWithRange:NSMakeRange(loc, length)];
////    _source = source;
//    NSLog(@"来自%@, loc = %d, length = %d", source, loc, length);
////    self.source = [NSString stringWithString:source];
//    self.source = [NSString stringWithFormat:@"来自%@", source];
//    [_source retain];
//    NSLog(@"----setSource--%@", _source);
//}


@end
