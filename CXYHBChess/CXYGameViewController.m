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
#import <AVFoundation/AVFoundation.h>
@interface CXYGameViewController ()
{
    IBOutlet CXYGameAreaView *gameAreaView;
    
    CXYAIComputer *aiComputer;
    CXYPlayer *player;
    NSMutableArray *savedNodesStateList;
    GAMELEVEL _gameLevel;
    
    WHODOWNNODE whoDownNode;
    
    AVAudioPlayer *audioPlayer;
}
@end

@implementation CXYGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:kSETTING style:UIBarButtonItemStylePlain target:self action:@selector(onGameSetting:)];
    
    savedNodesStateList = [[NSMutableArray alloc]init];
    aiComputer = [[CXYAIComputer alloc]init];
    aiComputer.owerStateColor = KWHITE;
    
    player = [[CXYPlayer alloc]init];
    player.owerStateColor = KBLACK;
    whoDownNode = PLAYER;
    
    [self onInitChess];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(aiComputerPlayer) name:CXYAIDownNodeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onListenerBtnClick:) name:CXYPlayerDownNodeNotification object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)onGameSetting:(UIBarButtonItem*)sender
{
    if (gameAreaView.gameState == GAMEING) {
        kAlert(kGAMING_MESSAGE);
        return;
    }
    __weak typeof(self) weakSelf = self;
    CXYGameSettingViewController *gameSettingVC = [[CXYGameSettingViewController alloc]initWithNibName:@"CXYGameSettingViewController" bundle:nil];
    gameSettingVC.colorIndex = player.owerStateColor;
    gameSettingVC.levelIndex = _gameLevel;
    gameSettingVC.colorBlock = ^(NODESTATE nodeState){
        player.owerStateColor = nodeState;
        aiComputer.owerStateColor = nodeState==KBLACK?KWHITE:KBLACK;
    };
    gameSettingVC.levelBlock = ^(GAMELEVEL gameLevel){
        _gameLevel = gameLevel;
    };
    gameSettingVC.saveBlock = ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf onInitChess];
    };
  
    [self presentViewController:gameSettingVC animated:YES completion:nil];
}

// AI下棋
- (void)aiComputerPlayer
{
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

// 获取通知
- (void)onListenerBtnClick:(NSNotification*)noti
{
    CXYNode *node = (CXYNode*)[noti object];
    if (node.nodeState != KHINT) {
        return;
    }
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
        [self performSelector:@selector(onDelay) withObject:nil afterDelay:0.5];
    }
}

- (void)onDelay
{
    [[NSNotificationCenter defaultCenter]postNotificationName:CXYAIDownNodeNotification object:nil];
}

// 悔棋
- (IBAction)unDoChess:(id)sender
{
    if (0 == savedNodesStateList.count) {
        kAlert(kGAMEREADY_MESSAGE);
        return;
    }
    if (gameAreaView.gameState == GAMEING) {
        [player unDoNodeStateInView:gameAreaView Nodes:[savedNodesStateList lastObject]];
        [gameAreaView onCalculateNodeNum];
        [savedNodesStateList removeLastObject];
    }
}

// 重新开始游戏
- (IBAction)onReStart:(id)sender
{
    if (GAMEREADY == gameAreaView.gameState) {
        return;
    }
    [self onInitChess];
}

- (void)onInitChess
{
    gameAreaView.gameState = GAMEREADY;
    [player clearHintState:gameAreaView];
    [gameAreaView onInitNodesWithPlayer:player];
    [gameAreaView onCalculateNodeNum];
    [savedNodesStateList removeAllObjects];
}

// 播放声音
- (void)onOpenSound
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    if (!audioPlayer) {
        NSError *error = nil;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"wav"];
        audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
    }
    [audioPlayer play];
}

- (void)dealloc
{
     [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
