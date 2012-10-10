//
//  FrameSelectorModel.m
//  Print Club
//
//  Created by  on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FrameSelectorModel.h"

@interface FrameSelectorModel ()
@property (strong) ImageHandler *imageHandler;
@property (strong) DataHandler *dataHandler;
@property (strong) NSMutableArray *selectedFrames;
@property FrameType selectedType;
@property NSInteger specifiedIndex;
@end

@implementation FrameSelectorModel
@synthesize imageHandler = _imageHandler;
@synthesize dataHandler = _dataHandler;
@synthesize selectedFrames = _selectedFrames;
@synthesize selectedType = _selectedType;
@synthesize specifiedIndex = _specifiedIndex;

- (id) initWithImageHandler:(ImageHandler *)imageHandler andDataHandler:(DataHandler *) dataHandler
{
    self = [super init];
    if ( self )
    {
        self.imageHandler = imageHandler;
        self.dataHandler = dataHandler;
        self.selectedFrames = [[NSMutableArray alloc] initWithCapacity:kMaxAllowablePhotos];
    }
    return self;
    
}

- (NSInteger) numOfSelectedFrames
{
    return [self.selectedFrames count];
}

- (UIImage *) selectedFrameAtIndex:(NSInteger)index;
{
    FrameData *frame = [self.selectedFrames objectAtIndex:index];
    return [self.dataHandler getFrame:frame.type atIndex:frame.index];
}

- (void) addFrameAtIndex:(NSInteger)index;
{
    FrameData *frameData = [[FrameData alloc] initWithType: self.selectedType andIndex:index];
    [self.selectedFrames addObject:frameData];
}

- (void) genreSelected:(FrameType)type
{
    self.selectedType = type;
}

- (NSInteger) numOfFramesAvailable
{
    return [self.dataHandler numOfFrames:self.selectedType];
}

- (UIImage *) imageAtIndex:(NSInteger)index
{
    return [self.dataHandler getFrame:self.selectedType atIndex:index];
}

- (void) removeSelectedFrameAtIndex:(NSInteger)index
{
    if ( [self numOfSelectedFrames] > 0 )
    {
        for ( FrameData *selFrame in self.selectedFrames )
        {
            if ( self.selectedType == selFrame.type && index == selFrame.index )
            {
                [self.selectedFrames removeObject:selFrame];
                return;
            }
        }
        NSLog(@"Unable to find the requested frame to remove");

    }
    else 
        NSLog(@"Attempting to remove a selected frame even though no frames are selected");
}

- (bool) isSelectedAtIndex:(NSInteger)index
{
    for (FrameData *selFrame in self.selectedFrames)
    {
        if (selFrame.type == self.selectedType && selFrame.index == index)
            return YES;
    }
    return NO;
}

- (NSInteger) maxAllowableSelectedFrames
{
    return kMaxAllowablePhotos;
}

- (bool) maxFramesSelected
{
    return [self.selectedFrames count] == kMaxAllowablePhotos;
}

- (void) selectedFrameSpecified: (NSInteger)index
{
    self.specifiedIndex = index;
}

- (UIImage *) getSpecifiedImage
{
    FrameData *frame = [self.selectedFrames objectAtIndex:self.specifiedIndex];
    return [self.dataHandler getFrame:frame.type atIndex:frame.index];
}

- (void) removeSpecifiedImage
{
    [self.selectedFrames removeObjectAtIndex:self.specifiedIndex];
}

-(void) commitFrames
{
    NSInteger idx;
    UIImage *frame;
    FrameData *frameData;
    for (idx = 0; idx < [self.selectedFrames count]; idx++)
    {
        frameData = [self.selectedFrames objectAtIndex:idx];
        frame = [self.dataHandler getFrame:frameData.type atIndex:frameData.index];
        [self.imageHandler setImage:frame atIndex:idx];
    }
}

@end
