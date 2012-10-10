//
//  BoothEngine.h
//  Print Club
//
//  Created by  on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define kCameraDelayPerPhoto 4
#define kInitialCameraDelay 0

#import <Foundation/Foundation.h>
#import "ImageHandler.h"

@interface BoothEngine : NSObject
- (id) initWithImageHandler: (ImageHandler *)imageHandler;
- (void) start;
- (void) update;
- (void) photoTaken:(UIImage *)image;
- (bool) maxPhotosTaken;
- (void) close;
- (UIImage *)getNextFrame;
@property NSInteger photoTrigger;
@property NSInteger counterTrigger;
@end
