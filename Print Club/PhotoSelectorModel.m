//
//  PhotoSelectorModel.m
//  Print Club
//
//  Created by  on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhotoSelectorModel.h"

@interface PhotoSelectorModel ()
@property (strong) ImageHandler *imageHandler;
@property (strong) NSMutableArray *selectedPhotos;
@property NSInteger selectedPhoto;
@end

@implementation PhotoSelectorModel
@synthesize imageHandler = _imageHandler;
@synthesize selectedPhotos = _selectedPhotos;
@synthesize selectedPhoto = _selectedPhoto;

- (id) initWithImageHandler:(ImageHandler *)imageHandler
{
    self = [super init];
    if ( self )
    {
        self.imageHandler = imageHandler;
        self.selectedPhotos = [[NSMutableArray alloc] initWithCapacity:kMaxAllowableKeptPhotos];
    }
    return self;
}

- (NSInteger)numberOfPhotos
{
    return kMaxAllowablePhotos;
}

- (UIImage *)photoAtIndex:(NSInteger)index
{
    return [self.imageHandler getImage:index];
}

- (bool)isSelectedAtIndex:(NSInteger)index
{
    for (NSNumber *num in self.selectedPhotos)
    {
        if ( index == [num intValue] )
            return YES;
    }
    return NO;
}

- (void)selectPhotoAtIndex:(NSInteger)index
{
    self.selectedPhoto = index;
}

- (UIImage *)getSelectedImage
{
    return [self photoAtIndex:self.selectedPhoto];
}

- (void)keepPhoto:(bool)keep;
{
    NSNumber *inputPhoto = [NSNumber numberWithInt:self.selectedPhoto];
    bool selected= self.isSelected;
    if ( keep && !selected)
    {
        [self.selectedPhotos addObject:inputPhoto];
    }
    else if ( !keep && selected )
    {
        [self.selectedPhotos removeObjectIdenticalTo:inputPhoto];
    }
}

- (bool)isSelected
{
    return [self isSelectedAtIndex:self.selectedPhoto];
}

- (bool)maxPhotosSelected
{
    return [self.selectedPhotos count] == kMaxAllowableKeptPhotos;
}

- (NSInteger)numberOfPhotosSelected
{
    return [self.selectedPhotos count];
}

- (NSInteger)numberOfPhotosNeeded;
{
    return kMaxAllowableKeptPhotos;
}

- (void)commitPhotos
{
    NSMutableArray *keptImages = [[NSMutableArray alloc] initWithCapacity:kMaxAllowableKeptPhotos];
    NSInteger newIdx = 0;
    for (NSNumber *indx in self.selectedPhotos)
    {
        [keptImages addObject:[self.imageHandler getImage:[indx intValue]]];
    }
         
    for (UIImage* image in keptImages)
    {
        [self.imageHandler setImage:image atIndex:newIdx++];
    }
}

@end
