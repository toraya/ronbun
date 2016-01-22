//
//  ClothesImgTableViewController.m
//  Response
//
//  Created by OhnumaRina on 2015/10/23.
//  Copyright (c) 2015年 OhnumaRina. All rights reserved.
//

#import "ClothesImgTableViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ClothesImgTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewcontroller;
@end

@implementation ClothesImgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.tableViewcontroller.delegate = self;
   // self.tableViewcontroller.dataSource = self;
    
//     [self.tableViewcontroller registerNib:[UINib nibWithNibName:@"ClothesImgTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    NSData *data = [userData objectForKey:@"IMAGE_URL"];
    self.imageUrlArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"%@",self.imageUrlArray);
    
    //[self getImageURL];
}

//-(void)getImageURL
//{
//
//    NSString *urlU = [self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *str = [urlU stringByReplacingOccurrencesOfString:@"%13" withString:@""];
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    
//    [manager GET:str parameters:nil
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             self.imagedata = operation.responseString;
//             self.imageUrlArray =[self.imagedata componentsSeparatedByString:@","];             NSLog(@"%@",self.imageUrlArray);
//         }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error){
//             NSLog(@"%@", error);
//         }];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    static NSString *CellIdentifier = @"Cell";
//    // 再利用できるセルがあれば再利用する
//    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (!cell) {
//        // 再利用できない場合は新規で作成
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                      reuseIdentifier:CellIdentifier];
//    }
//    
//    switch (indexPath.section) {
//        case 0:
//            cell.textLabel.text = self.imageUrlArray[indexPath.row];
//            NSLog(@"%@",self.imageUrlArray[indexPath.row]);
//            break;
//    }
//    return cell;
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ClothesImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // Configure the cell...
//    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    
    //NSDictionary *status = [self.imageUrlArray objectAtIndex:indexPath.row];
    NSString *text = [self.imageUrlArray objectAtIndex:indexPath.row];
    NSLog(@"%@",[self.imageUrlArray objectAtIndex:indexPath.row]);
    //cell.textLabel.text = text;
    
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    cell.cloatheimage.image = nil;
    dispatch_async(q_global, ^{
        NSString *imageURL = text;
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString: imageURL]]];
        
        dispatch_async(q_main, ^{
            cell.cloatheimage.image = image;
            [cell layoutSubviews];
        });
    });

    
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
