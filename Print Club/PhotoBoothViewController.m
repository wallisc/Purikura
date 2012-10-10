//
//  SecondViewController.m
//  VerticalPrototype
//
//  Created by  on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoBoothViewController.h"

@interface PhotoBoothViewController ()

@property IBOutlet UIButton* startButton;
@property (strong, readwrite, nonatomic) UIImageView* imageView;
@property (strong, readwrite, nonatomic) UIImageView* counterImageView;
@property (strong, readwrite, nonatomic) UIImagePickerController *imagePickerController;
@property (strong) BoothEngine *boothEngine;

@end

@implementation PhotoBoothViewController

@synthesize startButton = _startButton;
@synthesize imagePickerController = _imagePickerController;
@synthesize imageView = _imageView;
@synthesize counterImageView = _counterImageView;
@synthesize boothEngine = _boothEngine;
@synthesize target = _target;
@synthesize switchSel = _switchSel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil          
         imageHandler:(ImageHandler *)imageHandler
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Setup the image picker controller
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.delegate = self;
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        self.imagePickerController.wantsFullScreenLayout = YES;
        
        // Setup the booth engine
        self.boothEngine = [[BoothEngine alloc] initWithImageHandler:imageHandler];
        [self.boothEngine addObserver:self forKeyPath:@"counterTrigger"
                         options:(NSKeyValueObservingOptionNew)
                         context:nil];
        [self.boothEngine addObserver:self forKeyPath:@"photoTrigger"
                              options:(NSKeyValueObservingOptionNew)
                              context:nil];
        
        UIImage *image = [self.boothEngine getNextFrame];
        self.imageView = [[UIImageView alloc] initWithImage:image];

        // Create a counter image that will be displayed when there are 3 seconds left till the camera takes a picture
        NSMutableArray *counter = [[NSMutableArray alloc] initWithCapacity:3];
        NSData *imageData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"three" withExtension:@"png"]];
        image = [UIImage imageWithData: imageData];
        self.counterImageView = [[UIImageView alloc] initWithImage:image];
        [counter addObject: image];
        imageData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"two" withExtension:@"png"]];
        image = [UIImage imageWithData: imageData];
        [counter addObject: image];
        imageData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"one" withExtension:@"png"]];
        image = [UIImage imageWithData: imageData];
        [counter addObject: image];
        self.counterImageView.animationImages = counter;
        self.counterImageView.animationDuration = (NSTimeInterval)kCounterTime;
        self.counterImageView.animationRepeatCount = 1;
        self.counterImageView.alpha = kTransparencyLevel;
        
    }
    
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    CGRect frame = self.view.frame;
    self.imageView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + 15);
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ( [self.boothEngine maxPhotosTaken] )
    {
        [self.target performSelector:self.switchSel];
    }
}


- (void)viewDidUnload
{
    self.startButton = nil;
    self.boothEngine = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait; 
}

- (IBAction)buttonPressed:(UIButton *)sender
{
    // If the start button was pushed
    if ( sender.tag == START_BOOTH)
    {
        self.startButton.hidden = YES;
        [self.boothEngine start];

        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerCameraDeviceFront])
        {
            
            self.imagePickerController.showsCameraControls = NO;
             
            if ([[self.imagePickerController.cameraOverlayView subviews] count] == 0)
            {
                [self.imagePickerController.cameraOverlayView addSubview:self.imageView];
                [self.imagePickerController.cameraOverlayView addSubview:self.counterImageView];

                self.counterImageView.hidden = YES;

            }
            [self presentModalViewController:self.imagePickerController animated:YES];
        }
    }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

// this get called when an image has been chosen from the library or taken from the camera
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self.boothEngine photoTaken:image];
    
    // If all the needed pictures have been taken
    if ( [self.boothEngine maxPhotosTaken] )
    {
        [self.boothEngine close];
        [self.boothEngine removeObserver:self forKeyPath:@"counterTrigger"];
        [self.boothEngine removeObserver:self forKeyPath:@"photoTrigger"];
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    // Otherwise apply the next frame
    else 
    {
        image = [self.boothEngine getNextFrame];
        [self.imageView setImage:image];
    }
}

// If the camera action was cancelled
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:^{}];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ( [keyPath isEqual:@"counterTrigger"] )
    {
        [self displayCounter];
    }
    else if ( [keyPath isEqual:@"photoTrigger"] )
    {
        [self takePicture];
        
    }
}

- (void) takePicture
{
    NSLog(@"Picture taken");
    self.counterImageView.hidden = YES;
    self.counterImageView.stopAnimating;
    [self.imagePickerController takePicture];
    [self.imageView setImage:[self.boothEngine getNextFrame]];
}

- (void)displayCounter
{
    self.counterImageView.hidden = NO;
    self.counterImageView.startAnimating;
}

@end
