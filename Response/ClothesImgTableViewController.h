//
//  ClothesImgTableViewController.h
//  Response
//
//  Created by OhnumaRina on 2015/10/23.
//  Copyright (c) 2015年 OhnumaRina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClothesImgTableViewCell.h"

@interface ClothesImgTableViewController : UITableViewController

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *imagedata;
@property (nonatomic, strong) NSMutableArray *imageUrlArray;

@end
