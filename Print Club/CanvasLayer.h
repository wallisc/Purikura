//
//  CanvasLayer.h
//  VerticalPrototype
//
//  Created by  on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CanvasLayer : NSObject
@property (readwrite) CGPoint origin;
@property (readwrite) CGPoint translation;
@property (readwrite) CGFloat rotation;
@property (readwrite) CGFloat scale;
@end
