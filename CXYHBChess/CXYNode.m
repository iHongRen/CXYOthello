//
//  CXYNode.m
//  CXYHBChess
//
//  Created by iMac on 14-9-2.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYNode.h"

@implementation CXYNode

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =[UIColor clearColor];
        self.adjustsImageWhenHighlighted = NO;
        self.nodeState = KCLEAR;
    }
    return self;
}

// 根据棋子状态改变 棋子背景
-(void)setNodeState:(NODESTATE)nodeState {
    _nodeState = nodeState;
    switch (_nodeState) {
        case KBLACK:
        {
            self.backgroundColor = [UIColor blackColor];
            break;
        }
        case KWHITE:
        {
            self.backgroundColor = [UIColor whiteColor];
            break;
        }
        case KHINT:
        {
            self.backgroundColor = [UIColor grayColor];
            break;
        }
        case KCLEAR:
        {
            self.backgroundColor = [UIColor clearColor];
            break;
        }
        default:
            break;
    }
}


// 获取附近8个位置的tag
- (NSArray*)getRecentNodesTagOftheNode {
    NSMutableArray *recentNodesList = [[NSMutableArray alloc]init];
    NSArray *nums = @[@(-9),@(-8),@(-7),@(-1),@1,@7,@8,@9];
    for (int i=0; i<nums.count; ++i) {
         [recentNodesList addObject:@(self.tag + [nums[i] integerValue])];
    }
    
    if (0 == self.tag %8) {
        NSArray *rightIndexs = @[@2,@4,@7];
        for (int i=0; i<rightIndexs.count; ++i) {
            [recentNodesList replaceObjectAtIndex:(NSInteger)[rightIndexs[i] integerValue] withObject:@(-1)];
        }
       
    }
    
    if (0 == (self.tag-1) %8) {
        NSArray *rightIndexs = @[@0,@3,@5];
        for (int i=0; i<rightIndexs.count; ++i) {
            [recentNodesList replaceObjectAtIndex:(NSInteger)[rightIndexs[i] integerValue] withObject:@(-1)];
        }
        
    }
    
    if (self.tag <=8) {
        NSArray *rightIndexs = @[@0,@1,@2];
        for (int i=0; i<rightIndexs.count; ++i) {
            [recentNodesList replaceObjectAtIndex:(NSInteger)[rightIndexs[i] integerValue] withObject:@(-1)];
        }
        
    }
    
    if (self.tag > 8*(8-1)) {
        NSArray *rightIndexs = @[@5,@6,@7];
        for (int i=0; i<rightIndexs.count; ++i) {
            [recentNodesList replaceObjectAtIndex:(NSInteger)[rightIndexs[i] integerValue] withObject:@(-1)];
        }
        
    }
    return recentNodesList;
}

@end
