//
//  FrameGridViewCell.h
//  Print Club
//
//  Created by  on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AQGridViewCell.h"

#define kCheckLayer 2

@interface CheckableGridViewCell : AQGridViewCell
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImageView *checkView;
@property bool checked;
- (void) checkBox: (bool) toBeChecked;

@end
