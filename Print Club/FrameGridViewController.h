//
//  FrameGridViewController.h
//  Print Club
//
//  Created by  on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AQGridViewController.h"
#import "CheckableGridViewCell.h"
#import "FrameSelectorModel.h"

@interface FrameGridViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource>
@property (nonatomic, strong) IBOutlet AQGridView *gridView;
@property (nonatomic, strong) NSArray *services;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil frameSelectorModel:(FrameSelectorModel *)frameSelModel;

@end
