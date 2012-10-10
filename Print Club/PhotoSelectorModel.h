//
//  PhotoSelectorModel.h
//  Print Club
//
//  Created by  on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageHandler.h"

@interface PhotoSelectorModel : NSObject
- (id) initWithImageHandler:(ImageHandler *)imageHandler;
- (bool)maxPhotosSelected;
- (NSInteger)numberOfPhotosSelected;
- (NSInteger)numberOfPhotosNeeded;
- (NSInteger)numberOfPhotos;
- (UIImage *)photoAtIndex:(NSInteger)index;
- (bool)isSelectedAtIndex:(NSInteger)index;
- (void)commitPhotos;
- (void)selectPhotoAtIndex:(NSInteger)index;
- (UIImage *)getSelectedImage;
- (void)keepPhoto:(bool)keep;
- (bool)isSelected;
@end
