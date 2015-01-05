//
//  FSPStatusFrame.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/20.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPStatusFrame.h"
#import "FSPStatus.h"
#import "FSPUser.h"
#import "MJPhotoBrowser.h"
#import "FSPPhotosCollection.h"

@implementation FSPStatusFrame

/**
 *  获得微博模型数据之后, 根据微博数据计算所有子控件的frame
 */
- (void)setStatus:(FSPStatus *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width - 2 * FSPStatusTableBorder;
    
    // 1.topView
    CGFloat statusViewWidth = cellWidth;
    CGFloat statusViewHeight = 0;
    CGFloat statusViewX = 0;
    CGFloat statusViewY = 0;
    
    // 2.头像
    CGFloat avatarViewWH = 35;
    CGFloat avatarViewX = FSPStatusCellBorder;
    CGFloat avatarViewY = FSPStatusCellBorder;
    _avatarViewFrame = CGRectMake(avatarViewX, avatarViewY, avatarViewWH, avatarViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_avatarViewFrame) + FSPStatusCellBorder;
    CGFloat nameLabelY = avatarViewY;
#warning sizeWithFont 7.0被弃
    CGSize nameLabelSize = [status.user.name sizeWithFont:FSPStatusNameFont];
    _nameLabelFrame = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 4.会员图标
    if (status.user.isVip) {
        CGFloat vipViewWidth = 14;
        CGFloat vipViewHeight = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelFrame) + FSPStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewFrame = CGRectMake(vipViewX, vipViewY, vipViewWidth, vipViewHeight);
    }
    
    // 5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelFrame) + 10;

#warning sizeWithFont 7.0被弃
    CGSize timeLabelSize = [status.created_at sizeWithFont:FSPStatusTimeFont];
    _timeLabelFrame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
//    // 6.来源
//    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelFrame) + FSPStatusCellBorder;
//    CGFloat sourceLabelY = timeLabelY;
//    NSString *sourceText = [[NSString alloc] init];
//    int loc = [status.source rangeOfString:@">"].location + 1;
//    int length = [status.source rangeOfString:@"</"].location - loc;
//    sourceText = [status.source substringWithRange:NSMakeRange(loc, length)];
//    CGSize sourceLabelSize = [sourceText sizeWithFont:FSPStatusSourceFont];
//    _sourceLabelFrame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    // 5.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelFrame) + FSPStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    
    CGSize sourceLabelSize = [status.source sizeWithFont:FSPStatusSourceFont];
    _sourceLabelFrame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};

    
    // 7.微博正文内容
    CGFloat contentLabelX = avatarViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelFrame), CGRectGetMaxY(_avatarViewFrame)) + FSPStatusCellBorder;
    CGFloat contentLabelMaxWidth = statusViewWidth - 2 * FSPStatusCellBorder;
#warning sizeWithFont 7.0被弃
    CGSize contentLabelSize = [status.text sizeWithFont:FSPStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxWidth, MAXFLOAT)];
    _contentLabelFrame = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 8.配图
    if (status.thumbnail_pic) {
        CGFloat photoViewWH = 70;
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelFrame) + FSPStatusCellBorder;
        _photoViewFrame = CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
    }
//    // 8.配图
//    if (status.pic_urls.count) {
//#warning 根据图片个数计算整个相册的尺寸
//        CGSize photosViewSize = [FSPPhotosCollection photosCollectionSizeWithPhotosCount:status.pic_urls.count];
//        CGFloat photosViewX = contentLabelX;
//        CGFloat photosViewY = CGRectGetMaxY(_contentLabelFrame) + FSPStatusCellBorder;
//        _photoViewFrame = CGRectMake(photosViewX, photosViewY, photosViewSize.width, photosViewSize.height);
//    }

    
    // 9.被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewWidth = contentLabelMaxWidth;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelFrame) + FSPStatusCellBorder;
        CGFloat retweetViewHeight = 0;
        
        // 10.被转发微博的昵称
        CGFloat retweetNameLabelX = FSPStatusCellBorder;
        CGFloat retweetNameLabelY = FSPStatusCellBorder;
        CGSize retweetNameLabelSize = [status.retweeted_status.user.name sizeWithFont:FSPRetweetStatusNameFont];
//        _retweetNameLabelFrame = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        _retweetNameLabelFrame = CGRectMake(retweetNameLabelX, retweetNameLabelY, 200, retweetNameLabelSize.height);
        
        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelFrame) + FSPStatusCellBorder;
        CGFloat retweetContentLabelMaxWidth = retweetViewWidth - 2 * FSPStatusCellBorder;
        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:FSPRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxWidth, MAXFLOAT)];
        _retweetContentLabelFrame = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        
        // 12.被转发微博的配图
        if(status.retweeted_status.thumbnail_pic) {
            CGFloat retweetPhotoViewWH = 70;
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelFrame) + FSPStatusCellBorder;
            _retweetPhotoViewFrame = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewWH, retweetPhotoViewWH);
            
            retweetViewHeight = CGRectGetMaxY(_retweetPhotoViewFrame);
        } else { // 没有配图
            retweetViewHeight = CGRectGetMaxY(_retweetContentLabelFrame);
        }
        retweetViewHeight += FSPStatusCellBorder;
        _retweetViewFrame = CGRectMake(retweetViewX, retweetViewY, retweetViewWidth, retweetViewHeight);
        
        // 有转发微博时topViewH
        statusViewHeight = CGRectGetMaxY(_retweetViewFrame);
    } else { // 没有转发微博
        if (status.thumbnail_pic) { // 有图
            statusViewHeight = CGRectGetMaxY(_photoViewFrame);
        } else { // 无图
            statusViewHeight = CGRectGetMaxY(_contentLabelFrame);
        }
    }
    
    // 12.被转发微博的配图
//    if(status.retweeted_status.pic_urls.count) {
//#warning 根据图片个数计算整个相册的尺寸
//        CGSize retweetPhotosViewSize = [IWPhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count];
//        CGFloat retweetPhotosViewX = retweetContentLabelX;
//        CGFloat retweetPhotosViewY = CGRectGetMaxY(_retweetContentLabelF) + IWStatusCellBorder;
//        _retweetPhotosViewF = CGRectMake(retweetPhotosViewX, retweetPhotosViewY, retweetPhotosViewSize.width, retweetPhotosViewSize.height);
//        
//        retweetViewH = CGRectGetMaxY(_retweetPhotosViewF);
//    } else { // 没有配图
//        retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
//    }
//    retweetViewH += IWStatusCellBorder;
//    _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
//    
//    // 有转发微博时topViewH
//    topViewH = CGRectGetMaxY(_retweetViewF);
//} else { // 没有转发微博
//    if (status.pic_urls.count) { // 有图
//        topViewH = CGRectGetMaxY(_photosViewF);
//    } else { // 无图
//        topViewH = CGRectGetMaxY(_contentLabelF);
//    }
//}

    statusViewHeight += FSPStatusCellBorder;
    _statusViewFrame = CGRectMake(statusViewX, statusViewY, statusViewWidth, statusViewHeight);
    // 13.工具条
    CGFloat moreBarX = statusViewX;
    CGFloat moreBarY = CGRectGetMaxY(_statusViewFrame);
    CGFloat moreBarWidth = statusViewWidth;
    CGFloat moreBarHeight = 35;
    _moreBarFrame = CGRectMake(moreBarX, moreBarY, moreBarWidth, moreBarHeight);
    
    // 计算cell的高度
    _cellHeight = CGRectGetMaxY(_moreBarFrame) + FSPStatusTableBorder ;
}


@end
