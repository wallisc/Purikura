//
//  FrameData.h
//  Print Club
//
//  Created by  on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataHandler.h"

@interface FrameData : NSObject
@property (readwrite) FrameType type;
@property (readwrite) NSInteger index;
- (id) initWithType:(FrameType)type andIndex:(NSInteger)index;
@end
