//
//  PhotoSelectorViewController.h
//  Print Club
//
//  Created by  on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridViewController.h"
#import "CheckableGridViewCell.h"
#import "ImageHandler.h"
#import "PhotoSelectorModel.h"
#import "SwitchableController.h"
#import "ZoomedPhotoViewController.h"

@interface PhotoSelectorViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource, SwitchableController>
@property (nonatomic, strong) IBOutlet AQGridView *gridView;
@property (nonatomic, strong) NSArray *services;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageHandler:(ImageHandler *)imageHandler;
- (IBAction)finished:(UIBarButtonItem *)sender;
@end
