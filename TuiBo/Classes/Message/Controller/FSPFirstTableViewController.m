//
//  FSPFirstTableViewController.m
//  TuiBo
//
//  Created by 逄 on 14/12/19.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPFirstTableViewController.h"
#import "FSPDetailViewController.h"
#import "FSPComment.h"
#import "FSPAccountTool.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "FSPAccount.h"
#import "FSPFirstTableViewCell.h"
#import "MJRefreshFooterView.h"
#import "MJRefresh.h"
@interface FSPFirstTableViewController ()
@property(nonatomic,retain)NSArray *commentsArray;
@property(nonatomic,assign)int cellNumber;
@end

@implementation FSPFirstTableViewController

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
        
        
            self.commentsArray = responseObject[@"statuses"];
            
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self.tableView addHeaderWithTarget:self action:@selector(setupCommentsData)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}
- (void)footerRereshing
{
    [self setupCommentsData];
    if ( [_commentsArray count] - 4 > _cellNumber) {
        _cellNumber += 4;
    }else if (_cellNumber > [_commentsArray count] - 4 && [_commentsArray count] - 4){
        _cellNumber = [_commentsArray count];
    }

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if ([_commentsArray count] < 4) {
        return [_commentsArray count];
    }
    return _cellNumber;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndexPath = @"cell";
    FSPFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndexPath];
    if (cell == nil) {
        cell = [[FSPFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndexPath];
    }
    
    // Configure the cell...
    
    NSDictionary *commentsDic = self.commentsArray[indexPath.row];
    cell.myTextLabel.text = commentsDic[@"text"];
    
    cell.created_atLabel.text = commentsDic[@"created_at"];
    NSDictionary *user = commentsDic[@"user"];
    if ([user[@"remark"] isEqualToString: @""]) {
        cell.nameLabel.text = user[@"name"];
    }else{
        cell.nameLabel.text = user[@"remark"];
    }
    
    
    NSString *avatarUrl = user[@"avatar_large"];
    
    [cell.avatar_largeImageView setImageWithURL:[NSURL URLWithString:avatarUrl]];
    NSDictionary *retweeted_statusDic = commentsDic[@"retweeted_status"];
    NSDictionary *userDic = retweeted_statusDic[@"user"];
    cell.contentLabel.text = retweeted_statusDic[@"text"];
    cell.userNameLabel.text = retweeted_statusDic[@"name"];
    NSArray *pic_urls = retweeted_statusDic[@"pic_urls"];
    NSDictionary *pic_urlsDic = pic_urls[0];
    NSString *pic_urlsStr = pic_urlsDic[@"thumbnail_pic"];
    

    if (pic_urlsStr != nil) {
        [cell.bmiddle_picView setImageWithURL:[NSURL URLWithString:pic_urlsStr]];
    }else{
        //[cell.bmiddle_picView setImageWithURL:[NSURL URLWithString:bmiddleUrl]];
    }
    
    
    cell.userNameLabel.text = [NSString stringWithFormat:@"@%@",userDic[@"screen_name"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
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
