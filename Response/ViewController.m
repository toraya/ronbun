//
//  ViewController.m
//  Response
//
//  Created by OhnumaRina on 2015/10/23.
//  Copyright (c) 2015年 OhnumaRina. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.categoryBtn addTarget:self
                         action:@selector(tapCategoryBtn:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.clothesListBtn addTarget:self
                         action:@selector(tapClothesListBtn:)
               forControlEvents:UIControlEventTouchUpInside];

    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)tapCategoryBtn:(UIButton *)button{
    SelectViewController *sv = [[SelectViewController alloc]init];
    [self presentViewController:sv animated:YES completion:nil];
}

-(void)tapClothesListBtn:(UIButton *)button{
    ClothesTableViewController *cv = [[ClothesTableViewController alloc]init];
    [self presentViewController:cv animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
