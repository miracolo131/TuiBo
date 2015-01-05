//
//  FSPMoreBar.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/20.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPMoreBar.h"
#import "FSPStatus.h"
#import "UIImage+Resize.h"

@interface FSPMoreBar ()

@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) NSMutableArray *dividers;
@property (nonatomic, retain) UIButton *retweetButton;
@property (nonatomic, retain) UIButton *commentButton;
@property (nonatomic, retain) UIButton *attitudeButton;

@end

@implementation FSPMoreBar

- (void)dealloc
{
    [_status release];
    [_buttons release];
    [_retweetButton release];
    [_commentButton release];
    [_attitudeButton release];
    [super dealloc];

}


- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 1.设置图片
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
        
        // 2.添加按钮
        self.retweetButton = [self setupButtonWithTitle:@"转发" image:@"timeline_icon_retweet" backgroudImage:@"timeline_card_leftbottom_highlighted"];
        self.commentButton = [self setupButtonWithTitle:@"评论" image:@"timeline_icon_comment" backgroudImage:@"timeline_card_middlebottom_highlighted"];
        self.attitudeButton = [self setupButtonWithTitle:@"赞" image:@"timeline_icon_unlike" backgroudImage:@"timeline_card_rightbottom_highlighted"];
        
        // 3.添加两条分割线
//        [self setupDivider];
//        [self setupDivider];

    }
    return self;
}

/**
 *  初始化分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 *  初始化按钮
 *
 *  @param title   按钮的文字
 *  @param image   按钮的小图片
 *  @param bgImage 按钮的背景
 */
- (UIButton *)setupButtonWithTitle:(NSString *)title image:(NSString *)image backgroudImage:(NSString *)backgroudImage
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    button.adjustsImageWhenHighlighted = NO;
    [button setBackgroundImage:[UIImage resizedImageWithName:backgroudImage] forState:UIControlStateHighlighted];
    [self addSubview:button];
    
    // 添加按钮到数组
    [self.buttons addObject:button];
    
    return button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置按钮的frame
//    int dividerCount = self.dividers.count; // 分割线的个数
//    CGFloat dividerWidth = 2; // 分割线的宽度
    int buttonCount = self.buttons.count;
//    CGFloat buttonWidth = (self.frame.size.width - dividerCount * dividerWidth) / buttonCount;
    CGFloat buttonWidth = 14.0;
    CGFloat buttonHeight = self.frame.size.height;
    CGFloat buttonY = 0;
    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = self.buttons[i];
        
        // 设置frame
//        CGFloat buttonX = i * (buttonWidth + dividerWidth);
        CGFloat buttonX = i * buttonWidth;
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    }
    
//    // 2.设置分割线的frame
//    CGFloat dividerHeight = buttonHeight;
//    CGFloat dividerY = 0;
//    for (int j = 0; j< dividerCount; j++) {
//        UIImageView *divider = self.dividers[j];
//        
//        // 设置frame
//        UIButton *button = self.buttons[j];
//        CGFloat dividerX = CGRectGetMaxX(button.frame);
//        divider.frame = CGRectMake(dividerX, dividerY, dividerWidth, dividerHeight);
//    }
}

- (void)setStatus:(FSPStatus *)status
{
    _status = status;
    
    // 1.设置转发数
    [self setupButton:self.retweetButton originalTitle:@"转发" count:status.reposts_count];
    [self setupButton:self.commentButton originalTitle:@"评论" count:status.comments_count];
    [self setupButton:self.attitudeButton originalTitle:@"赞" count:status.attitudes_count];
}

/**
 *  设置按钮的显示标题
 *
 *  @param btn           哪个按钮需要设置标题
 *  @param originalTitle 按钮的原始标题(显示的数字为0的时候, 显示这个原始标题)
 *  @param count         显示的个数
 */
- (void)setupButton:(UIButton *)button originalTitle:(NSString *)originalTitle count:(int)count
{
    /**
     0 -> @"转发"
     <10000  -> 完整的数量, 比如个数为6545,  显示出来就是6545
     >= 10000
     * 整万(10100, 20326, 30000 ....) : 1万, 2万
     * 其他(14364) : 1.4万
     */
    
    if (count) { // 个数不为0
        NSString *title = nil;
        if (count < 10000) { // 小于1W
            title = [NSString stringWithFormat:@"%d", count];
        } else { // >= 1W
            // 42342 / 1000 * 0.1 = 42 * 0.1 = 4.2
            // 10742 / 1000 * 0.1 = 10 * 0.1 = 1.0
            // double countDouble = count / 1000 * 0.1;
            
            // 42342 / 10000.0 = 4.2342
            // 10742 / 10000.0 = 1.0742
            double countDouble = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", countDouble];
            
            // title == 4.2万 4.0万 1.0万 1.1万
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [button setTitle:title forState:UIControlStateNormal];
    } else {
        [button setTitle:originalTitle forState:UIControlStateNormal];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
