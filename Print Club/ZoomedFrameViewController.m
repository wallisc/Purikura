//
//  ZoomedFrameViewController.m
//  Print Club
//
//  Created by  on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZoomedFrameViewController.h"

@interface ZoomedFrameViewController ()
@property FrameSelectorModel *frameSelModel;
@end

@implementation ZoomedFrameViewController
@synthesize frameSelModel = _frameSelModel;
@synthesize imageView = _imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil frameSelectorModel: frameSelModel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.frameSelModel = frameSelModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.imageView setImage:[self.frameSelModel getSpecifiedImage]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (IBAction)removeFrame:(UIButton *)sender
{
    [self.frameSelModel removeSpecifiedImage];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) refresh
{
    [self.imageView setImage:[self.frameSelModel getSpecifiedImage]];
}

@end
