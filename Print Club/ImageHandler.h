//
//  ImageHandler.h
//  Print Club
//
//  Created by  on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMaxAllowablePhotos 3
#define kMaxAllowableKeptPhotos 2

@interface ImageHandler : NSObject
- (UIImage *) getImage:(NSInteger) index;
- (void) setImage:(UIImage *)image atIndex:(NSInteger) index;
- (UIImage *) getFilmSheet;
- (CGSize) getFilmSheetSize;
+ (UIImage *)imageFromLayer:(CALayer *)layer;
- (void) setLayerWithFilmSheet: (CALayer *) layer;
@end
