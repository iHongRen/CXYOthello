//
//  CXYAIComputer.m
//  CXYHBChess
//
//  Created by iMac on 14-9-4.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYAIComputer.h"

@implementation CXYAIComputer
{
    NSInteger sum; //能吃对方的棋子数
}

- (instancetype)init {
    self = [super init];
    if (self) {
        sum = 0;
    }
    return self;
}

// 选择AI难度
- (CXYNode*)nodeTagForCreateInView:(UIView*)view Nodes:(NSArray*)nodesList Level:(GAMELEVEL)kLevel {
    switch (kLevel) {
        case KPRIMARY:
        {
            return [self randCreateNodeInView:view Nodes:nodesList];
            break;
        }
        case KMIDDLE:
        {
            return [self greedyCreateNodeInView:view Nodes:nodesList];
            break;
        }
        case KADVANCED:
        {
            return [self greedyCornerCreateNodeInView:view Nodes:nodesList];
            break;
        }
        default:
            break;
    }
    return nil;
}


// 1.随机算法
- (CXYNode*)randCreateNodeInView:(UIView*)view Nodes:(NSArray*)nodesList {
    NSInteger index = arc4random()%nodesList.count;
    CXYNode *node = (CXYNode*)nodesList[index];
    return node;
}

// 2.贪心法 --- 取能吃对方最多棋子的位置
- (CXYNode*)greedyCreateNodeInView:(UIView*)view Nodes:(NSArray*)nodesList {
    NSArray *savedNodesStateList = [self getCurrentNodeState:view];
    NSMutableArray *changeSumList = [[NSMutableArray alloc]init];
    for (int i =0; i<nodesList.count; i++) {
        CXYNode *node = (CXYNode*)nodesList[i];
        [self getChangeNodeStateNumForGreedy:view theNode:node];
        [changeSumList  addObject:@(sum)];
        sum = 0;
        [self unDoNodeStateInView:view Nodes:savedNodesStateList];
    }
    NSInteger maxOfIndex = [changeSumList indexOfObject:[changeSumList valueForKeyPath:@"@max.self"]];
    CXYNode *node =(CXYNode*)nodesList[maxOfIndex];
    return node;
}

- (void)getChangeNodeStateNumForGreedy:(UIView*)view theNode:(CXYNode*)node {
    if (node == nil) {
        return;
    }
    node.nodeState = self.owerStateColor;
    for (int i=0; i<kSize; i++) {
        [self getChangeNodeStateNumForGreedy:view theNode:node withOrientation:i];
    }
}

- (void)getChangeNodeStateNumForGreedy:(UIView*)view theNode:(CXYNode*)node withOrientation:(NSInteger)orientation {
    NSInteger nTag = [((NSArray*)[node getRecentNodesTagOftheNode])[orientation] integerValue]; //获取临近棋子
    CXYNode *tempNode = (CXYNode*)[view viewWithTag:nTag];
    while (tempNode !=nil && tempNode.nodeState != node.nodeState && tempNode.nodeState == (self.owerStateColor==KBLACK?KWHITE:KBLACK)) {
        nTag = [((NSArray*)[tempNode getRecentNodesTagOftheNode])[orientation] integerValue]; //获取临近棋子的临近棋子
        tempNode = (CXYNode*)[view viewWithTag:nTag];
        if (tempNode !=nil && tempNode.nodeState == self.owerStateColor) {
            ++ sum;
            NSInteger nTag1 = [((NSArray*)[node getRecentNodesTagOftheNode])[orientation] integerValue];
            CXYNode *node1 = (CXYNode*)[view viewWithTag:nTag1];
            node1.nodeState = self.owerStateColor;
            [self getChangeNodeStateNumForGreedy:view theNode:node1 withOrientation:orientation];
        }
    }

}

// 2.贪心法2 -- 优先取边角上的位置
- (CXYNode*)greedyCornerCreateNodeInView:(UIView*)view Nodes:(NSArray*)nodesList {
    CXYNode *node;
    NSMutableArray *cornerNodesList = [[NSMutableArray alloc]init];
    for (int i=0; i<nodesList.count; i++) {
        node = (CXYNode*)nodesList[i];
        if (node.tag==1 || node.tag==8 || node.tag==57 || node.tag==64) {
           [cornerNodesList addObject:node];
        }
        if (cornerNodesList.count >0) {
            return [self greedyCreateNodeInView:view Nodes:cornerNodesList];
        }
     }
    return [self greedyCreateNodeInView:view Nodes:nodesList];
}

@end
