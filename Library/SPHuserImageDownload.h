//
//  SPHuserImageDownload.h
//  YACC
//
//  Created by Siba Prasad Hota  on 12/16/14.
//  Copyright (c) 2014 BseTech. All rights reserved.
//

@class imageModel;

#import <Foundation/Foundation.h>

@interface SPHuserImageDownload : NSObject


@property (nonatomic, strong) imageModel *feedRecord;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;


@end
