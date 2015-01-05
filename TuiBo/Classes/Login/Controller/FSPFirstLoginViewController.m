//
//  FSPFirstLoginViewController.m
//  TuiBo
//
//  Created by 逄 on 14/12/22.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPFirstLoginViewController.h"
#import "FSPAuthViewController.h"
#import "FSPMainViewController.h"
#import "FSPAccount.h"
#import "FSPAccountTool.h"

@interface FSPFirstLoginViewController ()

@end

@implementation FSPFirstLoginViewController

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
    
     [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default.png"]]];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    

   
   
//    loginButton.frame = CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height, self.view.frame.size.width/2, self.view.frame.size.height/16);
    loginButton.frame = CGRectMake(80, 340, 160, 40);
   loginButton.backgroundColor = [UIColor whiteColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:loginButton];
    
}
- (void)loginButtonAction
{
    
    
        FSPAuthViewController *authVC = [[FSPAuthViewController alloc] init];
        
        [self presentViewController:authVC animated:YES completion:nil];
    
    
    
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
