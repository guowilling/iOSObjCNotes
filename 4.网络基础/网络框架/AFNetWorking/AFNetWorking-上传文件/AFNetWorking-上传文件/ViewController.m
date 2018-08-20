//
//  ViewController.m
//  AFNetWorking-上传文件
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)upload;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照", @"相册", nil];
    [sheet showInView:self.view.window];
}

#pragma mark - UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    switch (buttonIndex) {
        case 0: {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                return;
            }
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
        case 1: {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                return;
            }
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
    }
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSLog(@"didFinishPickingMediaWithInfo info: %@", info);
    
    [picker dismissViewControllerAnimated:YES completion:nil];

    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
}

- (IBAction)uploadImage {
    
    if (!self.imageView.image) {
        return;
    }
    
    AFHTTPRequestOperationManager *requestOperationManager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary]; // 普通参数
    params[@"username"] = @"gwl";
    params[@"age"] = @25;
    params[@"pwd"] = @"123";
    params[@"height"] = @168;
    [requestOperationManager POST:@"http://localhost:8080/MJServer/upload"
                       parameters:params
        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            // 发送请求之前调用此 block 添加文件参数到 formData
            // 文件参数
            NSData *data = UIImagePNGRepresentation(self.imageView.image);
            [formData appendPartWithFileData:data name:@"file" fileName:@"pic.jpg" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responseObject: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", error);
        }];
}

- (void)uploadURL {
    
    AFHTTPRequestOperationManager *requestOperationManager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"gwl";
    params[@"age"] = @20;
    params[@"pwd"] = @"456";
    params[@"height"] = @168;
    NSString *URL = @"http://localhost:8080/MJServer/upload";
    [requestOperationManager POST:URL
                       parameters:params
        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"abc" withExtension:@"txt"];
            // FileURL  : 上传文件的URL
            // name     : 服务器用于接收文件的参数名
            // fileName : 服务器用于命名文件
            // mimeType : 上传文件的类型
            [formData appendPartWithFileURL:fileURL name:@"file" fileName:@"abc.txt" mimeType:@"text/plain" error:nil];
            
            //NSData *fileData = UIImagePNGRepresentation([UIImage imageNamed:@"xxx"]);
            // FileData : 上传文件的数据
            // name     : 服务器用于接收文件的参数名
            // fileName : 服务器用于命名文件
            // mimeType : 上传文件的类型
            //[formData appendPartWithFileData:fileData name:@"file" fileName:@"xxx.png" mimeType:@"image/png"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responseObject: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", error);
        }];
}

@end
