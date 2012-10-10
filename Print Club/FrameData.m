//
//  FrameData.m
//  Print Club
//
//  Created by  on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FrameData.h"

@implementation FrameData
@synthesize type = _type;
@synthesize index = _index;

- (id) initWithType:(FrameType)type andIndex:(NSInteger)index
{
    self = [super init];
    if ( self )
    {
        self.type = type;
        self.index = index;
    }
    return self;
}
@end
