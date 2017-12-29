//
//  CXYGameAreaView.h
//  CXYHBChess
//
//  Created by iMac on 14-9-2.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXYParent.h"

typedef void(^ChessDownBlock)(CXYNode *node);
@interface CXYGameAreaView : UIView

@property (nonatomic,assign) GAMESTATE gameState;
@property (nonatomic, copy) ChessDownBlock chessDownBlock;

- (void)onInitNodesWithPlayer:(CXYParent*)player;
- (void)onCalculateNodeNum;
- (void)onJudgeWinForPlayer:(CXYParent*)player OtherPlayer:(CXYParent*)OtherPlayer;
@end
