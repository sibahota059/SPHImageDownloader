//
//  DemoTableViewCell.m
//  TableViewHeight
//
//  Created by Siba Prasad Hota  on 2/19/15.
//  Copyright (c) 2015 wemakeappz. All rights reserved.
//

#import "DemoTableViewCell.h"

@implementation DemoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCelldata:(imageModel *)iModel withImageFrame:(CGRect)iFrame
{
    if (iModel.thumbImage)
    {
        self.demoImageView.image = iModel.thumbImage;
        self.demoImageView.frame = CGRectMake(0, 0, iFrame.size.width, iFrame.size.height);
    }
    
}






@end
