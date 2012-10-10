//
//  BoothEngine.m
//  Print Club
//
//  Created by  on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BoothEngine.h"

@interface BoothEngine ()
@property (strong) ImageHandler *imageHandler;
@property (strong) NSMutableArray *photos;
@property NSInteger time;
@property (strong) NSTimer *timer;
@end


@implementation BoothEngine
@synthesize imageHandler = _imageHandler;
@synthesize time = _time;
@synthesize photos = _photos;
@synthesize photoTrigger = _photoTrigger;
@synthesize counterTrigger = _counterTrigger;
@synthesize timer = _timer;

- (id) initWithImageHandler: (ImageHandler *)imageHandler
{
    self = [super init];
    if ( self )
    {
        self.imageHandler = imageHandler;
        self.time = -kInitialCameraDelay;
        self.photoTrigger = self.counterTrigger = 0;
        self.photos = [[NSMutableArray alloc] initWithCapacity:kMaxAllowablePhotos];
    }
    return self;
    
}

- (void) start
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(update)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void) update
{
    // If there is 3 seconds left till the next photo, display a counter
    if ( ++self.time == kCameraDelayPerPhoto - 3 )
    {
        self.counterTrigger++;
    }
    // If kCameraDelayPerPhoto seconds have elapsed since the last photo, take another photo
    else if (self.time == kCameraDelayPerPhoto)
    {
        self.photoTrigger++;
        self.time = 0;
    }
}

- (void) photoTaken:(UIImage *)image
{
    [self.photos addObject: image];
}


- (void) close
{
    NSInteger imageIdx;
    [self.timer invalidate];
    //TODO: FLATTENING CODE HERE
    /*for (imageIdx = 0; imageIdx < kMaxAllowablePhotos; imageIdx++)
    {
        [self.imageHandler setImage:[self.photos objectAtIndex:imageIdx] atIndex:imageIdx];
    }*/
}

- (bool) maxPhotosTaken
{
    return [self.photos count] == kMaxAllowablePhotos;
}

- (UIImage *)getNextFrame
{
    return [self.imageHandler getImage:[self.photos count]]; 
}

@end
