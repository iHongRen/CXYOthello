//
//  CXYParent.h
//  CXYHBChess
//
//  Created by iMac on 14-9-9.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXYNode.h"
@interface CXYParent : NSObject

@property (nonatomic,assign) NODESTATE owerStateColor;


- (BOOL)isAllowDownInView:(UIView*)view theNode:(CXYNode*)node;
- (NSArray*)getCurrentAllowDownNodesInView:(UIView*)view;
- (void)setHintState:(UIView*)view;
- (void)clearHintState:(UIView*)view;
- (void)changeNodeStateInView:(UIView*)view theNode:(CXYNode*)node;
- (NSArray*)getCurrentNodeState:(UIView*)view;
- (void)unDoNodeStateInView:(UIView*)view Nodes:(NSArray*)nodesStateList;

@end
