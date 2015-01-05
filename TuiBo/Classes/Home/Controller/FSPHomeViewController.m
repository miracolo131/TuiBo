//
//  FSPHomeViewController.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPHomeViewController.h"
#import "FSPDetailViewController.h"
#import "FSPAccount.h"
#import "FSPAccountTool.h"
#import "AFNetworking.h"
#import "StatusesAPI.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "FSPStatus.h"
#import "FSPUser.h"
#import "FSPStatusCell.h"
#import "FSPStatusFrame.h"
#import "MJRefresh.h"
#import "MJRefreshFooterView.h"
#import "FSPComposeViewController.h"
@interface FSPHomeViewController ()

@property (nonatomic, retain)NSArray *statuses;
@property (nonatomic, retain) NSArray *statusFrames;
@property (nonatomic, retain)FSPStatus *status;
@property (nonatomic, assign)NSUInteger cellNumber;
@end

@implementation FSPHomeViewController

- (void)dealloc
{
    [_statuses release];
    [_statusFrames release];
    [_status release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


- (void)setupStatusData
{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [FSPAccountTool account].access_token;
    params[@"count"] = @"91";
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         self.statuses = [FSPStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         
         
         NSMutableArray *statusFrameArray = [NSMutableArray array];
         for (FSPStatus *status in _statuses) {
             FSPStatusFrame *statusFrame = [[FSPStatusFrame alloc] init];
             
             statusFrame.status = status;
             [statusFrameArray addObject:statusFrame];
         }
         
         
         self.statusFrames = statusFrameArray;
         
         
         [self.tableView reloadData];
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
    [self.tableView headerEndRefreshing];
    
    [self.tableView footerEndRefreshing];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView headerBeginRefreshing];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    _cellNumber = 20;

    [self.tableView addHeaderWithTarget:self action:@selector(setupStatusData)];
    
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    UIBarButtonItem *testButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(testAction)];
    self.navigationItem.rightBarButtonItem = testButton;
}
- (void)footerRereshing
{
    [self setupStatusData];
    if ( self.statuses.count- 20 > _cellNumber) {
        _cellNumber += 20;
    }else if (_cellNumber > self.statuses.count - 20 && self.statuses.count - 20){
        _cellNumber = self.statuses.count;
    }
    
    
}


- (void)testAction
{
    FSPAccount *account = [FSPAccountTool account];
    
    FSPComposeViewController *composeVC = [[FSPComposeViewController alloc] init];
    [self.navigationController pushViewController:composeVC animated:YES];
    [composeVC release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //    NSLog(@"count = %d", self.statuses.count);
    if (self.statuses.count < 10) {
        return self.statuses.count;
    }
    return _cellNumber;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    static NSString *identifier = @"cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    //    }
    
    // Configure the cell...
    /*
     NSDictionary *status = self.statuses[indexPath.row];
     cell.textLabel.text = status[@"text"];
     
     NSDictionary *user = status[@"user"];
     cell.textLabel.text = user[@"name"];
     
     NSString *avatarUrl = user[@"profile_image_url"];
     
     [cell.imageView setImageWithURL:[NSURL URLWithString:avatarUrl]];
     */
    // 2.设置cell的数据
    // 微博的文字(内容)
    //    FSPStatus *status = self.statuses[indexPath.row];
    //    cell.textLabel.text = status.text;
    //
    ////    // 微博作者的昵称
    //    FSPUser *user = status.user;
    //    cell.detailTextLabel.text = user.name;
    //
    //    // 微博作者的头像
    //    [cell.imageView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"tabbar_compose_button"]];
    
    // 1.创建cell
    FSPStatusCell *cell = [FSPStatusCell cellWithTableView:tableView];
    
    // 2.传递frame模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    //    NSLog(@"cell = %@", cell);
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FSPStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FSPDetailViewController *detailVC = [[FSPDetailViewController alloc] init];
    detailVC.urlStr = @"https://api.weibo.com/2/comments/show.json";
    FSPStatus *status = self.statuses[indexPath.row];
    detailVC.status = status;
    detailVC.statusFrame = self.statusFrames[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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
