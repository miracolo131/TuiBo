//
//  FSPMyselfViewController.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/10.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPMyselfViewController.h"
#import "FSPCommonGroup.h"
#import "FSPsynopsisTableViewCell.h"
#import "FSPsettingTableViewController.h"
#import "FSPaddFriendTableViewController.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "FSPlist.h"
#import "FSPComment.h"
#import "FSPAccountTool.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "FSPAccount.h"
#import "MJRefresh.h"
#import "MJRefreshFooterView.h"
@interface FSPMyselfViewController ()
@property(nonatomic,strong)NSMutableArray *groups;
@property(nonatomic,retain)UIButton *leftButton;//左上角图标按钮
@property(nonatomic,retain)UIButton *rightButton;//右上角图标按钮

@property(nonatomic,retain)UIImageView *headPortrait;//头像
@property(nonatomic,retain)UILabel *nameLabel;//昵称
@property(nonatomic,retain)UILabel *genderLable;//性别
@property(nonatomic,retain)UILabel *cityLabel;//城市
@property(nonatomic,retain)UILabel *areaLabel;//区

@property(nonatomic,retain)UILabel *weboNumabeLabel;//微博数量
@property(nonatomic,retain)UILabel *attentionLable;//关注数量
@property(nonatomic,retain)UILabel *fansLabel;//粉丝数量
@property (nonatomic,retain) NSMutableArray *testArray;

@property(nonatomic,retain)NSDictionary *userDic;
@end

@implementation FSPMyselfViewController
-(void)dealloc
{
    [_headPortrait release];
    [_nameLabel release];
    [_genderLable release];
    [_cityLabel release];
    
    [_weboNumabeLabel release];
    [_attentionLable release];
    [_fansLabel release];
    [_userDic release];
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

-(id)init
{
    //分组模式
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView addHeaderWithTarget:self action:@selector(setuoCommentsData)];
   
   // [self setuoCommentsData];
    

    self.navigationItem.title=@"个人资料";
    self.testArray = [NSMutableArray arrayWithCapacity:10];
    
    
    //左上角加好友图标按钮
    _leftButton =[[UIButton alloc] init];
    [self setupButton:_leftButton setImage:[UIImage imageNamed:@"iconfont-tianjiahaoyou (1)"] state:UIControlStateNormal rect:CGRectMake(0, 0, 30, 30) target:self action:@selector(addFrident:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem =[[UIBarButtonItem alloc]initWithCustomView:_leftButton];
    self.navigationItem.leftBarButtonItem =leftItem;
    [leftItem release];
    
    //右上角设置图标按钮
    _rightButton =[[UIButton alloc] init];
    [self setupButton:_rightButton setImage:[UIImage imageNamed:@"iconfont-13.png"] state:UIControlStateNormal rect:CGRectMake(0, 0, 30, 30) target:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem =rightItem;
    [rightItem release];
 //-----------------------------
    [self setSynopsisLabel];
    

}

- (void)setSynopsisLabel
{
    //tableHeaderView 简介
    UIView *synopsisLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320,170)];
    self.tableView.tableHeaderView =synopsisLabel;
    
    
    
    _headPortrait =[[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 80, 80)];
    //_headPortrait.backgroundColor=[UIColor redColor];
    
    [synopsisLabel addSubview:_headPortrait];
    _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(120, 10, 150, 20)];
    
    _nameLabel.font = [UIFont systemFontOfSize:14];
    
    
    [synopsisLabel addSubview:_nameLabel];
    _genderLable = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, 30, 20)];
    _genderLable.font = [UIFont systemFontOfSize:12];
    [synopsisLabel addSubview:_genderLable];
    _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 50, 100, 20)];
    _cityLabel.font = [UIFont systemFontOfSize:12];
    [synopsisLabel addSubview:_cityLabel];
    
    
    //微博数量,粉丝数,关注数
    //微博数量
    UILabel *weibo = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 50, 20)];
    weibo.text =@"微博";
    //weibo.font = [UIFont systemFontOfSize:12];
    [synopsisLabel addSubview:weibo];
    [weibo release];
    _weboNumabeLabel =[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 50, 30)];
    
    [synopsisLabel addSubview:_weboNumabeLabel];
    //关注数量
    UILabel *attention = [[UILabel alloc] initWithFrame:CGRectMake(120, 110, 50, 20)];
    attention.text =@"关注";
    [synopsisLabel addSubview:attention];
    [attention release];
    _attentionLable = [[UILabel alloc] initWithFrame:CGRectMake(120, 130, 50, 30)];
    
    [synopsisLabel addSubview:_attentionLable];
    //粉丝数目
    UILabel *fans = [[UILabel alloc] initWithFrame:CGRectMake(220, 110, 50, 20)];
    fans.text = @"粉丝";
    [synopsisLabel addSubview:fans];
    [fans release];
    _fansLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 130, 50, 30)];
    
    [synopsisLabel addSubview:_fansLabel];
    //-----------------------------------------

}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView headerBeginRefreshing];
}

-(void) setuoCommentsData
{
    
    NSString *url =@"https://api.weibo.com/2/users/show.json";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [FSPAccountTool account].access_token;
    params[@"uid"] = [FSPAccountTool account].uid;
    NSLog(@"11");
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        _userDic = [[NSDictionary alloc] initWithDictionary:responseObject];
        
        _nameLabel.text = _userDic[@"screen_name"];
//        NSDictionary *statusDic = _userDic[@"status"];
        NSString *urlStr = _userDic[@"avatar_hd"];
        NSLog(@"12345%@",urlStr);
        [_headPortrait setImageWithURL:[NSURL URLWithString:urlStr]];
        NSString *genderStr = _userDic[@"gender"];
        
        if ([genderStr isEqualToString:@"m"]) {
            _genderLable.text = @"男";
        }else if ([genderStr isEqualToString:@"f"]){
            _genderLable.text = @"女";
        }else{
            _genderLable.text = @"未知";
        }
        _cityLabel.text = _userDic[@"location"];
        NSString *weboNumberStr = [NSString stringWithFormat:@"%@",_userDic[@"statuses_count"]];
        NSString *attentionStr = [NSString stringWithFormat:@"%@",_userDic[@"friends_count"]];
        NSString *fansStr = [NSString stringWithFormat:@"%@",_userDic[@"followers_count"]];
        _weboNumabeLabel.text = weboNumberStr;
        _attentionLable.text = attentionStr;
        _fansLabel.text = fansStr;
       
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    [self.tableView headerEndRefreshing];
    
}

-(void)setupButton:(UIButton *)button  setImage:(UIImage *)setImage state:(UIControlState )state rect:(CGRect)rect  target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [button setImage:setImage forState:state];
    button.frame=rect;
    [button addTarget:target action:action forControlEvents:controlEvents];
    
    [self.navigationController.navigationBar addSubview:button];
    
}
-(void)addFrident:(id)sender
{
    FSPaddFriendTableViewController *addFriendVc =[[FSPaddFriendTableViewController alloc] init];
    [self.navigationController pushViewController:addFriendVc animated:YES];
}
-(void)setting:(id)sender
{
    FSPsettingTableViewController *settingVc = [[FSPsettingTableViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
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
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndexPath = @"cell";
    FSPsynopsisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndexPath];
    if (cell == nil) {
        cell = [[[FSPsynopsisTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndexPath]autorelease];
        
    }
  
    
    return cell;
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
