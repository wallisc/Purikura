//
//  Canvas.h
//  VerticalPrototype
//
//  Created by  on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanvasLayer.h"
#import <QuartzCore/QuartzCore.h>

#define kNoLayerSelected -1
#define kScrollEdgeBuffer 20

@interface Canvas : UIView
@property (strong) NSMutableArray *canvasLayers;
@property NSInteger layers;
@property CGPoint lastPan;
@property (strong) UIPanGestureRecognizer *pgn;
@property (nonatomic) bool gesturesOn;
@property (nonatomic) NSInteger selectedLayer;
@property (weak) UIScrollView *parentView;
- (id)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)image;
//- (void) handlePanGesture: (UIPanGestureRecognizer*) sender;
/*- (void) setupGestures;
- (void) removeGestures;*/
- (void) addSticker:(UIImage *)sticker at:(CGPoint) point;
+ (CGFloat) distanceFrom: (CGPoint)a to: (CGPoint)b;
+ (CGFloat) dotVector: (CGPoint)a with: (CGPoint)b;
@end
