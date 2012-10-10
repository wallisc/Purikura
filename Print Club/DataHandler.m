//
//  DataHandler.m
//  Print Club
//
//  Created by  on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataHandler.h"
@interface DataHandler ()
@property (strong) NSArray *frames;
@property (strong) NSArray *stickers;
@end

@implementation DataHandler
@synthesize frames;
@synthesize stickers;

- (id)init
{
    self = [super init];
    if (self) {        
        NSArray *paths = [NSBundle pathsForResourcesOfType: @"png" inDirectory: [[NSBundle mainBundle] bundlePath]];
        NSMutableArray *cuteFrames = [[NSMutableArray alloc] init];
        NSMutableArray *funFrames = [[NSMutableArray alloc] init];
        NSMutableArray *prettyFrames = [[NSMutableArray alloc] init];
        NSMutableArray *weirdFrames = [[NSMutableArray alloc] init];
        
        for ( NSString * path in paths )
        {
            if ( [[path lastPathComponent] hasPrefix: @"cute_"] )
            {
                [cuteFrames addObject:path];
            }
            else if ( [[path lastPathComponent] hasPrefix: @"fun_"] )
            {
                [funFrames addObject:path];
            }
            else if ( [[path lastPathComponent] hasPrefix: @"pretty_"] )
            {
                [prettyFrames addObject:path];
            }
            else if ( [[path lastPathComponent] hasPrefix: @"weird_"] )
            {
                [weirdFrames addObject:path];
            }
        }
        self.frames = [[NSArray alloc] initWithObjects:cuteFrames, funFrames, prettyFrames, weirdFrames, nil];
        
    }
    return self;
}

- (UIImage *) getFrame:(FrameType) type atIndex: (NSInteger) index
{

    NSString *path = [[self.frames objectAtIndex:type] objectAtIndex:index];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    return [UIImage imageWithData:imageData];
}

- (UIImage *) getSticker:(StickerType) type atIndex: (NSInteger) index
{
    return nil;
}

- (NSInteger) numOfFrames:(FrameType) type
{
    return [[self.frames objectAtIndex:type] count];
}

- (NSInteger) numOfSticker:(StickerType) type
{
    return [[self.stickers objectAtIndex:type] count];
}

@end
