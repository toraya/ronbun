//
//  TableViewController.h
//  Response
//
//  Created by OhnumaRina on 2016/01/22.
//  Copyright (c) 2016年 OhnumaRina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClothesImgTableViewCell.h"

@interface TableViewController : UITableViewController
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *imagedata;
@property (nonatomic, strong) NSMutableArray *imageUrlArray;
@end
