//
//  ClothesTableViewController.h
//  Response
//
//  Created by OhnumaRina on 2015/10/23.
//  Copyright (c) 2015年 OhnumaRina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClothesTableViewCell.h"
#import "ClothesImgTableViewController.h"

#import "TableViewController.h"
#import "ImageViewController.h"

@interface ClothesTableViewController : UITableViewController

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSArray *imageUrl;

@end
