//
//  ReaderTabBarControllerConfig.m
//  DreamReader
//
//  Created by macmini on 2017/2/20.
//  Copyright © 2017年 cqz. All rights reserved.
//

#import "ReaderTabBarControllerConfig.h"
#import "BookShelfViewController.h"
#import "BookStoreViewController.h"
#import "SetingViewController.h"

@interface ReaderTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) QMUITabBarViewController *tabBarController;

@end

@implementation ReaderTabBarControllerConfig

- (QMUITabBarViewController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[QMUITabBarViewController alloc] init];
        _tabBarController.viewControllers = [self viewControllers];
//        //设定Tabbar的颜色
//        [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    }
    return _tabBarController;
}
- (NSArray *)viewControllers {
    BookShelfViewController *bookShelfVC = [BookShelfViewController new];
    bookShelfVC.hidesBottomBarWhenPushed = NO;
    UIViewController *bookShelfNavigationController = [[QMUINavigationController alloc]
                                                  initWithRootViewController:bookShelfVC];
    bookShelfNavigationController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"书架" image:[UIImageMake(@"BookShelf") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"BookShelfSelect") tag:0];
    
    BookStoreViewController *bookStorefVC = [BookStoreViewController new];
    bookStorefVC.hidesBottomBarWhenPushed = NO;
    UIViewController *storeNavigationController = [[QMUINavigationController alloc]
                                                  initWithRootViewController:bookStorefVC];
    storeNavigationController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"书库" image:[UIImageMake(@"BookStore") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"BookStoreSelect") tag:0];

    
    SetingViewController *setingVC = [SetingViewController new];
    setingVC.hidesBottomBarWhenPushed = NO;
    UIViewController *setNavigationController = [[QMUINavigationController alloc]
                                                  initWithRootViewController:setingVC];
    setNavigationController.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"设置" image:[UIImageMake(@"MineSeting") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"MineSetingSelect") tag:0];

    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    //tabBarController.imageInsets = UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    //tabBarController.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
    NSArray *viewControllers = @[
                                 bookShelfNavigationController,
                                 storeNavigationController,
                                 setNavigationController
                                 ];
    return viewControllers;
}

@end
