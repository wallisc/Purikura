//
//  PrinterViewController.m
//  Print Club
//
//  Created by  on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrinterViewController.h"

@interface PrinterViewController ()
@property ImageHandler *imageHandler;
@end

@implementation PrinterViewController
@synthesize target = _target;
@synthesize switchSel = _switchSel;
@synthesize imageHandler = _imageHandler;

@synthesize imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageHandler:(ImageHandler *)imageHandler;
{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.imageHandler = imageHandler;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSInteger imageIdx;
    NSMutableArray *photos = [[NSMutableArray alloc] initWithCapacity:kMaxAllowableKeptPhotos];
    for ( imageIdx = 0; imageIdx < kMaxAllowableKeptPhotos; imageIdx++ )
    {
        if ([self.imageHandler getImage:imageIdx] == nil)
        {
            NSLog(@"Image at index %d is nil", imageIdx);
        }
        [photos addObject:[self.imageHandler getImage:imageIdx]];
    }
    /*
    self.imageView.animationImages = photos;
    self.imageView.animationDuration = (NSTimeInterval)kMaxAllowableKeptPhotos;
    self.imageView.animationRepeatCount = 0;
    self.imageView.startAnimating;*/
    NSData *imageData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"moo" withExtension:@"gif"]];
    UIImage *image = [UIImage imageWithData: imageData];
    [self.imageView addSubview:[[UIImageView alloc] initWithImage:image]];
    [self.imageHandler setLayerWithFilmSheet: self.imageView.layer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
