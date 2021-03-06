//
//  YoubikeTableViewController.m
//  Youbike
//
//  Created by Eph on 2016/7/5.
//  Copyright © 2016年 AppWorks School WuDuhRen. All rights reserved.
//

#import "YoubikeTableViewController.h"
#import "YoubikeModel.h"
#import "YoubikeManager.h"
#import "YoubikeTableViewCell.h"
#import "MapViewController.h"

@protocol Hello <NSObject>

- (void)sayHello;

@end


@interface YoubikeTableViewController()

@property (strong, nonatomic) NSMutableArray *youbikeModelArray;

@end


@implementation YoubikeTableViewController


- (void)viewMap:(id)sender {
    [self performSegueWithIdentifier:@"MapViewController" sender:nil];
}

static NSString *TableViewCellIdentifier = @"YoubikeTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)setup {
    
    //register nib
    UINib *cellNib = [ UINib nibWithNibName: TableViewCellIdentifier bundle: nil ];
    [ self.tableView registerNib: cellNib forCellReuseIdentifier: TableViewCellIdentifier ];

    //GET data
    __weak YoubikeTableViewController *weakSelf = self;
    [[YoubikeManager sharedManager] GetYoubikesData:^(NSMutableArray *youbikeModelArray) {
        
        weakSelf.youbikeModelArray = youbikeModelArray;
        [weakSelf.tableView reloadData];
    } failureBlock:^{
        //do some error handle
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"MapViewController"])
    {
        MapViewController *viewController = [segue destinationViewController];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.youbikeModelArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YoubikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: TableViewCellIdentifier];
    cell.youbikeModel = self.youbikeModelArray[indexPath.row];
    [cell setup];
    cell.delegate = self;
    
    if (cell == nil) {
        cell = [[YoubikeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: TableViewCellIdentifier];
        cell.youbikeModel = self.youbikeModelArray[indexPath.row];
        [cell setup];
        cell.delegate = self;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}




@end
