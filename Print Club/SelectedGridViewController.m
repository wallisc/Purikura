//
//  SelectedGridViewController.m
//  Print Club
//
//  Created by  on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectedGridViewController.h"

@interface SelectedGridViewController ()
@property (strong) FrameSelectorModel *frameSelModel;
@property (strong) ZoomedFrameViewController *zoomedImage;
@end

@implementation SelectedGridViewController
@synthesize gridView = _gridView;
@synthesize services = _services;
@synthesize frameSelModel = _frameSelModel;
@synthesize zoomedImage = _zoomedImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil frameSelectorModel: frameSelModel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.frameSelModel = frameSelModel;
        self.title = @"Selected Frames";
        self.zoomedImage = [[ZoomedFrameViewController alloc] initWithNibName:@"ZoomedFrameViewController" bundle:nil frameSelectorModel:self.frameSelModel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 0, 320, 456)];
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.gridView.autoresizesSubviews = YES;
    self.gridView.delegate = self;
    self.gridView.dataSource = self;
    
    [self.view addSubview: self.gridView];
    
    UIImage * backgroundPattern = [UIImage imageNamed:@"background.jpg"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
    
    [self.gridView reloadData];
}

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return [self.frameSelModel numOfSelectedFrames];
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( CGSizeMake(224.0, 168.0) );
}

- (AQGridViewCell *) gridView: (AQGridView *) aGridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * PlainCellIdentifier = @"PlainCellIdentifier";
    
    CheckableGridViewCell* cell = (CheckableGridViewCell *)[aGridView dequeueReusableCellWithIdentifier:@"PlainCellIdentifier"];
    
    if ( cell == nil )
    {
        cell = [[CheckableGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 50.0, 150.0)
                                        reuseIdentifier: PlainCellIdentifier];
        cell.selectionGlowColor = [UIColor whiteColor];
    }
    if ([self.frameSelModel selectedFrameAtIndex:index] == nil)
        NSLog(@"Cell %d: failed to load image", index);
    cell.image = [self.frameSelModel selectedFrameAtIndex:index];
    
    return cell;
    
}

- (void) refreshTable
{
    [self.gridView reloadData];
}

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index
{
    [self.frameSelModel selectedFrameSpecified:index];
    [self.zoomedImage refresh];
    [self.navigationController pushViewController:self.zoomedImage animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshTable];
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
