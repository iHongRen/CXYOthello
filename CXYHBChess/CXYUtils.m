//
//  CXYUtils.m
//  CXYHBChess
//
//  Created by iMac on 14-9-18.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYUtils.h"
#import <AVFoundation/AVFoundation.h>

@implementation CXYUtils

+ (void)showAlert:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction =
    [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)playChessSound {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"wav"];
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    [audioPlayer play];
}
@end
