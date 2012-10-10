//
//  FrameGridViewController.m
//  Print Club
//
//  Created by  on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FrameGridViewController.h"

@interface FrameGridViewController ()
@property FrameSelectorModel *frameSelModel;
@end

@implementation FrameGridViewController
@synthesize gridView = _gridView;
@synthesize services = _services;
@synthesize frameSelModel = _frameSelModel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil frameSelectorModel: frameSelModel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.frameSelModel = frameSelModel;
        self.title = @"Select desired frames";
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
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.gridView reloadData];
}

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return [self.frameSelModel numOfFramesAvailable];
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

    [cell checkBox:[self.frameSelModel isSelectedAtIndex:index]];
    cell.image = [self.frameSelModel imageAtIndex:index];
    
    return cell;
    
}

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index
{
	CheckableGridViewCell *cell = (CheckableGridViewCell *)[self.gridView cellForItemAtIndex:index];
    
    // If the cell isn't checked and the user wishes to add that frame
    if (!cell.checked)
    {
        // If the user trying to add more then the maximum allowable frames
        if ( [self.frameSelModel maxFramesSelected] )
        {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Maximum Amount of Frames Selected"
                                                              message:[NSString stringWithFormat:@"You can only have %d frames selected, remove a selected frame if you wish to add more", [self.frameSelModel maxAllowableSelectedFrames]]
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            
            [message show];
            return;
        }
        // Otherwise just add the frame to the selected frames list
        else
            [self.frameSelModel addFrameAtIndex:index];
    }
    // Else if the cell is checked and the user wishes to remove that frame
    else 
    {
        [self.frameSelModel removeSelectedFrameAtIndex:index];
    }
	[cell checkBox: !cell.checked];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
