//
//  SelectViewController.h
//  Response
//
//  Created by OhnumaRina on 2015/10/23.
//  Copyright (c) 2015年 OhnumaRina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface SelectViewController : UIViewController
<UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *topsSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *underSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *outerSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) UIImage *selectImage;

@end
