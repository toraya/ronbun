//
//  SelectViewController.m
//  Response
//
//  Created by OhnumaRina on 2015/10/23.
//  Copyright (c) 2015年 OhnumaRina. All rights reserved.
//

#import "SelectViewController.h"

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
    
    self.url = [NSURL URLWithString:@"http://192.168.1.3:5000/classify"];
    
    UIImagePickerController *imgPic = [[UIImagePickerController alloc]init];
    imgPic.delegate = self;
    [imgPic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: imgPic animated:YES completion:nil];
    
}

-(void)tapUnderBtn:(UIButton *)button{
    
    self.url = [NSURL URLWithString:@"http://192.168.1.3:5000/classify"];
    
    UIImagePickerController *imgPic = [[UIImagePickerController alloc]init];
    imgPic.delegate = self;
    [imgPic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: imgPic animated:YES completion:nil];

}

-(void)tapOuterBtn:(UIButton *)button{
    
    self.url = [NSURL URLWithString:@"http://192.168.1.3:5000/classify"];
    
    UIImagePickerController *imgPic = [[UIImagePickerController alloc]init];
    imgPic.delegate = self;
    [imgPic setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController: imgPic animated:YES completion:nil];
    
}

- (void)imagePickerController :(UIImagePickerController *)picker
        didFinishPickingImage :(UIImage *)image editingInfo :(NSDictionary *)editingInfo {
    // 読み込んだ画像表示
    NSLog(@"selected");
    
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    //[self.view addSubview:iv];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self imageSelect];
}

-(void)alertView{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"完了"
                          message:@"カテゴリー分けしました。"
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Ok", nil];
    
    // アラートビューを表示
    [alert show];
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
    NSString* path = [[NSBundle mainBundle] pathForResource:self.selectImage ofType:@"png"];
    NSData* imageData = [NSData dataWithContentsOfFile:path];
    
    // postデータの作成
    NSMutableData* data = [NSMutableData data];
    
    // 画像の設定
    [data appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data;"] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[NSString stringWithFormat:@"name=\"%@\";", @"image"] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[NSString stringWithFormat:@"filename=\"%@\"\r\n", @"vlcsnap-2015-05-31-00h33m14s99.png"] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[NSString stringWithFormat:@"Content-Type: image/png\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:imageData];
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
                                                    [self alertView];
                                                }
                                            }];
    [task resume];
    

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
