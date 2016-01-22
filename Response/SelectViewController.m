//
//  SelectViewController.m
//  Response
//
//  Created by OhnumaRina on 2015/10/23.
//  Copyright (c) 2015年 OhnumaRina. All rights reserved.
//

#import "SelectViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface SelectViewController ()

@end

@implementation SelectViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.backBtn addTarget:self
                     action:@selector(tapBackBtn:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.topsSelectBtn addTarget:self
                           action:@selector(tapTopsBtn:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.underSelectBtn addTarget:self
                            action:@selector(tapUnderBtn:)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.outerSelectBtn addTarget:self
                            action:@selector(tapOuterBtn:)
                  forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

-(void)tapBackBtn:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:NULL];

}
-(void)tapTopsBtn:(UIButton *)button{
    
    //self.url = [NSURL URLWithString:@"http://192.168.1.3:4000/classify"];
    self.url = @"http://192.168.1.3:4000/classify";

    
    UIImagePickerController *imgPic = [[UIImagePickerController alloc]init];
    imgPic.delegate = self;
    [imgPic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: imgPic animated:YES completion:nil];
    
}

-(void)tapUnderBtn:(UIButton *)button{
    
    //self.url = [NSURL URLWithString:@"http://192.168.1.3:5000/classify"];
    self.url = @"http://192.168.1.3:5000/classify";

    
    UIImagePickerController *imgPic = [[UIImagePickerController alloc]init];
    imgPic.delegate = self;
    [imgPic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: imgPic animated:YES completion:nil];
}
//
//-(void)tapOuterBtn:(UIButton *)button{
//    self.url = [NSURL URLWithString:@"http://192.168.1.3:5000/classify"];
//    UIImagePickerController *imgPic = [[UIImagePickerController alloc]init];
//    imgPic.delegate = self;
//    [imgPic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//    [self presentViewController: imgPic animated:YES completion:nil];
//    
//}

-(void)tapOuterBtn:(UIButton *)button{
    //self.url = [NSURL URLWithString:@"http://192.168.1.3:3000/classify"];
      self.url = @"http://192.168.1.3:3000/classify";
    
    UIImagePickerController *imgPic = [[UIImagePickerController alloc]init];
    imgPic.delegate = self;
    [imgPic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: imgPic animated:YES completion:nil];

}



- (void)imagePickerController :(UIImagePickerController *)picker
        didFinishPickingImage :(UIImage *)image editingInfo :(NSDictionary *)editingInfo {
    
    //画像が選択されたとき。オリジナル画像をUIImageViewに突っ込む
    self.selectImage = image;
    
    // 読み込んだ画像表示
    NSLog(@"selected");
    
    
    
    //UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    //[self.view addSubview:iv];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self imageSelect];
    [self uploadButtonTouched];
}

-(void)imageSelect
{
    NSString* boundary = @"MyBoundaryString";
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.HTTPAdditionalHeaders =
    @{
      @"Content-Type" : [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]
      };
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:self.url];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    // アップロードする画像
    NSData* jpgData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(self.selectImage, 0.5f)];
    NSString* jpg64Str = [jpgData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
    
//    NSString* path = [[NSBundle mainBundle] pathForResource:self.selectImage ofType:@"png"];
//    NSData* imageData = [NSData dataWithContentsOfFile:path];
     NSData* imageData = [NSData dataWithContentsOfFile:jpg64Str];
    NSLog(@"%@",imageData);
    // postデータの作成
    NSMutableData* data = [NSMutableData data];
    
    // 画像の設定
    [data appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data;"] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[NSString stringWithFormat:@"name=\"%@\";", @"image"] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[NSString stringWithFormat:@"filename=\"%@\"\r\n", @"vlcsnap-2015-05-31-00h33m14s99.jpg"] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[NSString stringWithFormat:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:jpgData];
    [data appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 最後にバウンダリを付ける
    [data appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = data;
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                // 完了時の処理
                                                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                                NSLog(@"%@",array);
                                                NSLog(@"%@,%@", [array valueForKeyPath:@"label"], [array valueForKeyPath:@"label_name"]);
                                                if([array valueForKeyPath:@"label"] == nil) {
                                                    //[self alertView];
                                                }
                                            }];
    [task resume];
    

}

-(void)uploadButtonTouched
{
    NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(self.selectImage, 0.1)];
   // NSLog(@"%@", imageData);
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:self.url]];
    NSDictionary *parameters = nil;
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    
    AFHTTPRequestOperation *op = [manager POST:self.url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"image.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        NSLog(@"%@,%@", [responseObject valueForKeyPath:@"label"],[responseObject valueForKeyPath:@"label_name"]);
        [self sucessView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        [self alertView];
    }];

    [op start];
    

}


-(void)sucessView{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"完了"
                          message:@"カテゴリー分けしました。"
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Ok", nil];
    
    // アラートビューを表示
    [alert show];
}

-(void)alertView
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"失敗"
                          message:@"カテゴリー分けに失敗しました。"
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Ok", nil];
    
    // アラートビューを表示
    [alert show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
