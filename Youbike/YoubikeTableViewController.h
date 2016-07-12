//
//  YoubikeTableViewController.h
//  Youbike
//
//  Created by Eph on 2016/7/5.
//  Copyright © 2016年 AppWorks School WuDuhRen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewMapDelegate <NSObject>

- (void)viewMap:(id)sender;

@end






@interface YoubikeTableViewController : UITableViewController <ViewMapDelegate>

@end
