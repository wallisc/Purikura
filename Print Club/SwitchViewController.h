//
//  ViewController.h
//  Print Club
//
//  Created by  on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartScreenViewController.h"
#import "SwitchableController.h"
#import "TabToolbarViewController.h"
#import "ImageHandler.h"
#import "DataHandler.h"
#import "PhotoBoothViewController.h"
#import "PhotoSelectorViewController.h"
#import "EditorViewController.h"
#import "PrinterViewController.h"

typedef enum {
    kStartScreen, kFrameSelection, kBooth, kPhotoSelector, kEditor, kPrint
} State;

@interface SwitchViewController : UIViewController
@property State state;
@property UIViewController *currentController;
@property (strong) ImageHandler *imageHandler;
@property (strong) DataHandler *dataHandler;
- (void) changeState;
- (void)switchViewController: (UIViewController *) current with: (UIViewController *)next;
@end
