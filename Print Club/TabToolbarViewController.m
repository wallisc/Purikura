//
//  TabToolbarViewController.m
//  Print Club
//
//  Created by  on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TabToolbarViewController.h"

@interface TabToolbarViewController ()
@property (strong) UINavigationController *frameNav;
@property (strong) UINavigationController *selectedNav;
@property (strong) FrameSelectorModel *frameSelModel;
@property (strong) SelectedGridViewController *selectedFrames;
@property (strong) GenreSelectorViewController *genreSelector;
@end

@implementation TabToolbarViewController
@synthesize toolbar = _toolbar;
@synthesize tabView = _tabView;
@synthesize frameNav = _frameNav;
@synthesize frameSelModel = _frameSelModel;
@synthesize selectedNav = _selectedNav;
@synthesize genreSelector = _genreSelector;
@synthesize selectedFrames = _selectedFrames;
@synthesize target = _target;
@synthesize switchSel = _switchSel;

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil 
         imageHandler:(ImageHandler *)imageHandler
          dataHandler:(DataHandler *)dataHandler
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.frameSelModel = [[FrameSelectorModel alloc] initWithImageHandler: imageHandler andDataHandler: dataHandler];
        self.genreSelector = [[GenreSelectorViewController alloc] initWithNibName:@"GenreSelectorViewController" bundle:nil frameSelectorModel:self.frameSelModel];
        self.selectedFrames = [[SelectedGridViewController alloc] initWithNibName:@"SelectedGridViewController" bundle:nil frameSelectorModel:self.frameSelModel];
        self.frameNav = [[UINavigationController alloc] initWithRootViewController:self.genreSelector];
        self.selectedNav = [[UINavigationController alloc] initWithRootViewController:self.selectedFrames];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.frameNav.toolbarHidden = YES;
    self.frameNav.hidesBottomBarWhenPushed = YES;
    self.selectedNav.toolbarHidden = YES;
    self.selectedNav.hidesBottomBarWhenPushed = YES;
    [self.tabView addSubview: self.frameNav.view];
    
    // Shift the navigation view up 20 points. Because the navigation view is not the whole view, it needs to be shifted up to account for the placement of the status bar
    CGRect frame = self.tabView.frame;
    self.frameNav.view.frame = frame;
    self.selectedNav.view.frame = frame;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.frameNav = nil;
    self.selectedNav = nil;
    self.frameSelModel = nil;
    self.selectedFrames = nil;
    self.genreSelector = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)changeTab:(UIBarButtonItem *)sender
{
    UIView *newView;
    UIView *curView = [self.tabView.subviews objectAtIndex:0];
    switch (sender.tag)
    {
        case kFrameTabTag:
            newView = self.frameNav.view;
            [self.genreSelector refreshTable];
            break;
        case kSelectedTabTag:
            newView = self.selectedNav.view;
            [self.selectedFrames refreshTable];
            break;
        default:
            break;

    }

    [curView removeFromSuperview];
    [self.tabView insertSubview:newView atIndex:0];
}

- (IBAction)finished:(UIButton *)sender
{
    if ( [self.frameSelModel maxFramesSelected] )
    {
        [self.frameSelModel commitFrames];
        [self.target performSelector:self.switchSel];
    }
    else 
    {
        NSInteger numSelected = [self.frameSelModel numOfSelectedFrames];
        NSInteger numNeeded = [self.frameSelModel maxAllowableSelectedFrames] - numSelected;
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Not Enough Frames Selected"
                                                          message:[NSString stringWithFormat:@"You only have %d frames selected, please select %d more", numSelected, numNeeded]
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];    
    }
}

@end
