//
//  FrameSelectorModel.h
//  Print Club
//
//  Created by  on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageHandler.h"
#import "DataHandler.h"
#import "FrameData.h"

@interface FrameSelectorModel : NSObject
- (id) initWithImageHandler:(ImageHandler *)imageHandler andDataHandler:(DataHandler *) dataHandler;

// Number of frames the user has selected so far
- (NSInteger) numOfSelectedFrames;

// Load the frame at the specified index from the user's list of selected frames 
- (UIImage *)selectedFrameAtIndex:(NSInteger)index;

// Add a frame at the specified index in the current selected genre to users list of desired frames
// Pre: Must be called after genreSelected
- (void) addFrameAtIndex:(NSInteger)index;

// Must be called when the user specifies which genre they wish to browse
- (void) genreSelected:(FrameType)type;

// The number of frames available for the chosen genre
// Pre: Must be called after genreSelected
- (NSInteger) numOfFramesAvailable;

// Pre: Must be called after genreSelected
- (UIImage *) imageAtIndex:(NSInteger)index;

- (void) removeSelectedFrameAtIndex:(NSInteger)index;

// Pre: Must be called after genreSelected
- (bool) isSelectedAtIndex:(NSInteger)index;

// The maximum number of frames the user can select
- (NSInteger) maxAllowableSelectedFrames;

// Returns whether the user has filled their list of desired frames
- (bool) maxFramesSelected;

// Must be called when the user specifies a frame from the list of selected frames
- (void) selectedFrameSpecified: (NSInteger)index;

// Returns the image that the user is specifying
// Pre: Must be called after selectedFrameSpecified
- (UIImage *) getSpecifiedImage;

// Removes the specfied image the user is looking at
// Pre: Must be called after selectedFrameSpecified
- (void) removeSpecifiedImage;

// Pre: maxFramesSelected == YES
-(void) commitFrames;

@end
