//
//  CXYParent.m
//  CXYHBChess
//
//  Created by iMac on 14-9-9.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYParent.h"
#import "CXYAIComputer.h"
@implementation CXYParent

- (instancetype)init
{
    self = [super init];
    if (self) {
     
    }
    return self;
}

// 判断是否允许你落子
- (BOOL)isAllowDownInView:(UIView*)view theNode:(CXYNode*)node
{
    CXYNode *tempNode;
    for (int i=0; i<kSize; i++) {
        NSInteger nTag = [((NSArray*)[node getRecentNodesTagOftheNode])[i] integerValue]; //获取临近棋子
        tempNode = (CXYNode*)[view viewWithTag:nTag];
        if (![tempNode isKindOfClass:[CXYNode class]]) {
            continue;
        }
        while (tempNode !=nil && tempNode.nodeState != node.nodeState && tempNode.nodeState == (self.owerStateColor==KWHITE?KBLACK:KWHITE)) {
            nTag = [((NSArray*)[tempNode getRecentNodesTagOftheNode])[i] integerValue]; //获取临近棋子的临近棋子
            tempNode = (CXYNode*)[view viewWithTag:nTag];
            if (tempNode !=nil && tempNode.nodeState == self.owerStateColor) {
                return YES;
            }
        }
    }
    return NO;
}

//得到当前可以落子的区域
- (NSArray*)getCurrentAllowDownNodesInView:(UIView*)view
{
    NSMutableArray *isAllowNodesDownList = [[NSMutableArray alloc]init];
    for (int i=1; i<=kSize*kSize; i++) {
        CXYNode* node = (CXYNode*)[view viewWithTag:i];
        if (node !=nil && (node.nodeState == KCLEAR || node.nodeState == KHINT)) {
            if ([self isAllowDownInView:view theNode:node]) {
                [isAllowNodesDownList addObject:node];
            }
        }
        
    }
    return isAllowNodesDownList;
}

//设置可落子区域为 hint状态
- (void)setHintState:(UIView*)view
{
    for (int i=1; i<=kSize*kSize; i++) {
        CXYNode* node = (CXYNode*)[view viewWithTag:i];
        if (node !=nil && (node.nodeState == KCLEAR || node.nodeState == KHINT)) {
            if ([self isAllowDownInView:view theNode:node]) {
                node.nodeState = KHINT;
    
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.5];
                [UIView setAnimationRepeatCount:MAXFLOAT];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationRepeatAutoreverses:YES];
                node.transform = CGAffineTransformMakeScale(0.9, 0.9);
                [UIView commitAnimations];
            }
        }
    }
}

//清除hint状态
- (void)clearHintState:(UIView*)view
{
    for (int i=1; i<=kSize*kSize; i++) {
        CXYNode* node = (CXYNode*)[view viewWithTag:i];
        if (node !=nil) {
            if (node.nodeState == KHINT) {
                node.nodeState = KCLEAR;
                node.transform = CGAffineTransformIdentity;
            }
        }
        
    }
}

//改变棋子状态
- (void)changeNodeStateInView:(UIView*)view theNode:(CXYNode*)node
{
    if (node == nil) {
        return;
    }
    node.nodeState = self.owerStateColor;
    //判断 8个方向
    for (int i=0; i<kSize; i++) {
        [self changeNodeStateInView:view theNode:node withOrientation:i];
    }
}

// 递归判断一个方向上是否可以翻对方的棋子
- (void)changeNodeStateInView:(UIView*)view theNode:(CXYNode*)node withOrientation:(NSInteger)orientation
{
    NSInteger nTag = [((NSArray*)[node getRecentNodesTagOftheNode])[orientation] integerValue]; //获取临近棋子
    CXYNode *tempNode = (CXYNode*)[view viewWithTag:nTag];
    while (tempNode !=nil && tempNode.nodeState != node.nodeState && tempNode.nodeState == (self.owerStateColor==KWHITE?KBLACK:KWHITE)) {
        nTag = [((NSArray*)[tempNode getRecentNodesTagOftheNode])[orientation] integerValue]; //获取临近棋子的临近棋子
        tempNode = (CXYNode*)[view viewWithTag:nTag];
        if (tempNode !=nil && tempNode.nodeState == self.owerStateColor) {
            NSInteger nTag1 = [((NSArray*)[node getRecentNodesTagOftheNode])[orientation] integerValue];
            CXYNode *node1 = (CXYNode*)[view viewWithTag:nTag1];
            node1.nodeState = self.owerStateColor;
            [self changeNodeStateInView:view theNode:node1 withOrientation:orientation];
            
            //翻转动画
            [UIView animateWithDuration:0.3 animations:^{
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:node1 cache:YES];
            }];
        }
    }

}


// 根据保存的状态值，设置棋子状态
- (void)unDoNodeStateInView:(UIView*)view Nodes:(NSArray*)nodesStateList
{
    for (int i=1; i<=nodesStateList.count; i++) {
        CXYNode *node = (CXYNode*)[view viewWithTag:i];
        node.nodeState = [nodesStateList[i-1]integerValue];
    }
}

// 得到当前的棋子状态
- (NSArray*)getCurrentNodeState:(UIView*)view
{
    NSMutableArray *stateList = [[NSMutableArray alloc]init];
    for (int i=1; i<=kSize*kSize; i++) {
        CXYNode *node = (CXYNode*)[view viewWithTag:i];
        NODESTATE nodeState = node.nodeState;
        [stateList addObject:@(nodeState)];
    }
    return stateList;
}

@end
