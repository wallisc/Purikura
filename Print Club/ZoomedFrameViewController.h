//
//  ZoomedFrameViewController.h
//  Print Club
//
//  Created by  on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameSelectorModel.h"

@interface ZoomedFrameViewController : UIViewController
@property IBOutlet UIImageView *imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil frameSelectorModel:(FrameSelectorModel *) frameSelModel;
- (IBAction)removeFrame:(UIButton *)sender;
- (void) refresh;
@end
