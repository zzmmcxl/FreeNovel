//
//  TheMoreOperation.m
//  FaDaMi
//
//  Created by cqz on 17/2/15.
//  Copyright © 2017年 CQZ. All rights reserved.
//

#import "TheMoreOperation.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialSinaHandler.h"

#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController

@interface TheMoreOperation () <QMUIMoreOperationDelegate>

@property (nonatomic, strong) NSDictionary *modelDictionary;
//@property (nonatomic, strong) UIActivityViewController *activityViewController;
@end

@implementation TheMoreOperation

- (instancetype)initWithMoreOperation {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

#pragma mark - methods
- (void)initUI {
    _moreOperationController = [[QMUIMoreOperationController alloc] init];
    _moreOperationController.delegate = self;
    
    [_moreOperationController addItemWithTitle:@"微信好友" image:UIImageMake(@"share_platform_wechat") type:QMUIMoreOperationItemTypeImportant tag:MoreOperationTagShareWechat];
    
    [_moreOperationController addItemWithTitle:@"朋友圈" image:UIImageMake(@"share_platform_wechattimeline") type:QMUIMoreOperationItemTypeImportant tag:MoreOperationTagShareMoment];
    [_moreOperationController addItemWithTitle:@"QQ好友" image:UIImageMake(@"share_platform_qqfriends") type:QMUIMoreOperationItemTypeImportant tag:MoreOperationTagShareQQ];

    [_moreOperationController addItemWithTitle:@"QQ空间" image:UIImageMake(@"share_platform_qzone") type:QMUIMoreOperationItemTypeImportant tag:MoreOperationTagShareQzone];

    [_moreOperationController addItemWithTitle:@"新浪微博" image:UIImageMake(@"share_platform_sina") type:QMUIMoreOperationItemTypeImportant tag:MoreOperationTagShareWeibo];
    
    //第二行
//    [_moreOperationController addItemWithTitle:@"复制链接" image:UIImageMake(@"share_platform_sina") type:QMUIMoreOperationItemTypeImportant tag:MoreOperationTagShareWeibo];
    [_moreOperationController addItemWithTitle:@"浏览器打开" image:UIImageMake(@"icon_moreOperation_openInSafari") type:QMUIMoreOperationItemTypeImportant tag:MoreOperationTagSafari];
    [_moreOperationController addItemWithTitle:@"更多" image:UIImageMake(@"share_platform_system") type:QMUIMoreOperationItemTypeImportant tag:MoreOperationTagSystemShare];

//    [_moreOperationController addItemWithTitle:@"收藏" selectedTitle:@"取消收藏" image:UIImageMake(@"icon_moreOperation_collect") selectedImage:UIImageMake(@"icon_moreOperation_notCollect") type:QMUIMoreOperationItemTypeNormal tag:MoreOperationTagBookMark];
//    QMUIMoreOperationItemView *collectItem = [_moreOperationController itemAtTag:MoreOperationTagBookMark];
//    collectItem.selected = _isSelected;

//    [_moreOperationController setItemHidden:YES tag:MoreOperationTagReport];
    
    _moreOperationController.contentEdgeMargin = 0;
    _moreOperationController.contentMaximumWidth = SCREEN_WIDTH;
    _moreOperationController.contentCornerRadius = 0;
    _moreOperationController.contentBackgroundColor = UIColorMake(246, 246, 246);
    _moreOperationController.cancelButtonHeight = 46;
    _moreOperationController.cancelButtonTitleColor = UIColorMake(34, 34, 34);
    _moreOperationController.cancelButtonFont = UIFontMake(16);
    _moreOperationController.cancelButtonSeparatorColor = UIColorClear;

}

- (void)showWithContent:(NSDictionary *)dictionary {
    
    // 显示更多操作面板
    [_moreOperationController showFromBottom];
}
#pragma mark - QMUIMoreOperationDelegate

- (void)moreOperationController:(QMUIMoreOperationController *)moreOperationController didSelectItemAtTag:(NSInteger)tag {
//    QMUIMoreOperationItemView *itemView = [moreOperationController itemAtTag:tag];
//    NSString *tipString = itemView.titleLabel.text;

    NSString *urlString = @"";
    NSString *contentString = GET(@"");
    NSString *title = @"法大秘分享";
    NSString *imgURLString = @"";

    [moreOperationController hideToBottom];
    

    switch (tag) {
        case MoreOperationTagShareWechat:
            [self shareToPlatformType:1 withTitle:title withContent:contentString withUrl:urlString withImage:imgURLString];

            break;
        case MoreOperationTagShareMoment:
            [self shareToPlatformType:2 withTitle:title withContent:contentString withUrl:urlString withImage:imgURLString];

            break;
        case MoreOperationTagShareQQ:
            [self shareToPlatformType:4 withTitle:title withContent:contentString withUrl:urlString withImage:imgURLString];

            break;
        case MoreOperationTagShareQzone:
            [self shareToPlatformType:5 withTitle:title withContent:contentString withUrl:urlString withImage:imgURLString];

            break;
        case MoreOperationTagShareWeibo:
            [self shareToPlatformType:0 withTitle:title withContent:contentString withUrl:urlString withImage:imgURLString];

            break;
        case MoreOperationTagSearch: //搜索
            
            
            break;
        case MoreOperationTagSafari:
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            break;
        case MoreOperationTagSystemShare: {
            
            NSArray *activityItems = @[title, contentString, urlString];
            
            UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
            
            [kRootViewController presentViewController:activityVC animated:YES completion:^{
                
            }];

            break;
        }
        default:
            break;
    }
    
}
#pragma mark - 设置分享各个平台的方法
- (void)shareToPlatformType:(UMSocialPlatformType)platformType
                  withTitle:(NSString *)title
                withContent:(NSString *)content
                    withUrl:(NSString *)url
                  withImage:(NSString *)imgUrlString {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    id shareThumImage = imgUrlString;
    
    NSString *shareContent = (platformType == 0) ? [NSString stringWithFormat:@"%@ \n%@",content,url] : [NSString stringWithFormat:@"%@ \n%@",title,content];
    
    if (platformType == 0) {//新浪微博
        
        messageObject.text = shareContent;
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        shareObject.shareImage = shareThumImage;
        messageObject.shareObject = shareObject;
    } else {
        
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:content descr:shareContent thumImage:shareThumImage];
        shareObject.webpageUrl = url;
        messageObject.shareObject = shareObject;
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:kRootViewController completion:^(id result, NSError *error) {
        
        if (error) {
            DLog(@"************Share fail with error %@*********",error);
        }else{
            if ([result isKindOfClass:[UMSocialShareResponse class]]) {
                //分享结果消息
                UMSocialShareResponse *resp = result;
                DLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                //                DLog(@"response originalResponse result is %@",resp.originalResponse);
            }else{
                DLog(@"response result is %@",result);
            }
        }
    }];
}

@end
