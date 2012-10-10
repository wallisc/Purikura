//
//  TabToolbarViewController.h
//  Print Club
//
//  Created by  on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GenreSelectorViewController.h"
#import "SwitchableController.h"
#import "SelectedGridViewController.h"
#import "ImageHandler.h"
#import "DataHandler.h"
#import "FrameSelectorModel.h"

#define kFrameTabTag 0
#define kSelectedTabTag 1

@interface TabToolbarViewController : UIViewController <SwitchableController>
@property IBOutlet UIView *tabView;
@property IBOutlet UIToolbar *toolbar;
- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil 
         imageHandler:(ImageHandler *)imageHandler
          dataHandler:(DataHandler *)dataHandler;
- (IBAction)changeTab:(UIBarButtonItem *)sender;
- (IBAction)finished:(UIBarButtonItem *)sender;
@end
