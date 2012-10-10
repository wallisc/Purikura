//
//  StartScreenViewController.h
//  Print Club
//
//  Created by  on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchableController.h"

@interface StartScreenViewController : UIViewController <SwitchableController>
- (IBAction)start:(UIButton *)sender;
@end
