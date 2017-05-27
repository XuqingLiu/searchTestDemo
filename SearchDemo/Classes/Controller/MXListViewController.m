//
//  MXListViewController.m
//  SearchDemo
//
//  Created by Christopher on 17/5/26.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import "MXListViewController.h"
#import "ListModel.h"
#import "UserInfoModel.h"
#import "MXListTableViewCell.h"
#import "MBProgressHUD.h"
#import "SVProgressHUD.h"

@interface MXListViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_userListArr;
    ListModel *_userListModel;
    UserInfoModel *_userInfoModel;
    UITableView *_tableView;
    MBProgressHUD *_hud;
    NSString *_reposUrl;
}
@property (nonatomic, assign) NSInteger indexRowTag;
@end

@implementation MXListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _userStr;
    _indexRowTag = nil;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notice) name:@"userList" object:nil];
    
    NSNotificationCenter *centerR = [NSNotificationCenter defaultCenter];
    [centerR addObserver:self selector:@selector(noticeR:) name:@"reposList" object:nil];
    
    [self creatUI];
    [self changeBackBtn];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _userListModel = [[ListModel alloc] init];
    [_userListModel requestDataWithUrl:_userStr];
}

- (void)creatUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.rowHeight = 60;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    _tableView.backgroundView = imageV;
    [self.view addSubview:_tableView];
    //添加HUD
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeDeterminate;
    _hud.labelText = @"Loading...";
}

- (void)changeBackBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 30, 30)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"bg_header_back"] forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = buttonItem;
    [btn addTarget:self action:@selector(BackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)BackButtonClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)notice{
    
    [_hud hide:YES];
    
    if (_userListModel.dataArr.count == 0) {
        [SVProgressHUD showText:@"未找到，请重新输入。" duration:2];
        dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } else {
        [_userListArr removeAllObjects];
        _userListArr = [NSMutableArray arrayWithArray:_userListModel.dataArr];
        [_tableView reloadData];
    }
}

- (void)noticeR:(NSNotification *)notification {
    if (_userInfoModel.dataArr.count == 0) {
        [SVProgressHUD showText:@"未找到，请重新输入。" duration:2];
        dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } else {
        NSString *noti = notification.object;
        NSLog(@"接收到通知！\n语言偏好 : %@ ",noti);
        
        
        // 将接收到的语言偏好更新至View，并刷新该行cell(待完成)
//        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:_indexRowTag inSection:0];
//        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - tableview datasource && delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _userListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MXListTableViewCell *listCell = [MXListTableViewCell cellWithTableView:tableView];
    
    ListModel *model = [_userListArr objectAtIndex:indexPath.row];
    [listCell setAvatarIV:model.avatar_url userName:model.login userType:model.type];
    return listCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ListModel *model = [_userListArr objectAtIndex:indexPath.row];
    _indexRowTag = indexPath.row;
    _reposUrl = model.repos_url;
    
    _userInfoModel = [[UserInfoModel alloc] init];
    [_userInfoModel requestDataWithUrl:_reposUrl];
}

@end
