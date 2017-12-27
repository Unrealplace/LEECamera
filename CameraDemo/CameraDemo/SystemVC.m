//
//  SystemVC.m
//  CameraDemo
//
//  Created by NicoLin on 2017/12/27.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "SystemVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface SystemVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;
}


@end

@implementation SystemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self uploadImage];
}
- (void)uploadImage {
    // 创建并弹出警示框, 选择获取图片的方式(相册和通过相机拍照)
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取图片"
                                                                             message:@"请选择方式"
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [self readImageFromCamera];
                                                   }];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"相册"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      [self readImageFromAlbum];
                                                  }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    
    [alertController addAction:camera];
    [alertController addAction:album];
    [alertController addAction:cancel];
    
    [self presentViewController: alertController animated:YES completion:nil];
}

// 从相册中读取照片
- (void)readImageFromAlbum {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];     // 创建一个UIImagePickerController对象
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;     // 选择资源类型为相册
    
    // 指定代理，代理需服从 <UIImagePickerControllerDelegate>,  <UINavigationControllerDelegate> 协议
    imagePicker.delegate = self;
    
    imagePicker.allowsEditing = YES;    // 是否允许用户编辑
    
    [self presentViewController:imagePicker animated:YES completion:nil];   // 展示相册
}

// 拍照
- (void)readImageFromCamera {
    
    // 判断选择的模式是否为相机模式，如果没有则弹窗警告
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.allowsEditing = YES;    // 允许编辑
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    } else {
        // 未检测到摄像头弹出窗口
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告"
                                                                       message:@"未检测到摄像头"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:confirm];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}

#pragma mark <UIImagePickerControllerDelegate>

// 图片编辑完成之后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    // 让image显示在界面上即可
    //    self.imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 调用
- (IBAction)tapGes:(UITapGestureRecognizer *)sender {
    [self uploadImage];
}




@end
