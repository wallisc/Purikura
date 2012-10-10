//
//  ZoomedPhotoViewController.h
//  Print Club
//
//  Created by  on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoSelectorModel.h"

#define kKeepPhoto 1
#define kTossPhoto 0

@interface ZoomedPhotoViewController : UIViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil photoSelectorModel: photoSelModel;
@property IBOutlet UIImageView *imageView;
- (IBAction)buttonPressed:(UIBarButtonItem *)sender;
@end
