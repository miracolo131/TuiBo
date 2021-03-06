//
//  FSPAuthViewController.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/11.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPAuthViewController.h"
#import "FSPAccount.h"
#import "FSPAccountTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@interface FSPAuthViewController ()<UIWebViewDelegate>

@end

@implementation FSPAuthViewController

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
    // 添加webView
//    [[UIScreen mainScreen] bounds].size;
    UIWebView *webView = [[UIWebView alloc] init];

//    [UIApplication sharedApplication].statusBarHidden = NO;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    NSLog(@"%f", height);
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    webView.frame = CGRectMake(0, statusBarHeight, width, height - statusBarHeight);
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 加载授权页面
    NSURL *url = [NSURL URLWithString:kAuthPage];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

//webView开始发送请求的时候就会调用
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示提醒框
    [MBProgressHUD showMessage:@"加载中, 请稍等"];
}

// webView请求完毕的时候就会调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

// webView请求失败的时候就会调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.请求的url
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code在urlStr中的范围
    NSRange rang = [urlStr rangeOfString:@"code="];
    
    // 3.截取code
    if (rang.location != NSNotFound) {
        unsigned long loc = rang.location + rang.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
        // 4.发送post请求给新浪，用code换accessToken
        [self accessTokenWithCode:code];
    }

    return YES;
}
/**
 *  用code向新浪换accessToken
 *
 *  @param code code
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // afn 1.创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 服务器返回json数据
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSLog(@"%@", code);
    
    // 2. 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = kAppKey;
    params[@"client_secret"] = KAppSecrect;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = kRedirectUIR;
    
    // 3.发送请求
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject = %@ ", responseObject);
        
        // 4.将字典转为模型
        FSPAccount *account = [FSPAccount accountWithDic:responseObject];
        // 5.存储模型数据
        [FSPAccountTool saveAccount:account];
//        NSLog(@"acount = %@", account.expiresTime);
//        NSLog(@"access_token = %@", account.access_token);
//        NSLog(@"expires_in = %lld", account.expires_in);
//        NSLog(@"expiresTime = %@", account.expiresTime);
//        NSLog(@"remind_in = %@", account.remind_in);
//        NSLog(@"uid = %@", account.uid);
        // 6.去首页
        [FSPAccountTool chooseRootController];
        
        // 7.隐藏提醒框
        [MBProgressHUD hideHUD];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败：%@", error);
        [MBProgressHUD hideHUD];
    }];
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
