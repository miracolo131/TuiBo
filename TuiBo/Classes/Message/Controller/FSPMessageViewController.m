//
//  FSPMessageViewController.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPMessageViewController.h"
#import "FSPMessageTableViewCell.h"
#import "FSPMessageDetailTableViewController.h"
#import "FSPFirstTableViewController.h"


@interface FSPMessageViewController ()
@property(nonatomic,retain)UISegmentedControl *segmentControl;
@end

@implementation FSPMessageViewController
- (void)dealloc
{
    [_segmentControl release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _segmentControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(20, 27, 280, 30)];
    [_segmentControl insertSegmentWithTitle:@"@我的微博" atIndex:0 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"收到的评论" atIndex:2 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"@我的评论" atIndex:1 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"发出的评论" atIndex:3 animated:YES];
    _segmentControl.momentary = YES;
    _segmentControl.multipleTouchEnabled = NO;
    _segmentControl.tintColor = [UIColor grayColor];
    
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.view addSubview:_segmentControl];
    
    
}
- (void)segmentAction:(id)sender
{
    FSPFirstTableViewController *firstVc = [[FSPFirstTableViewController alloc] init];
    
    FSPMessageDetailTableViewController *messageDetailVc = [[FSPMessageDetailTableViewController alloc] init];
    
    
    
    
    switch ([(UISegmentedControl *)sender selectedSegmentIndex]) {
        case 0:
            firstVc.urlStr = @"https://api.weibo.com/2/statuses/mentions.json";
            
            [self.navigationController pushViewController:firstVc animated:NO];
            [firstVc release];
            break;
        case 1:
            messageDetailVc.urlStr = @"https://api.weibo.com/2/comments/mentions.json";
            [self.navigationController pushViewController:messageDetailVc animated:NO];
            [messageDetailVc release];
            break;
        case 2:
            messageDetailVc.urlStr =  @"https://api.weibo.com/2/comments/to_me.json";
            
            [self.navigationController pushViewController:messageDetailVc animated:NO];
            [messageDetailVc release];
            break;
        case 3:
            messageDetailVc.urlStr = @"https://api.weibo.com/2/comments/by_me.json";
            [self.navigationController pushViewController:messageDetailVc animated:NO];
            [messageDetailVc release];
            break;
        default:
            break;
    }
    
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndexPath = @"cell";
    FSPMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndexPath];
    if (cell == nil) {
        cell = [[[FSPMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndexPath]autorelease];
    }
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell.textLabel.text = @"@我的微博";
        cell.imageView.image = [UIImage imageNamed:@"@me"];
        
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"@我的评论";
        cell.imageView.image = [UIImage imageNamed:@"@me"];
    }else if (indexPath.section == 2){
        cell.textLabel.text = @"收到的评论";
        cell.imageView.image = [UIImage imageNamed:@"comments"];
        
    }else if (indexPath.section == 3){
        cell.textLabel.text = @"发出的评论";
        cell.imageView.image = [UIImage imageNamed:@"comments"];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        

        FSPFirstTableViewController *firstVc = [[FSPFirstTableViewController alloc] init];
        firstVc.urlStr = @"https://api.weibo.com/2/statuses/mentions.json";
        
        
        [self.navigationController pushViewController:firstVc animated:YES];
        [firstVc release];
        
    }else if (indexPath.section == 1){
        
        FSPMessageDetailTableViewController *messageDetailVc = [[FSPMessageDetailTableViewController alloc] init];
        messageDetailVc.urlStr = @"https://api.weibo.com/2/comments/mentions.json";
        [self.navigationController pushViewController:messageDetailVc animated:NO];
        [messageDetailVc release];
        
    }else if (indexPath.section == 2) {
        
    
        FSPMessageDetailTableViewController *messageDetailVc = [[FSPMessageDetailTableViewController alloc] init];
        messageDetailVc.urlStr =  @"https://api.weibo.com/2/comments/to_me.json";
        [self.navigationController pushViewController:messageDetailVc animated:YES];
        [messageDetailVc release];
    }else if (indexPath.section == 3){
        
        FSPMessageDetailTableViewController *messageDetailVc = [[FSPMessageDetailTableViewController alloc] init];
        messageDetailVc.urlStr =  @"https://api.weibo.com/2/comments/by_me.json";;
        [self.navigationController pushViewController:messageDetailVc animated:YES];
        [messageDetailVc release];
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
