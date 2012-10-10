//
//  DataHandler.h
//  Print Club
//
//  Created by  on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {kCute, kFun, kPretty, kWeird} FrameType; 
typedef enum {kHats} StickerType; 

@interface DataHandler : NSObject
- (UIImage *) getFrame:(FrameType) type atIndex: (NSInteger) index;
- (UIImage *) getSticker:(StickerType) type atIndex: (NSInteger) index;
- (NSInteger) numOfFrames:(FrameType) type;
- (NSInteger) numOfSticker:(StickerType) type;
@end
