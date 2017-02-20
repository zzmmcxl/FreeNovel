//
//  QZAlbumHelperUtils.m
//  FaDaMi
//
//  Created by apple on 17/1/9.
//  Copyright © 2017年 CQZ. All rights reserved.
//

#import "QZAlbumHelperUtils.h"
#import "QDMultipleImagePickerPreviewViewController.h"
#import "QDSingleImagePickerPreviewViewController.h"

static QMUIAlbumContentType const kAlbumContentType = QMUIAlbumContentTypeOnlyPhoto;
#define MultipleImagePickingTag 1047
#define SingleImagePickingTag 1048
#define kRootViewController [UIApplication sharedApplication].keyWindow.rootViewController

@interface QZAlbumHelperUtils () <QMUIAlbumViewControllerDelegate,QMUIImagePickerViewControllerDelegate,QDMultipleImagePickerPreviewViewControllerDelegate,QDSingleImagePickerPreviewViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end
@implementation QZAlbumHelperUtils

- (void)SelectTypePhotosWithSelectType:(ImageSelectType)type
                          withDelegate:(id<QZAlbumHelperUtilsPro>)delegate
                          withLimitNum:(NSUInteger)limitNum {
    
    self.delegate = delegate;
    _type = type;
    if (type == MultipleImageType) {
        self.limitNum = limitNum;
    } else {
        self.limitNum = 1;
    }
    [self initUI];
}

#pragma mark - methods
- (void)initUI {
    
    if (_type == CameraImageType) {
        
        [self initCameraStyle];
    } else {
        
        [self initAlbumStyle];
    }
}
#pragma mark - 相机
- (void)initCameraStyle { 
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        kDISPATCH_GLOBAL_QUEUE_DEFAULT(^{
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            imagePickerController.delegate = self;
            imagePickerController.showsCameraControls = YES;//是否显示照相机标准的控件库
            [imagePickerController setAllowsEditing:YES];//是否加入照相后预览时的编辑功能
            kDISPATCH_MAIN_THREAD(^{
                
                [kRootViewController presentViewController:imagePickerController animated:YES completion:nil];
            });
        });
    } else {
        SHOW_ALERT(@"模拟其中无法打开照相机,请在真机中使用");

    }
}
#pragma mark - 相册选择
- (void)initAlbumStyle {
    
    QMUIAlbumViewController *albumViewController = [[QMUIAlbumViewController alloc] init];
    albumViewController.albumViewControllerDelegate = self;
    albumViewController.contentType = kAlbumContentType;
    
    if (_type == SingleImageType) {
        albumViewController.view.tag = SingleImagePickingTag;
    } else {
        albumViewController.view.tag = MultipleImagePickingTag;
    }
    albumViewController.albumTableViewCellHeight = 85;
    QMUINavigationController *navigationController = [[QMUINavigationController alloc] initWithRootViewController:albumViewController];
    
    /**
     *  requestAuthorization:(void(^)(QMUIAssetAuthorizationStatus status))handler 不在主线程执行，
     *  因此 UI 相关的操作强制放在主流程执行。
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        [kRootViewController presentViewController:navigationController animated:YES completion:NULL];
    });
}
#pragma mark - <QMUIAlbumViewControllerDelegate>

- (QMUIImagePickerViewController *)imagePickerViewControllerForAlbumViewController:(QMUIAlbumViewController *)albumViewController {
    QMUIImagePickerViewController *imagePickerViewController = [[QMUIImagePickerViewController alloc] init];
    imagePickerViewController.imagePickerViewControllerDelegate = self;
    imagePickerViewController.maximumSelectImageCount = _limitNum;
    imagePickerViewController.view.tag = albumViewController.view.tag;
    if (albumViewController.view.tag == SingleImagePickingTag) {
        imagePickerViewController.allowsMultipleSelection = NO;
    }
    imagePickerViewController.minimumImageWidth = (SCREEN_WIDTH/4.f - 5.f);
    return imagePickerViewController;
}
- (void)albumViewControllerDidCancel:(QMUIAlbumViewController *)albumViewController {
    
}
- (void)imagePickerViewControllerDidCancel:(QMUIImagePickerViewController *)imagePickerViewController {
    
}
#pragma mark - <QMUIImagePickerViewControllerDelegate>
- (void)imagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController didFinishPickingImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    
    if ([self.delegate respondsToSelector:@selector(sendMutipleImage:)]) {
        
        [self.delegate sendMutipleImage:imagesAssetArray];
    }
    
}

- (QMUIImagePickerPreviewViewController *)imagePickerPreviewViewControllerForImagePickerViewController:(QMUIImagePickerViewController *)imagePickerViewController {
    if (imagePickerViewController.view.tag == MultipleImagePickingTag) {
        QDMultipleImagePickerPreviewViewController *imagePickerPreviewViewController = [[QDMultipleImagePickerPreviewViewController alloc] init];
        imagePickerPreviewViewController.delegate = self;
        imagePickerPreviewViewController.maximumSelectImageCount = _limitNum;
        imagePickerPreviewViewController.assetsGroup = imagePickerViewController.assetsGroup;
        imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
        return imagePickerPreviewViewController;
    } else {
        QDSingleImagePickerPreviewViewController *imagePickerPreviewViewController = [[QDSingleImagePickerPreviewViewController alloc] init];
        imagePickerPreviewViewController.delegate = self;
        imagePickerPreviewViewController.assetsGroup = imagePickerViewController.assetsGroup;
        imagePickerPreviewViewController.view.tag = imagePickerViewController.view.tag;
        return imagePickerPreviewViewController;
    }
}
#pragma mark - <QMUIImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(QMUIImagePickerPreviewViewController *)imagePickerPreviewViewController didCheckImageAtIndex:(NSInteger)index {
    if (imagePickerPreviewViewController.view.tag == MultipleImagePickingTag) {
        // 在预览界面选择图片时，控制显示当前所选的图片，并且展示动画
        QDMultipleImagePickerPreviewViewController *customImagePickerPreviewViewController = (QDMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController;
        NSUInteger selectedCount = [imagePickerPreviewViewController.selectedImageAssetArray count];
        if (selectedCount > 0) {
            customImagePickerPreviewViewController.imageCountLabel.text = [[NSString alloc] initWithFormat:@"%ld", (long)selectedCount];
            customImagePickerPreviewViewController.imageCountLabel.hidden = NO;
            [QMUIImagePickerHelper springAnimationOfImageSelectedCountChangeWithCountLabel:customImagePickerPreviewViewController.imageCountLabel];
        } else {
            customImagePickerPreviewViewController.imageCountLabel.hidden = YES;
        }
    }
}

#pragma mark - <QDMultipleImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(QDMultipleImagePickerPreviewViewController *)imagePickerPreviewViewController sendImageWithImagesAssetArray:(NSMutableArray<QMUIAsset *> *)imagesAssetArray {
    
    if ([self.delegate respondsToSelector:@selector(sendMutipleImage:)]) {
        
        [self.delegate sendMutipleImage:imagesAssetArray];
    }
    
}

#pragma mark - <QDSingleImagePickerPreviewViewControllerDelegate>

- (void)imagePickerPreviewViewController:(QDSingleImagePickerPreviewViewController *)imagePickerPreviewViewController didSelectImageWithImagesAsset:(QMUIAsset *)imageAsset {
    
    if ([self.delegate respondsToSelector:@selector(sendSingleImage:)]) {
        
        [self.delegate sendSingleImage:imageAsset.originImage];
    }
}

#pragma mark - cameraPhotoDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [kRootViewController dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info { WEAKSELF
    

    [kRootViewController dismissViewControllerAnimated:YES completion:^{
        //打印出字典中的内容
        //DMLog( info );
        NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
        if ([type isEqualToString:@"public.image"]) {//UIImagePickerControllerOriginalImage UIImagePickerControllerEditedImage
            UIImage* getImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"]; // 裁剪后的图片
            kDISPATCH_GLOBAL_QUEUE_DEFAULT(^{
                
                UIImageWriteToSavedPhotosAlbum(getImage, nil, nil, nil);//保存相册
            });
            
            if ([weakSelf.delegate respondsToSelector:@selector(sendCameraImage:)]) {
                
                [weakSelf.delegate sendCameraImage:getImage];
            }
            
        }
    }];
}


@end
