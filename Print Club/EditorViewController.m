//
//  ViewController.m
//  Editor
//
//  Created by  on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditorViewController.h"

@interface EditorViewController ()
@property ImageHandler *imageHandler;
@property DataHandler *dataHandler;
@property NSInteger imageIdx;
@end

@implementation EditorViewController
@synthesize stickerView;
@synthesize stickerController;
@synthesize toolbar;
@synthesize scrollview;
@synthesize canvas;
@synthesize target = _target;
@synthesize switchSel = _switchSel;
@synthesize imageHandler = _imageHandler;
@synthesize dataHandler = _dataHandler;
@synthesize imageIdx = _imageIdx;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageHandler:(ImageHandler *)imageHandler dataHandler:(DataHandler *)dataHandler
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    {
        self.imageHandler = imageHandler;
        self.dataHandler = dataHandler;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.stickerController = [[TabTableViewController alloc] initWithNibName:@"TabTableViewController" bundle:nil];
    
    //self.stickerView = self.stickerController.view;
    [self.stickerView addSubview:self.stickerController.view];
    self.stickerView.hidden = YES;
    UIImage *image = [self.imageHandler getImage:0];
    self.canvas = [[Canvas alloc] initWithFrame: CGRectMake(0, 0, image.size.width, image.size.height) backgroundImage: image];
    [self.scrollview setContentSize: [image size]];
    [self.scrollview addSubview:self.canvas];
    self.canvas.parentView = self.scrollview;
    self.scrollview.canCancelContentTouches = NO;
    for (UIGestureRecognizer *r in self.scrollview.gestureRecognizers)
    {
        if ([r isKindOfClass:[UIPanGestureRecognizer class]])
        {
            UIPanGestureRecognizer *panGR = (UIPanGestureRecognizer *)r;
            panGR.minimumNumberOfTouches = 2;              
            panGR.maximumNumberOfTouches = 2;
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)toolbarSelected:(UIBarButtonItem *)sender
{
    switch (sender.tag)
    {
        case kStickerButton:
            self.stickerView.hidden = !self.stickerView.hidden;
            [self.stickerView setNeedsDisplay];
            break;
        case kMoveScreenButton:
            self.canvas.gesturesOn = NO;
            break;
        case kAddItemButton:
        {
            //self.scrollview.userInteractionEnabled = NO;
            NSData *imageData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"cow" withExtension:@"png"]];
            UIImage *image = [UIImage imageWithData: imageData];
            CGPoint topLeftCorner = self.scrollview.contentOffset;
            CGSize scrollViewSize = self.scrollview.frame.size;
            CGPoint centerOfScroll = CGPointMake(topLeftCorner.x + scrollViewSize.width / 2.0, topLeftCorner.y + scrollViewSize.height / 2.0);
            [self.canvas addSticker:image at:centerOfScroll];
            self.canvas.gesturesOn = YES;
            break;
         }
        case kNextImage:
            [self nextImage];
        default:
            break;
    }
}

-(void)nextImage
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Commit Changes?"
                                                      message:[NSString stringWithFormat:@"Would you like to apply your changes and move to the next image?"]
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Apply", nil];
    
    [message show];  
}



- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == kCancelAction)
        return;
    else if (buttonIndex == kApplyAction)
    {
        UIImage *flattenedImage = [ImageHandler imageFromLayer:self.canvas.layer];
        [self.imageHandler setImage:flattenedImage atIndex:self.imageIdx];
        if (++self.imageIdx < kMaxAllowableKeptPhotos )
        {
            UIImage *nextImage = [self.imageHandler getImage:self.imageIdx];
            [self.canvas removeFromSuperview];
            self.canvas = [[Canvas alloc] initWithFrame: CGRectMake(0, 0, nextImage.size.width, nextImage.size.height) backgroundImage: nextImage]; 
            [self.scrollview setContentSize: [nextImage size]];
            [self.scrollview addSubview:self.canvas];
            
            self.canvas.parentView = self.scrollview;
        }
        else
        {
            [self.target performSelector:self.switchSel];
        }
        
    }
}

@end
