//
//  FSPDiscoveryViewController.m
//  TuiBo
//
//  Created by 逄腾飞 on 14/12/23.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPDiscoveryViewController.h"

@interface FSPDiscoveryViewController ()<UIWebViewDelegate>

@end

@implementation FSPDiscoveryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc] init];
    
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    webView.frame = CGRectMake(0,0, width, height - statusBarHeight);
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 加载授权页面
    NSURL *url = [NSURL URLWithString:@"http://sina.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
