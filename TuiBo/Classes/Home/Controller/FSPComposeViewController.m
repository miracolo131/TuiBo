//
//  FSPComposeViewController.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/22.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPComposeViewController.h"
#import "FSPComposeTextView.h"
#import "FSPComposeToolBar.h"
#import "FSPAccount.h"
#import "FSPAccountTool.h"
//#import "FSPStatusTool.h"
#import "MBProgressHUD+MJ.h"
#import "FSPComposeToolbar.h"
#import "FSPComposePhotosView.h"
#import "FSPComposeStatusParam.h"
#import "FSPComposeStatusResult.h"
#import "FSPFormData.h"
#import "FSPHttpTool.h"
//#import "FSPStatusTool.h"

#import "AFNetworking.h"
#import "StatusesAPI.h"
#import "MJExtension.h"

@interface FSPComposeViewController ()<UITextViewDelegate, FSPComposeToolbarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) FSPComposeTextView *textView;
@property (nonatomic, retain) FSPComposeToolBar *toolbar;
@property (nonatomic, retain) FSPComposePhotosView *photosView;


@end

@implementation FSPComposeViewController

- (void)dealloc
{
    [_textView release];
    [_toolbar release];
    [_photosView release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

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
    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加textView
    [self setupTextView];
    
    // 添加toolbar
    [self setupToolbar];
    
    // 添加photosView
    [self setupPhotosView];

}

/**
 *  添加photosView
 */
- (void)setupPhotosView
{
    FSPComposePhotosView *photosView = [[FSPComposePhotosView alloc] init];
    CGFloat photosWidth = self.textView.frame.size.width;
    CGFloat photosHeight = self.textView.frame.size.height;
    CGFloat photosY = 80;
    photosView.frame = CGRectMake(0, photosY, photosWidth, photosHeight);
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

/**
 *  添加toolbar
 */
- (void)setupToolbar
{
    FSPComposeToolBar *toolbar = [[FSPComposeToolBar alloc] init];
    toolbar.delegate = self;
    CGFloat toolbarHeight = 44;
    CGFloat toolbarWidth = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarHeight;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarWidth, toolbarHeight);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

#pragma mark - toolbar的代理方法
- (void)composeToolbar:(FSPComposeToolBar *)toolbar didClickedButton:(FSPComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case FSPComposeToolbarButtonTypeCamera: // 相机
            [self openCamera];
            break;
            
        case FSPComposeToolbarButtonTypePicture: // 相册
            [self openPhotoLibrary];
            break;
            
        default:
            break;
    }
}

/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
}

/**
 *  添加textView
 */
- (void)setupTextView
{
    // 1.添加
    FSPComposeTextView *textView = [[FSPComposeTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    // 垂直方向上永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.监听textView文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 3.监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

/**
 *  监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
}

/**
 *  设置导航栏属性
 */
- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

/**
 *  取消
 */
- (void)cancel
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  发微博
 */
- (void)send
{
    if (self.photosView.totalImages.count) { // 有图片
//        NSLog(@"图片 个数 %lu", self.photosView.totalImages.count);
        [MBProgressHUD showMessage:@"正在发送中, 请稍等"];
        [self sendWithImage];
    } else { // 没有图片
//        NSLog(@"没有图片");
        [MBProgressHUD showMessage:@"正在发送中, 请稍等"];
        [self sendWithoutImage];
    }
    
    // 关闭控制器
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  发有图片的微博
 */
- (void)sendWithImage
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
//        params[@"status"] = [self.textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    params[@"access_token"] = [FSPAccountTool account].access_token;
    
    // 2.封装文件参数
    NSMutableArray *formDataArray = [NSMutableArray array];
    NSArray *images = [self.photosView totalImages];
    for (UIImage *image in images) {
        FSPFormData *formData = [[FSPFormData alloc] init];
        formData.data = UIImageJPEGRepresentation(image, 0.000001);
        formData.name = @"pic";
        formData.mimeType = @"image/jpeg";
        formData.filename = @"";
        [formDataArray addObject:formData];
    }
//    NSLog(@"%lu, 图片张数", [formDataArray count]);
    [FSPHttpTool postWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params formDataArray:formDataArray success:^(id json) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"发送失败"];
        NSLog(@"%@ error", error);
    }];

}

/**
 *  发没有图片的微博
 */
- (void)sendWithoutImage
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    //        params[@"status"] = [self.textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    params[@"access_token"] = [FSPAccountTool account].access_token;

    [FSPHttpTool postWithURL:kStatuses_update params:params success:^(id json) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"发送失败"];
        NSLog(@"%@", error);
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
