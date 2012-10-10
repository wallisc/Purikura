//
//  SelectedGridViewController.h
//  Print Club
//
//  Created by  on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridViewController.h"
#import "FrameSelectorModel.h"
#import "CheckableGridViewCell.h"
#import "ZoomedFrameViewController.h"

@interface SelectedGridViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource>
@property (nonatomic, strong) IBOutlet AQGridView *gridView;
@property (nonatomic, strong) NSArray *services;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil frameSelectorModel:(FrameSelectorModel *)frameSelModel;
- (void) refreshTable;
@end


