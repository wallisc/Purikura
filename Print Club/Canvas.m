//
//  Canvas.m
//  VerticalPrototype
//
//  Created by  on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas
@synthesize canvasLayers = _canvasLayers;
@synthesize layers = _layers;
@synthesize lastPan = _lastPan;
@synthesize gesturesOn = _gesturesOn;
@synthesize pgn = _pgn;
@synthesize selectedLayer = _selectedLayer;
@synthesize parentView = _parentView;

- (id)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)image
{
    self = [self initWithFrame:frame];
    if (self)
    {
        /* Add the background layer */
        CGImageRef imageRef = image.CGImage;
        CALayer *newLayer = [CALayer layer];
        newLayer.contents = (__bridge id) imageRef;
        newLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [self.layer addSublayer:newLayer];
        self.multipleTouchEnabled = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.canvasLayers = [[NSMutableArray alloc] initWithCapacity:20];
        self.layers = 0;
        //[self setupGestures];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.canvasLayers = [[NSMutableArray alloc] initWithCapacity:20];
        self.layers = 0;
        //[self setupGestures];
    }
    return self;
}

- (void)touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event 
{

    // If there are no layers to manipulate, don't waste your time
    if (self.layers == 0)
        return;
    NSInteger layerIdx;
    NSArray *touchArray = [touches allObjects];
    if ( [touches count] == 1 )
    {
        UITouch *panTouch = [touchArray objectAtIndex:0];
        CGPoint touchCoord = [panTouch locationInView: self];
        CALayer *curLayer;
        
        // For every layer (starting from the top-down)
        for (layerIdx = [[self.layer sublayers] count] - 1; layerIdx > 0; layerIdx--)
        {
            curLayer = [[self.layer sublayers] objectAtIndex:layerIdx];
            // If the user selected that layer
            if ( [curLayer containsPoint:[curLayer convertPoint: touchCoord fromLayer: self.layer]] )
                break;
        }
        // If a layer was selected
        if (layerIdx > 0)
            self.selectedLayer = layerIdx;
        else 
            self.selectedLayer = kNoLayerSelected;
    }
    else if ([touches count] == 2 )
    {
        UITouch *touch1 = [touchArray objectAtIndex:0];
        UITouch *touch2 = [touchArray objectAtIndex:1];
        CGPoint touch1Coord = [touch1 locationInView: self];
        CGPoint touch2Coord = [touch2 locationInView: self];
        CALayer *curLayer;
        
        // For every layer (starting from the top-down)
        for (layerIdx = [[self.layer sublayers] count] - 1; layerIdx > 0; layerIdx--)
        {
            curLayer = [[self.layer sublayers] objectAtIndex:layerIdx];
            // If the user selected that layer
            if ( [curLayer containsPoint:[curLayer convertPoint: touch1Coord fromLayer: self.layer]] || [curLayer containsPoint:[curLayer convertPoint: touch2Coord fromLayer: self.layer]])
                break;
        }
        // If a layer was selected
        if (layerIdx > 0)
        {
            self.selectedLayer = layerIdx;

        }
        else 
            self.selectedLayer = kNoLayerSelected;
    }
}

- (void)touchesMoved: (NSSet *)touches withEvent:(UIEvent *)event 
{
    NSArray *touchArray = [touches allObjects];
    // If there are no layers to manipulate or no layer selected, don't waste your time
    if (self.layers == 0 || self.selectedLayer == kNoLayerSelected )
        return;
    
    // Note that topLayer is 1-indexed (since the 0th layer is the background) 
    CanvasLayer *topLayerData = [self.canvasLayers objectAtIndex:self.selectedLayer - 1];
    CALayer *topLayer = [[self.layer sublayers] objectAtIndex: self.selectedLayer];
    

    topLayer.borderWidth = 2.0;
    
    //If the user is using a pan gesture
    if ( [touches count] == 1 && self.layers > 0)
    {
        UITouch *panTouch = [touchArray objectAtIndex:0];
        CGPoint curPan = [panTouch locationInView:self];
        CGPoint lastPan = [panTouch previousLocationInView:self];
        CGPoint delta = CGPointMake(curPan.x - lastPan.x, curPan.y - lastPan.y);
        topLayerData.translation = CGPointMake(topLayerData.translation.x + delta.x, topLayerData.translation.y + delta.y);
        
        
        // Handle if the scroll view needs to be moved
        CGPoint offsetScrollPoint = [self.parentView contentOffset];
        bool hitLeftSide = (curPan.x > offsetScrollPoint.x + self.parentView.frame.size.width - kScrollEdgeBuffer);
        bool hitRightSide = (curPan.x < offsetScrollPoint.x + kScrollEdgeBuffer);
        bool hitTop = (curPan.y > offsetScrollPoint.y + kScrollEdgeBuffer);
        bool hitBottom = (curPan.y > offsetScrollPoint.y + self.parentView.frame.size.height - kScrollEdgeBuffer);
        /*
        //If the sticker is being dragged off the side of the scroll view
        if (hitLeftSide || hitRightSide || hitTop || hitBottom)
        {
            CGPoint newOffset = CGPointMake(curPan.x + self.parentView.frame.size.width / 2.0, curPan.y + self.parentView.frame.size.height / 2.0);
            [self.parentView setContentOffset:newOffset animated:YES];
            NSLog(@"Called at (%lf, %lf)", curPan.x, curPan.y);
        }
        */
        
    }
    else if ([touches count] == 2 )
    {
        UITouch *firstTouch, *secondTouch;
        CGPoint firstCurTouch, firstPrevTouch;
        CGPoint secondCurTouch, secondPrevTouch;
        CGFloat lastDist, curDist, deltaDist;
        
        firstTouch = [touchArray objectAtIndex:0];
        secondTouch = [touchArray objectAtIndex:1];
        
        firstCurTouch = [firstTouch locationInView:self];
        firstPrevTouch = [firstTouch previousLocationInView:self];
        
        secondCurTouch = [secondTouch locationInView:self];
        secondPrevTouch = [secondTouch previousLocationInView:self];
        
        // Find the change in distance between the 2 fingers
        lastDist = [Canvas distanceFrom: firstPrevTouch to: secondPrevTouch];
        curDist = [Canvas distanceFrom:firstCurTouch to:secondCurTouch];
        deltaDist = curDist - lastDist;
        topLayerData.scale *= (1 + deltaDist / 100.0);
        if (topLayerData.scale < .1)
        {
            topLayerData.scale = .1;
        }
        
        /* Find the rotation of the fingers */
        // Normalize the vectors formed by the first and second touch
        CGPoint normLastVector = CGPointMake((secondPrevTouch.x - firstPrevTouch.x) / lastDist, (secondPrevTouch.y - firstPrevTouch.y) / lastDist);
        CGPoint normCurVector = CGPointMake((secondCurTouch.x - firstCurTouch.x) / curDist, (secondCurTouch.y - firstCurTouch.y) / curDist);
        
        // Find arccos(normLastVector dotted with the i-vector (1.0, 0.0))
        CGFloat lastAngleFromXAxis = acos(normLastVector.x);
        // Check for orientation (acos only outputs to the range [0, 3.14])
        if (normLastVector.y >= 0)
            lastAngleFromXAxis = (M_PI - lastAngleFromXAxis) + M_PI;
        
        // Find arccos(normCurVector dotted with the i-vector (1.0, 0.0))
        CGFloat curAngleFromXAxis = acos(normCurVector.x);
        // Check for orientation (acos only outputs to the range [0, 3.14])
        if (normCurVector.y >= 0)
            curAngleFromXAxis = (M_PI - curAngleFromXAxis) + M_PI;
        CGFloat rotation = lastAngleFromXAxis - curAngleFromXAxis;

        topLayerData.rotation += rotation;
        
    }
    CGAffineTransform transform = CGAffineTransformMakeTranslation(topLayerData.translation.x, topLayerData.translation.y);
    transform = CGAffineTransformRotate ( transform, topLayerData.rotation );
    transform = CGAffineTransformScale ( transform, topLayerData.scale, topLayerData.scale );
    [CATransaction begin]; 
    [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
    topLayer.affineTransform = transform;
    [CATransaction commit];
    /*
    // Apply the transform
    CATransform3D transform = CATransform3DMakeTranslation(topLayerData.translation.x, topLayerData.translation.y, 0.0);
    transform = CATransform3DRotate(transform, topLayerData.rotation, 0, 0, 1.0);
    transform = CATransform3DScale(transform, topLayerData.scale, topLayerData.scale, topLayerData.scale);     [CATransaction begin]; 
    [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
    topLayer.transform = transform;
    [CATransaction commit];*/
}

+ (CGFloat) distanceFrom: (CGPoint)a to: (CGPoint)b
{
    CGFloat deltaX = a.x - b.x;
    CGFloat deltaY = a.y - b.y;
    return sqrtf(deltaX * deltaX + deltaY * deltaY);
}

+ (CGFloat) dotVector: (CGPoint)a with: (CGPoint)b
{
    return a.x * b.x + a.y * b.y;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if (self.layers == 0 || self.selectedLayer == kNoLayerSelected)
        return;
    
    // Since the user is done with the gesture, deslect the layer and remove the highlighting
    CALayer *topLayer = [[self.layer sublayers] objectAtIndex: self.selectedLayer];
    topLayer.borderWidth = 0.0;
    self.selectedLayer = kNoLayerSelected;
}

- (void) addSticker:(UIImage *)sticker at:(CGPoint) point
{
    /* Add the background layer */
    CGImageRef stickerRef = sticker.CGImage;
    
    // Store a new layer
    CanvasLayer *layer = [[CanvasLayer alloc] init];
    layer.origin = point;
    layer.translation = CGPointMake(0.0, 0.0);
    layer.rotation = 0.0;
    layer.scale = 1.0;
    // Add the layer to the canvas layer array
    [self.canvasLayers addObject:layer];
    
    CALayer *newLayer = [CALayer layer];
    newLayer.contents = (__bridge id) stickerRef;
    newLayer.frame = CGRectMake(point.x, point.y, sticker.size.width, sticker.size.height);
    [self.layer addSublayer:newLayer];
    self.layers++;
}

@end
