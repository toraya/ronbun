//
//  ImageViewController.h
//  Response
//
//  Created by OhnumaRina on 2016/01/24.
//  Copyright (c) 2016年 OhnumaRina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *imagedata;
@property (nonatomic, strong) NSMutableArray *imageUrlArray;

@end