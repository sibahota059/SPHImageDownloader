//
//  imageModel.h
//  TableViewHeight
//
//  Created by Siba Prasad Hota  on 2/19/15.
//  Copyright (c) 2015 wemakeappz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface imageModel : NSObject


@property(nonatomic,strong)  UIImage *thumbImage;
@property(nonatomic,strong)  NSString *thumbUrl;

-(id)initWithThumbUrl :(NSString*)thumbUrl;

@end
