//
//  TableViewController.m
//  Response
//
//  Created by OhnumaRina on 2016/01/22.
//  Copyright (c) 2016年 OhnumaRina. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView registerNib:[UINib nibWithNibName:@"ClothesImgTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    self.imagedata = [userData objectForKey:@"URL"];
    NSData *data = [userData objectForKey:@"IMAGE_URL"];
    self.imageUrlArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%@",self.imageUrlArray);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Return the number of rows in the section.
    NSInteger dataCount = 0;
    // テーブルに表示するデータ件数を返す
    switch (section) {
        case 0:
            dataCount = self.imageUrlArray.count;
            break;
    }
    NSLog(@"%ld",dataCount);
    return dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        static NSString *CellIdentifier = @"Cell";
        // 再利用できるセルがあれば再利用する
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        if (!cell) {
            // 再利用できない場合は新規で作成
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier];
        }
    
        switch (indexPath.section) {
            case 0:
                cell.textLabel.text = self.imageUrlArray[indexPath.row];
               // NSLog(@"%@",self.imageUrlArray[indexPath.row]);
                
                NSString *text = [self.imageUrlArray objectAtIndex:indexPath.row];
                //NSLog(@"%@",text);
                NSString *url_1 = [self.imagedata stringByAppendingString:@"/"];
                NSString *imageURL = [url_1 stringByAppendingString:text];
                NSString *str_1 = [imageURL stringByReplacingOccurrencesOfString:@" " withString:@""];
                NSString *str = [str_1 stringByReplacingOccurrencesOfString:@"\x13" withString:@""];
                NSURL* url = [NSURL URLWithString:str];
                
                NSData* data = [NSData dataWithContentsOfURL:url];
                
                UIImage *myImage = [UIImage imageWithData:data];
                cell.imageView.image = myImage;
                break;
        }
    
    //    return cell;
    
//    NSString *text = [self.imageUrlArray objectAtIndex:indexPath.row];
//    NSLog(@"%@",[self.imageUrlArray objectAtIndex:indexPath.row]);
//
//    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t q_main = dispatch_get_main_queue();
//    cell.imageView.image = nil;
//    dispatch_async(q_global, ^{
//    NSString *url_1 = [self.imagedata stringByAppendingString:@"/"];
//        NSString *imageURL = [url_1 stringByAppendingString:text];
//        NSLog(@"%@",imageURL);
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];
//        
//        dispatch_async(q_main, ^{
//            cell.imageView.image = image;
//            [cell layoutSubviews];
//        });
//    });
//    NSString *str = [imageURL stringByReplacingOccurrencesOfString:@"\x13" withString:@""];
//    NSURL* url = [NSURL URLWithString:str];
//    
//    NSData* data = [NSData dataWithContentsOfURL:url];
//    
//    cell.imageView.image = [[UIImage alloc] initWithData:data];

    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
