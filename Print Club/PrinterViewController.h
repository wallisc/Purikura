//
//  PrinterViewController.h
//  Print Club
//
//  Created by  on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchableController.h"
#import "ImageHandler.h"

@interface PrinterViewController : UIViewController <SwitchableController>
@property IBOutlet UIScrollView *imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageHandler:(ImageHandler *)imageHandler;
@end
