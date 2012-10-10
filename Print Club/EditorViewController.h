//
//  ViewController.h
//  Editor
//
//  Created by  on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchableController.h"
#import "TableViewController.h"
#import "TabTableViewController.h"
#import "Canvas.h"
#import "ImageHandler.h"
#import "DataHandler.h"

#define kStickerButton 0
#define kMoveScreenButton 1
#define kAddItemButton 2
#define kNextImage 3

#define kCancelAction 0
#define kApplyAction 1

@interface EditorViewController : UIViewController <SwitchableController, UIAlertViewDelegate>
@property IBOutlet UIScrollView *scrollview;
@property IBOutlet UIToolbar *toolbar;
@property (strong) Canvas *canvas;
@property IBOutlet UIView *stickerView;
@property (strong) TabTableViewController *stickerController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageHandler:(ImageHandler *)imageHandler dataHandler:(DataHandler *)dataHandler;
- (IBAction)toolbarSelected:(UIBarButtonItem *)sender;
- (void)nextImage;
@end
