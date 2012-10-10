//
//  ZoomedPhotoViewController.m
//  Print Club
//
//  Created by  on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZoomedPhotoViewController.h"

@interface ZoomedPhotoViewController ()
@property (strong) PhotoSelectorModel *photoSelModel;
@end

@implementation ZoomedPhotoViewController
@synthesize photoSelModel = _photoSelModel;
@synthesize imageView = _imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil photoSelectorModel: photoSelModel
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.photoSelModel = photoSelModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.imageView setImage:[self.photoSelModel getSelectedImage]];
}

- (IBAction)buttonPressed:(UIBarButtonItem *)sender
{
    if ( ![self.photoSelModel isSelected] && [self.photoSelModel maxPhotosSelected] )
    {
        NSInteger numNeeded = [self.photoSelModel maxPhotosSelected];
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Maximum Photos Selected"
                                                          message:[NSString stringWithFormat:@"You may only select %d photos, remove other photos if you wish to add more", numNeeded]
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];  
    }
    else
    {
        [self.photoSelModel keepPhoto:sender.tag];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
