//
//  ViewController.h
//  TableViewHeight
//
//  Created by Siba Prasad Hota  on 2/19/15.
//  Copyright (c) 2015 wemakeappz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *imageURLArray;
    NSMutableArray *feedArray;
}

@property (weak, nonatomic) IBOutlet UITableView *demoTableView;
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
@end

