//
//  SetingViewController.m
//  DreamReader
//
//  Created by macmini on 2017/2/20.
//  Copyright © 2017年 cqz. All rights reserved.
//

#import "SetingViewController.h"
#import "UIScrollView+PullScale.h"
#import "SetingTabViewCell.h"
#import "TheMoreOperation.h"
#import <DKNightVersion/DKNightVersion.h>

static NSString *const SETINGTAILCELL = @"setingCellidentifer";

@interface SetingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TheMoreOperation *moreOperation;

@end

@implementation SetingViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

#pragma mark - private methods
- (void)initUI {
    
    self.navigationController.navigationBar.hidden = YES;
    [self.view setBackgroundColor:UIColorMakeWithHex(@"#F2F2F2")];

    [self.view addSubview:self.tableView];
//    self.view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    SetingTabViewCell *cell = (SetingTabViewCell *)[tableView dequeueReusableCellWithIdentifier:SETINGTAILCELL];
    [cell settingUIWithSection:indexPath.section];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        [self.moreOperation showWithContent:[NSDictionary dictionary]];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10.f;
//    return (section == 0) ? 0.1f : 10.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
//    if (section == 0) return nil;
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10.f)];
    [sectionView setBackgroundColor:UIColorMakeWithHex(@"#F2F2F2")];
    return sectionView;
}
#pragma mark - setter and getter
-(UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [_tableView registerClass:[SetingTabViewCell class] forCellReuseIdentifier:SETINGTAILCELL];
//        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView addPullScaleFuncInVC:self originalHeight:245 hasNavBar:(self.navigationController ==nil)];
        _tableView.imageV.image = UIImageMake(@"userinfo_top_bg@2x.jpg");
    }
    return _tableView;
}
- (TheMoreOperation *)moreOperation {
    
    if (!_moreOperation) {
        _moreOperation = [[TheMoreOperation alloc] initWithMoreOperation];
    }
    return _moreOperation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
