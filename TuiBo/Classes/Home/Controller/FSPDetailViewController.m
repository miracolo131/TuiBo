//
//  FSPDetailViewController.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPDetailViewController.h"
#import "FSPStatus.h"
#import "FSPComment.h"
#import "FSPCommentFrame.h"
#import "AFNetworking.h"
#import "FSPAccountTool.h"
#import "FSPAccount.h"
#import "MJExtension.h"
#import "FSPDetailStatusCell.h"
#import "FSPStatusCommentCell.h"
#import "FSPUser.h"
#import "UIImageView+WebCache.h"
#import "FSPStatusFrame.h"
#import "FSPStatusCell.h"
#import "MJRefresh.h"
#import "MJRefreshFooterView.h"
#import "FSPMessageDetailTableViewController.h"
@interface FSPDetailViewController ()

@property (nonatomic, retain) NSArray *commetsArray;
@property (nonatomic, retain) NSArray *commetFrames;
@property (nonatomic, assign)int cellNumber;

@end

@implementation FSPDetailViewController

- (void)dealloc
{
    [_status release];
    [_statusFrame release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
//        NSString *test = _statusFrame.status.text;
//        _statusFrame = [[FSPStatusFrame alloc] init];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"source = %@", _status.source);
    _cellNumber = 10;

    [self.tableView addHeaderWithTarget:self action:@selector(setupCommentData)];
    
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)footerRereshing
{
    [self setupCommentData];
    if ( _commetFrames.count- 10 > _cellNumber) {
        _cellNumber += 10;
    }else if (_cellNumber > _commetFrames.count - 10 && _commetFrames.count - 10){
        _cellNumber = _commetFrames.count;
    }
    
    NSLog(@"cellNumber = %d",_cellNumber);
}
- (void)setupCommentData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [FSPAccountTool account].access_token;
    if ([_urlStr isEqualToString:@"https://api.weibo.com/2/comments/show.json"]) {
        params[@"id"] = _status.idstr;
    }else{
        //params[@"uid"] = _uidStr;
        params[@"id"] = _idStr;
        NSLog(@"detail id = %@", params[@"id"]);
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(backButtonAction)];
        backButton.title = @"返回";
        
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/comments/show.json" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         self.commetsArray = [FSPComment objectArrayWithKeyValuesArray:responseObject[@"comments"]];
         
         NSMutableArray *commentFrameArray = [NSMutableArray array];
         for (FSPComment *comment in _commetsArray) {
             FSPCommentFrame *commentFrame = [[FSPCommentFrame alloc] init];

             commentFrame.comment = comment;
             [commentFrameArray addObject:commentFrame];
         }
         
         self.commetFrames = commentFrameArray;

         [self.tableView reloadData];
                 NSLog(@"statusArray = %@",self.commetFrames
                       );
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];

    [self.tableView headerEndRefreshing];
    
    [self.tableView footerEndRefreshing];
}
- (void)backButtonAction
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    if (_commetsArray.count == 0) {
        return 1;
    }else{
        return 2;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        if (_commetFrames.count < 10) {
            return _commetFrames.count;
        }
        return _cellNumber;
        
    }
    return NO;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        // 1.创建cell
        FSPStatusCell *cell = [FSPStatusCell cellWithTableView:tableView];
        
        // 2.传递frame模型
        cell.statusFrame = self.statusFrame;

        return cell;
    }

    if (indexPath.section == 1 && _commetsArray.count > 0) {
        // 1.创建cell
        FSPStatusCommentCell *cell = [FSPStatusCommentCell cellWithTableView:tableView];
        
        // 2.传递frame模型
        cell.commentFrame = self.commetFrames[indexPath.row];

        return cell;
    }else{
        static NSString *nullCell = @"null";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nullCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nullCell];
//            cell.hidden = YES;
        }
        return cell;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_commetsArray.count > 0) {
        FSPCommentFrame *commentFrame = self.commetFrames[indexPath.row];
        if (indexPath.section == 0) {
            return self.statusFrame.cellHeight;
        }else{
            return commentFrame.cellHeight;
        }
        
    }else{
        return self.statusFrame.cellHeight;
    }
    
    
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
