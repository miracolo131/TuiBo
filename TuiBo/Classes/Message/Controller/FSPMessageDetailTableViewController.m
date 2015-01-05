//
//  FSPMessageDetailTableViewController.m
//  TuiBo
//
//  Created by 逄 on 14/12/13.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPMessageDetailTableViewController.h"
#import "FSPMessageDetailTableViewCell.h"
#import "FSPDetailViewController.h"
#import "FSPComment.h"
#import "FSPAccountTool.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "FSPAccount.h"
#import "FSPMessageViewController.h"
#import "MJRefresh.h"
#import "MJRefreshFooterView.h"
#import "NSDate+Extention.h"
#import "FSPDetailViewController.h"

@interface FSPMessageDetailTableViewController ()



@property(nonatomic,retain)NSArray *commentsArray;

@property(nonatomic,assign)int cellNumber;
@property (nonatomic, copy)NSString *created_at;
@property(nonatomic,assign)NSString *idStr;
@property(nonatomic,copy)NSString *uidStr;
@end

@implementation FSPMessageDetailTableViewController

- (void)dealloc
{
    [_commentsArray release];
    [_created_at release];
    [_idStr release];
    [_uidStr release];
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
- (void)setupCommentsData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"access_token"] = [FSPAccountTool account].access_token;

    [manager GET:_urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([_urlStr isEqualToString:@"https://api.weibo.com/2/statuses/mentions.json"]) {
            self.commentsArray = responseObject[@"statuses"];
            
        }else{
            self.commentsArray = responseObject[@"comments"];
        }
        
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
    self.navigationItem.hidesBackButton = YES;
    
    
     [self.tableView addHeaderWithTarget:self action:@selector(setupCommentsData)];
    _cellNumber = 4;
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  //  self.view.backgroundColor = [UIColor whiteColor];
    
   
    
}
- (void)footerRereshing
{
    [self setupCommentsData];
    if ( [_commentsArray count] - 4 > _cellNumber) {
        _cellNumber += 4;
    }else if (_cellNumber > [_commentsArray count] - 4 && [_commentsArray count] - 4){
        _cellNumber = [_commentsArray count];
    }
    
    NSLog(@"cellNumber = %d",_cellNumber);
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if ([_commentsArray count] < 4) {
        return [_commentsArray count];
    }
    return _cellNumber;
}

// 时间转换
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndexPath = @"cell";
    FSPMessageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndexPath];
    if (cell == nil) {
        cell = [[FSPMessageDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndexPath];
    }
    
    // Configure the cell...
    
    NSDictionary *commentsDic = self.commentsArray[indexPath.row];
    cell.myTextLabel.text = commentsDic[@"text"];
    
    
    self.created_at = commentsDic[@"created_at"];
    
    cell.created_atLabel.text = _created_at;
    NSDictionary *user = commentsDic[@"user"];
    if ([user[@"remark"] isEqualToString: @""]) {
        cell.nameLabel.text = user[@"name"];
    }else{
        cell.nameLabel.text = user[@"remark"];
    }
    
    
    
    NSString *avatarUrl = user[@"avatar_large"];
    
    [cell.avatar_largeImageView setImageWithURL:[NSURL URLWithString:avatarUrl]];
    NSDictionary *status = commentsDic[@"status"];
    NSString *original_pic = status[@"original_pic"];
    
    NSDictionary *retweeted_status = status[@"retweeted_status"];
    NSString *bmiddleUrl = retweeted_status[@"original_pic"];
    
    NSDictionary *userDic = status[@"user"];
    NSString *avatar_hdStr = userDic[@"avatar_hd"];
    _idStr = status[@"idstr"];
    _uidStr = userDic[@"idstr"];
    if (retweeted_status[@"original_pic"] == nil && status[@"original_pic"] != nil) {
        [cell.bmiddle_picView setImageWithURL:[NSURL URLWithString:original_pic]];
    }else if (retweeted_status[@"original_pic"] == nil && status[@"original_pic"] == nil){
        
        [cell.bmiddle_picView setImageWithURL:[NSURL URLWithString:avatar_hdStr]];
        
    }else{
        [cell.bmiddle_picView setImageWithURL:[NSURL URLWithString:bmiddleUrl]];
    }
    
    cell.contentLabel.text = status[@"text"];
    
    cell.myNameLabel.text = [NSString stringWithFormat:@"@%@",userDic[@"screen_name"]];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 210;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FSPDetailViewController *detailVC = [[FSPDetailViewController alloc] init];
    detailVC.urlStr = @"http://api.weibo.com/2/statuses/go";
    detailVC.uidStr = _uidStr;
    detailVC.idStr = _idStr;
    NSLog(@"uid = %@, id = %@", _uidStr, _idStr);
    UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:detailVC];
    
    [self presentViewController:detailNav animated:YES completion:nil];
    
    //[self.navigationController pushViewController:detailVC animated:YES];
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
