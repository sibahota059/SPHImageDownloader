//
//  ViewController.m
//  TableViewHeight
//
//  Created by Siba Prasad Hota  on 2/19/15.
//  Copyright (c) 2015 wemakeappz. All rights reserved.
//

#import "ViewController.h"
#import "DemoTableViewCell.h"
#import "imageModel.h"
#import "SPHuserImageDownload.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageURLArray = [[NSArray alloc]initWithObjects:@"http://google.com/m/photos/get_image/mint/db894a440e7817c9a76213f7a08f7b7f.jpg",
                     @"http://google.com/m/photos/get_image/mint/cc224cfbd4bfab15f21f8123aa7c6491.jpg",
                     @"http://google.com/m/photos/get_image/mint/c0dbd6edf498e41fa5273532a6a45e57.jpg",
                     @"http://google.com/flash/modules/video/files/2804.jpg",
                     @"http://google.com/m/photos/get_image/mint/bd006e44a1d01b05fb3f133a809651cf.png",
                     @"http://google.com/m/photos/get_image/mint/da6b8aad45691a6ced6a2ab2a256f104.jpg",
                     @"http://google.com/m/photos/get_image/mint/728499a9d6ddbfad7baf10bda25e2d5c.jpg",
                     @"http://google.com/m/photos/get_image/mint/e784580361bc0331859bb43bc5b2a778.jpg",
                     @"http://google.com/m/photos/get_image/mint/cc224cfbd4bfab15f21f8123aa7c6491.jpg",
                     @"http://google.com/m/photos/get_image/mint/c0dbd6edf498e41fa5273532a6a45e57.jpg",
                     @"http://google.com/flash/modules/video/files/2804.jpg",
                     @"http://google.com/m/photos/get_image/mint/bd006e44a1d01b05fb3f133a809651cf.png",
                     @"http://google.com/m/photos/get_image/mint/da6b8aad45691a6ced6a2ab2a256f104.jpg",
                     @"http://google.com/m/photos/get_image/mint/728499a9d6ddbfad7baf10bda25e2d5c.jpg",
                     @"http://google.com/m/photos/get_image/mint/e784580361bc0331859bb43bc5b2a778.jpg",
                     nil];

    feedArray = [[NSMutableArray alloc]init];
    
    self.imageDownloadsInProgress     = [NSMutableDictionary dictionary];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for (NSString *imgUrl in imageURLArray)
    {
        imageModel *iModel = [[imageModel alloc] initWithThumbUrl:imgUrl];
        [feedArray addObject:iModel];
    }
    [self.demoTableView reloadData];
    [self loadImagesForOnscreenRows];
}

/*********************************************/
#pragma mark ALL TABLE VIEW DELEGATES
/*********************************************/


-(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    imageModel *iModel = [feedArray objectAtIndex:indexPath.row];
    if (iModel.thumbImage)
    {
        UIImage *newImage = [self imageWithImage:iModel.thumbImage scaledToWidth:self.view.frame.size.width];
        return newImage.size.height;
    }
    return 0.4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DemoTableViewCell";
    
    DemoTableViewCell *cell = (DemoTableViewCell *)[self.demoTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    imageModel *iModel = [feedArray objectAtIndex:indexPath.row];
    UIImage *newImage = [self imageWithImage:iModel.thumbImage scaledToWidth:self.view.frame.size.width];
   [cell setCelldata:iModel withImageFrame:CGRectMake(0, 0, newImage.size.width, newImage.size.height)];
    return  cell;
}


#pragma mark - UITableView Delegates

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return feedArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    [self.demoTableView deselectRowAtIndexPath:indexPath animated:YES];
}



#pragma mark - Table cell image support

- (void)loadImagesForOnscreenRows
{
    if (feedArray.count > 0)
    {
        NSArray *visiblePaths = [self.demoTableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            imageModel *iModel = (feedArray)[indexPath.row];
            if (!iModel.thumbImage)
                [self startImageDownload:iModel forIndexPath:indexPath];
        }
    }
}


// -------------------------------------------------------------------------------
//	startIconDownload:forIndexPath:
// -------------------------------------------------------------------------------
- (void)startImageDownload:(imageModel *)iModel forIndexPath:(NSIndexPath *)indexPath
{
    SPHuserImageDownload *iconDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[SPHuserImageDownload alloc] init];
        iconDownloader.feedRecord = iModel;
        [iconDownloader setCompletionHandler:^{
            [self setImageForIndexPath:indexPath feedModel:iModel];
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        (self.imageDownloadsInProgress)[indexPath] = iconDownloader;
        [iconDownloader startDownload];
    }
}

-(void)setImageForIndexPath:(NSIndexPath*)IndexPath feedModel:(imageModel*)iModel
{
    [feedArray replaceObjectAtIndex:IndexPath.row withObject:iModel];
    
    NSArray *indexPaths = [NSArray arrayWithObjects:
                           IndexPath, nil];

    [self.demoTableView  reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
   // [self.demoTableView reloadData];
}

#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDragging:willDecelerate:
//  Load images for all onscreen rows when scrolling is finished.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:scrollView
//  When scrolling stops, proceed to load the app icons that are on screen.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

#pragma mark _______________________________
#pragma mark RoundedSlimProgressBar
#pragma mark -------------------------------


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
