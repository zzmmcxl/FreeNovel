//
//  BookStoreViewController.m
//  DreamReader
//
//  Created by macmini on 2017/2/20.
//  Copyright © 2017年 cqz. All rights reserved.
//

#import "BookStoreViewController.h"

@interface BookStoreViewController ()

@end

@implementation BookStoreViewController

#pragma life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - private methods
- (void)initUI {
    
    [self setupNaviBarWithTitle:@"书库"];
    [QMUIHelper renderStatusBarStyleDark];
    [self setupNaviBarWithBtn:NaviLeftBtn title:nil img:@"icon_Search"];
}
#pragma mark - setter and getter

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
