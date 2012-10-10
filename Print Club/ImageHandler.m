//
//  ImageHandler.m
//  Print Club
//
//  Created by  on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageHandler.h"
#import <QuartzCore/QuartzCore.h>

@interface ImageHandler ()
@property (strong) NSMutableArray *photos;
 
@end

@implementation ImageHandler
@synthesize photos;

- (id)init
{
    self = [super init];
    if (self) {
        self.photos = [[NSMutableArray alloc] initWithCapacity:kMaxAllowablePhotos];
    }
    return self;
}

- (UIImage *) getImage:(NSInteger) index
{
    return [photos objectAtIndex:index]; 
}
- (void) setImage:(UIImage *)image atIndex:(NSInteger)index;
{
    // If the index is out of bounds, just add it to the end of the array
    if (index >= [self.photos count])
        [photos addObject:image];
    else
        [photos replaceObjectAtIndex:index withObject: image];
}

- (UIImage *) getFilmSheet
{
    NSInteger imageIdx;
    CGFloat height = 0.0;
    CALayer *filmSheet = [CALayer layer];
    CALayer *nextImage;
    UIImage *image;
    UIImage *templateImage = [[UIImage alloc] init];
    CGSize size = [self getFilmSheetSize];
    UIGraphicsBeginImageContext(size);
    [filmSheet renderInContext:UIGraphicsGetCurrentContext()];
    for (imageIdx = 0; imageIdx < kMaxAllowableKeptPhotos; imageIdx++)
    {
        image = [self.photos objectAtIndex:imageIdx];
        nextImage = [CALayer layer];
        nextImage.frame = CGRectMake(0.0, height, image.size.width, image.size.height);
        nextImage.contents = (__bridge id)image.CGImage;
        [filmSheet addSublayer:nextImage];
        height += image.size.height;
    }
    UIGraphicsEndImageContext();
    return [ImageHandler imageFromLayer:filmSheet];
}

+ (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (CGSize) getFilmSheetSize
{
    CGFloat width = 0.0; 
    CGFloat height = 0.0;
    NSInteger imageIdx;
    if ([self.photos count] > 0)
        width = ((UIImage *)[self.photos objectAtIndex:0]).size.width;
    for (imageIdx = 0; imageIdx < kMaxAllowableKeptPhotos; imageIdx++)
    {
        height+= ((UIImage *)[self.photos objectAtIndex:imageIdx]).size.height;
    }
    return CGSizeMake(width, height);
}

- (void) setLayerWithFilmSheet: (CALayer *) layer
{
    NSInteger imageIdx;
    CGFloat height = 0.0;
    CALayer *nextImage;
    UIImage *image;
    for (imageIdx = 0; imageIdx < kMaxAllowableKeptPhotos; imageIdx++)
    {
        image = [self.photos objectAtIndex:imageIdx];
        nextImage = [CALayer layer];
        nextImage.frame = CGRectMake(0.0, height, image.size.width, image.size.height);
        nextImage.contents = (__bridge id)image.CGImage;
        [layer addSublayer:nextImage];
        height += image.size.height;
    }
}
@end
