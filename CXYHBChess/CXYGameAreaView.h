//
//  CXYGameAreaView.h
//  CXYHBChess
//
//  Created by iMac on 14-9-2.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXYParent.h"
@interface CXYGameAreaView : UIView

@property (nonatomic,assign)GAMESTATE gameState;

- (void)initNodesWithPlayer:(CXYParent*)player;
- (void)calculateNodeNum;
- (void)onJudgeWinForPlayer:(CXYParent*)player OtherPlayer:(CXYParent*)OtherPlayer;
@end
