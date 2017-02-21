//
//  BaseViewController.m
//  ZhouDao
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 CQZ. All rights reserved.
//

#import "BaseViewController.h"
//#import "CompensationVC.h"
//#import "GcNoticeUtil.h"
//#import "PushAlertWindow.h"
//#import "ToolsWedViewVC.h"

@interface BaseViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) NSDictionary *notiDic;

@end

@implementation BaseViewController

- (void)dealloc {
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)initSubviews {
   [super initSubviews];
   [self setAutomaticallyAdjustsScrollViewInsets:NO];

}
#pragma mark - methods
//设置导航标题颜色
- (void)setShowNavTitleColor:(UIColor *)color {
    
//    NSDictionary* dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
//    [self.navigationController.navigationBar setTitleTextAttributes:dict];
   [self.titleView.titleLabel setTextColor:color];

}
//设置左右按钮图片和标题颜色
- (void)setNavBarButtonImageAndTitleColor:(UIColor *)color {
    
    [self.navigationController.navigationBar setTintColor:color];
}
//设置导航背景颜色
- (void)setupNaviBarWithColor:(UIColor *)barColor {
    
    [self.navigationController.navigationBar setBarTintColor:barColor];
}
//设置NavBar中间的title显示文字，
- (void)setupNaviBarWithTitle:(NSString *)title {

    [self setTitle:title];
    [self.titleView.titleLabel setTextColor:UIColorMakeWithHex(@"#333333")];
    


//   NSDictionary* dict = @{NSFontAttributeName:Font_20,NSForegroundColorAttributeName:[UIColor whiteColor]};
//   [self.navigationController.navigationBar setTitleTextAttributes:dict];

}
//设置导航左右按钮
- (void)setupNaviBarWithBtn:(NaviBarBtn)btnTag
                      title:(NSString *)title
                        img:(NSString *)imgName{
    
    SEL selectorName = (btnTag == NaviLeftBtn) ? @selector(leftBtnAction) : @selector(rightBtnAction);

    if (title.length > 0) {
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:selectorName];

        [self accordingWithNaviBarBtn:btnTag withBarButtonItem:btnItem];
        
    } else if (imgName.length > 0) {
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:UIImageMake(imgName) style:UIBarButtonItemStyleDone target:self action:selectorName];
        [self accordingWithNaviBarBtn:btnTag withBarButtonItem:btnItem];
    }
    
    //去除导航栏返回按钮中的文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}
- (void)accordingWithNaviBarBtn:(NaviBarBtn)btnTag withBarButtonItem:(UIBarButtonItem *)btnItem {
    
    if (btnTag == NaviLeftBtn) {
        
        [self.navigationItem setLeftBarButtonItem:btnItem];
    } else {
        [self.navigationItem setRightBarButtonItem:btnItem];
    }
}
//自定义导航的 左右按钮
- (void)setBtnItem:(NaviBarBtn)btnTag
    withCustomView:(UIView *)customView {
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
    [self accordingWithNaviBarBtn:btnTag withBarButtonItem:btnItem];
}
- (void)rightBtnAction {
    
}
- (void)leftBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
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
