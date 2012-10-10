//
//  SwitchableController.h
//  Print Club
//
//  Created by  on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SwitchableController <NSObject>
@property (weak) id target;
@property SEL switchSel;
@end
