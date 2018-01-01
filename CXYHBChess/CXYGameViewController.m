//
//  CXYGameViewController.m
//  CXYHBChess
//
//  Created by iMac on 14-9-4.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYGameViewController.h"
#import "CXYGameAreaView.h"
#import "CXYAIComputer.h"
#import "CXYPlayer.h"
#import "CXYGameSettingViewController.h"
#import "CXYUtils.h"

@interface CXYGameViewController () {
    IBOutlet CXYGameAreaView *gameAreaView;
    CXYAIComputer *aiComputer;
    CXYPlayer *player;
    NSMutableArray *savedNodesStateList;
    GAMELEVEL _gameLevel;
    WHODOWNNODE whoDownNode;
}
@end

@implementation CXYGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"黑白棋";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(onGameSetting:)];
    
    __weak typeof(self) weakSelf = self;
    gameAreaView.chessDownBlock = ^(CXYNode *node) {
        [weakSelf onListenerBtnClick:node];
    };
    
    savedNodesStateList = [[NSMutableArray alloc]init];
    aiComputer = [[CXYAIComputer alloc]init];
    aiComputer.owerStateColor = KWHITE;
    
    player = [[CXYPlayer alloc]init];
    player.owerStateColor = KBLACK;
    whoDownNode = PLAYER;
    
    [self onInitChess];
}

- (void)onGameSetting:(UIBarButtonItem*)sender {
    if (gameAreaView.gameState == GAMEING) {
        [CXYUtils showAlert:kGAMING_MESSAGE];
        return;
    }
    __weak typeof(self) weakSelf = self;
    CXYGameSettingViewController *c = [CXYGameSettingViewController new];
    c.colorIndex = player.owerStateColor;
    c.levelIndex = _gameLevel;
    c.colorBlock = ^(NODESTATE nodeState){
        player.owerStateColor = nodeState;
        aiComputer.owerStateColor = nodeState==KBLACK?KWHITE:KBLACK;
    };
    c.levelBlock = ^(GAMELEVEL gameLevel){
        _gameLevel = gameLevel;
    };
    c.saveBlock = ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf onInitChess];
    };  
    [self presentViewController:c animated:YES completion:nil];
}

// AI下棋
- (void)aiComputerPlayer {
    if (gameAreaView.gameState == GAMEING) {
        NSArray *allowDownNodesList = [aiComputer getCurrentAllowDownNodesInView:gameAreaView];
        if (allowDownNodesList.count == 0) {
            whoDownNode = PLAYER;
            [player setHintState:gameAreaView];
            [gameAreaView onJudgeWinForPlayer:aiComputer OtherPlayer:player];
            return;
        }
        CXYNode *node = [aiComputer nodeTagForCreateInView:gameAreaView Nodes:allowDownNodesList Level:_gameLevel];
        [aiComputer changeNodeStateInView:gameAreaView theNode:node];
        whoDownNode = PLAYER;
        [player setHintState:gameAreaView];
        [gameAreaView onJudgeWinForPlayer:aiComputer OtherPlayer:player];
        [self onOpenSound];
        if ([player getCurrentAllowDownNodesInView:gameAreaView].count == 0) {
            [self aiComputerPlayer];
        }
    }
}


- (void)onListenerBtnClick:(CXYNode*)node {
    if (node.nodeState != KHINT) return;
    if ([player isAllowDownInView:gameAreaView theNode:node]) {
        if (gameAreaView.gameState == GAMEREADY) {
            gameAreaView.gameState = GAMEING;
        }
        if (gameAreaView.gameState == GAMEING) {
            [savedNodesStateList addObject:[player getCurrentNodeState:gameAreaView]];
            [player clearHintState:gameAreaView];
            [player changeNodeStateInView:gameAreaView theNode:node];
            whoDownNode = AICOMPUTER;
            [gameAreaView onJudgeWinForPlayer:aiComputer OtherPlayer:player];
            [self onOpenSound];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self aiComputerPlayer];
        });
    }
}

// 悔棋
- (IBAction)unDoChess:(id)sender {
    if (0 == savedNodesStateList.count) {
        [CXYUtils showAlert:kGAMEREADY_MESSAGE];
        return;
    }
    if (gameAreaView.gameState == GAMEING) {
        [player unDoNodeStateInView:gameAreaView Nodes:[savedNodesStateList lastObject]];
        [gameAreaView onCalculateNodeNum];
        [savedNodesStateList removeLastObject];
    }
}

// 重新开始游戏
- (IBAction)onReStart:(id)sender {
    if (GAMEREADY == gameAreaView.gameState) return;
    [self onInitChess];
}

- (void)onInitChess {
    gameAreaView.gameState = GAMEREADY;
    [player clearHintState:gameAreaView];
    [gameAreaView onInitNodesWithPlayer:player];
    [gameAreaView onCalculateNodeNum];
    [savedNodesStateList removeAllObjects];
}

// 播放声音
- (void)onOpenSound {
    [CXYUtils playChessSound];
}


@end
