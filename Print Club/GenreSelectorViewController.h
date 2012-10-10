//
//  GenreSelectorViewController.h
//  Print Club
//
//  Created by  on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameSelectorModel.h"
#import "FrameGridViewController.h"

@interface GenreSelectorViewController : UIViewController
@property (strong) FrameGridViewController *frameGridController;

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil 
   frameSelectorModel:(FrameSelectorModel *)frameSelModel;
- (IBAction)genreSelected:(UIButton *)sender;
- (void) refreshTable;
@end
