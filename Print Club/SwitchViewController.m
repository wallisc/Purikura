//
//  ViewController.m
//  Print Club
//
//  Created by  on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SwitchViewController.h"

@interface SwitchViewController ()

@end

@implementation SwitchViewController
@synthesize state;
@synthesize currentController;
@synthesize dataHandler = _dataHandler;
@synthesize imageHandler = _imageHandler;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize the model data
    self.dataHandler = [[DataHandler alloc] init];
    self.imageHandler = [[ImageHandler alloc] init];
    self.view.autoresizesSubviews = YES;
    
    // Initialize the starting screen
    self.state = kStartScreen;
    StartScreenViewController *startController = [[StartScreenViewController alloc] initWithNibName:@"StartScreenViewController" bundle:nil];
    startController.target = self;
    startController.switchSel = @selector(changeState);
    [self.view insertSubview: startController.view  atIndex:0];
    self.currentController = startController;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)changeState
{
    UIViewController *nextController;
    switch (self.state)
    {
        case kStartScreen:
        {
            nextController = [[TabToolbarViewController alloc] initWithNibName:@"TabToolbarViewController" 
                                                                        bundle: nil
                                                                  imageHandler:self.imageHandler 
                                                                   dataHandler:self.dataHandler];
            ((TabToolbarViewController *)nextController).target = self;
            ((TabToolbarViewController *)nextController).switchSel = @selector(changeState);
            
        }
        break;
        case kFrameSelection:
        {
            nextController = [[PhotoBoothViewController alloc] initWithNibName:@"PhotoBoothViewController" bundle:nil imageHandler:self.imageHandler];
            ((PhotoBoothViewController *)nextController).target = self;
            ((PhotoBoothViewController *)nextController).switchSel = @selector(changeState);
        }
        break;
        case kBooth:
        {
            
            PhotoSelectorViewController* photoSel = [[PhotoSelectorViewController alloc] initWithNibName:@"PhotoSelectorViewController" bundle:nil imageHandler:self.imageHandler];
            photoSel.target = self;
            photoSel.switchSel = @selector(changeState);
            nextController = [[UINavigationController alloc]initWithRootViewController:photoSel];
            CGRect frame = nextController.view.frame;
            nextController.view.frame = CGRectMake(frame.origin.x, frame.origin.y - 20, frame.size.width, frame.size.height);
            
        }
        break;
        case kPhotoSelector:
        {
            nextController = [[EditorViewController alloc] initWithNibName:@"EditorViewController" bundle:nil imageHandler:self.imageHandler dataHandler:self.dataHandler];
            ((EditorViewController *)nextController).target = self;
            ((EditorViewController *)nextController).switchSel = @selector(changeState);
        }
        break;
        case kEditor:
        {
            nextController = [[PrinterViewController alloc] initWithNibName:@"PrinterViewController" bundle:nil imageHandler:self.imageHandler];
        }
        break;
        default:
        {
            NSLog(@"Error: ChangeState called from an unknown state: %d", self.state);
        }
        break;
    }

    self.state++;
    [self switchViewController:self.currentController with:nextController];
    self.currentController = nextController;
    
}

- (void)switchViewController:(UIViewController *)current with: (UIViewController *)next
{   
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    UIViewAnimationTransition transition;
    
    transition = UIViewAnimationTransitionCurlUp;    
    
    [UIView setAnimationTransition: transition forView:self.view cache:YES];
    [next viewWillAppear:YES];
    [current viewWillDisappear:YES];
    [current.view removeFromSuperview];
    [self.view insertSubview: next.view atIndex:0];
    [current viewDidDisappear:YES];
    [next viewDidAppear:YES];
    
    [UIView commitAnimations];
}

@end
