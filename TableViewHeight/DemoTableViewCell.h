//
//  DemoTableViewCell.h
//  TableViewHeight
//
//  Created by Siba Prasad Hota  on 2/19/15.
//  Copyright (c) 2015 wemakeappz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imageModel.h"


@interface DemoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *demoImageView;

-(void)setCelldata:(imageModel *)iModel withImageFrame:(CGRect)iFrame;

@end
