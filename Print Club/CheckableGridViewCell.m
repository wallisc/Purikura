//
//  FrameGridViewCell.m
//  Print Club
//
//  Created by  on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CheckableGridViewCell.h"


@implementation CheckableGridViewCell
@synthesize imageView = _imageView;
@synthesize image = _image;
@synthesize checkView = _checkView;
@synthesize checked = _checked;
- (id)initWithFrame:(CGRect)frame  reuseIdentifier:(NSString *) aReuseIdentifier
{
    self = [super initWithFrame: frame reuseIdentifier: aReuseIdentifier];
    if ( self == nil )
        return nil;
    
    NSData *imageData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"check" withExtension:@"png"]];
    UIImage *image = [UIImage imageWithData: imageData];
    self.checkView = [[UIImageView alloc] initWithImage:image];
    
    self.checked = NO;
    
    _imageView = [[UIImageView alloc] initWithFrame: CGRectZero];
    [self.contentView addSubview: _imageView];
    
    return ( self );
}

- (CALayer *) glowSelectionLayer
{
    return ( _imageView.layer );
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGSize imageSize = _imageView.image.size;
    CGRect frame = _imageView.frame;
    CGRect bounds = self.contentView.bounds;
    
    /* If you don't want to accept images that are smaller then the cell
    if ( (imageSize.width <= bounds.size.width) &&
		(imageSize.height <= bounds.size.height) )
    {
        return;
    }
    */
    
    // scale it down to fit
    CGFloat hRatio = bounds.size.width / imageSize.width;
    CGFloat vRatio = bounds.size.height / imageSize.height;
    CGFloat ratio = MAX(hRatio, vRatio);
    
    frame.size.width = floorf(imageSize.width * ratio);
    frame.size.height = floorf(imageSize.height * ratio);
    frame.origin.x = floorf((bounds.size.width - frame.size.width) * 0.5);
    frame.origin.y = floorf((bounds.size.height - frame.size.height) * 0.5);
    _imageView.frame = frame;
}

- (UIImage *) image
{
    return ( _imageView.image );
}

- (void) setImage: (UIImage *) anImage
{
    _imageView.image = anImage;
    [self setNeedsLayout];
}

- (void) checkBox: (bool)toBeChecked
{
    // If the box is to be checked and a check box hasn't already been added on
    if ( toBeChecked && !self.checked )
    {

        [self.contentView addSubview:self.checkView];
        self.checked = YES;

    }
    // If the box is to be unchecked (and the exists a check box to get rid of)
    else if ( !toBeChecked && self.checked )
    {
        [self.checkView removeFromSuperview];
        self.checked = NO;
    }
}


@end
