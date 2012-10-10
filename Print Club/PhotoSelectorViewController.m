//
//  PhotoSelectorViewController.m
//  Print Club
//
//  Created by  on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoSelectorViewController.h"

@interface PhotoSelectorViewController ()
@property (strong) PhotoSelectorModel *photoSelModel;
@property (nonatomic, strong) ZoomedPhotoViewController *zoomedViewController;
@end

@implementation PhotoSelectorViewController
@synthesize services = _services;
@synthesize gridView = _gridView;
@synthesize photoSelModel = _photoSelModel;
@synthesize target = _target;
@synthesize switchSel = _switchSel;
@synthesize zoomedViewController = _zoomedViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil imageHandler:(ImageHandler *)imageHandler;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.photoSelModel = [[PhotoSelectorModel alloc] initWithImageHandler:imageHandler];
        self.zoomedViewController = [[ZoomedPhotoViewController alloc] initWithNibName:@"ZoomedPhotoViewController" bundle:nil photoSelectorModel:self.photoSelModel];  
        self.title = @"Select Desired Photos";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 0, 320, 415)];
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.gridView.autoresizesSubviews = YES;
    self.gridView.delegate = self;
    self.gridView.dataSource = self;
    
    [self.view addSubview: self.gridView];
    
    UIImage * backgroundPattern = [UIImage imageNamed:@"background.jpg"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
    
    [self.gridView reloadData];
}

- (IBAction)finished:(UIBarButtonItem *)sender
{
    if ( [self.photoSelModel maxPhotosSelected] )
    {
        [self.photoSelModel commitPhotos];
        [self.target performSelector:self.switchSel];
    }
    else 
    {
        NSInteger numSelected = [self.photoSelModel numberOfPhotosSelected];
        NSInteger numNeeded = [self.photoSelModel numberOfPhotosNeeded] - numSelected;
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Not Enough Photos Selected"
                                                          message:[NSString stringWithFormat:@"You only have %d photos selected, please select %d more", numSelected, numNeeded]
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];  
    }
}

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return [self.photoSelModel numberOfPhotos];
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

    [cell checkBox:[self.photoSelModel isSelectedAtIndex:index]];
    cell.image = [self.photoSelModel photoAtIndex:index];
    
    return cell;
    
}

- (void) refreshTable
{
    [self.gridView reloadData];
}

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index
{
    [self.photoSelModel selectPhotoAtIndex:index];
    [self.navigationController pushViewController:self.zoomedViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshTable];
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

