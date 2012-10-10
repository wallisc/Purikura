//
//  GenreSelectorViewController.m
//  Print Club
//
//  Created by  on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenreSelectorViewController.h"

@interface GenreSelectorViewController ()
@property IBOutlet UIButton* cuteButton;
@property IBOutlet UIButton* funButton;
@property IBOutlet UIButton* prettyButton;
@property IBOutlet UIButton* weirdButton;
@property FrameSelectorModel *frameSelModel;
@end

@implementation GenreSelectorViewController
@synthesize cuteButton = _cuteButton;
@synthesize funButton = _funButton;
@synthesize prettyButton = _prettyButton;
@synthesize weirdButton = _weirdButton;
@synthesize frameSelModel = _frameSelModel;
@synthesize frameGridController = _frameGridController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil frameSelectorModel:(FrameSelectorModel *)frameSelModel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Select a genre";
        self.cuteButton.tag = kCute;
        self.funButton.tag = kFun;
        self.prettyButton.tag = kPretty;
        self.weirdButton.tag = kWeird;
        self.frameSelModel = frameSelModel;
        self.frameGridController = [[FrameGridViewController alloc] initWithNibName:@"FrameGridViewController" bundle:nil frameSelectorModel:self.frameSelModel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)genreSelected:(UIButton *)sender;
{
    [self.frameSelModel genreSelected:sender.tag];
    [self.frameGridController.gridView reloadData];
    [self.navigationController pushViewController:self.frameGridController animated:YES];
}

- (void) refreshTable
{
    [self.frameGridController.gridView reloadData];
}

@end
