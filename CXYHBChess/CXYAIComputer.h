//
//  CXYAIComputer.h
//  CXYHBChess
//
//  Created by iMac on 14-9-4.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXYParent.h"

@interface CXYAIComputer : CXYParent

- (CXYNode*)nodeTagForCreateInView:(UIView*)view Nodes:(NSArray*)nodesList Level:(GAMELEVEL)kLevel;
@end
