//
//  SecondViewController.h
//  VerticalPrototype
//
//  Created by  on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define START_BOOTH 0
#define kCounterTime 3.1
#define kTransparencyLevel .5

#import <UIKit/UIKit.h>
#import "ImageHandler.h"
#import "BoothEngine.h"
#import "SwitchableController.h"

@interface PhotoBoothViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, SwitchableController>
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil          
         imageHandler:(ImageHandler *)imageHandler;
- (IBAction)buttonPressed:(UIButton *)sender;
- (void)takePicture;
- (void)displayCounter;
@end
