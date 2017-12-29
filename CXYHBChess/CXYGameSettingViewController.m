//
//  CXYGameSettingViewController.m
//  CXYHBChess
//
//  Created by iMac on 14-9-4.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYGameSettingViewController.h"

@interface CXYGameSettingViewController () {
    IBOutlet UISegmentedControl* colorSegment;
    IBOutlet UISegmentedControl* levelSegment;
}
@end

@implementation CXYGameSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    colorSegment.selectedSegmentIndex = self.colorIndex;
    levelSegment.selectedSegmentIndex = self.levelIndex;
}


- (IBAction)onSeleteColor:(UISegmentedControl*)sender {
    if (self.colorBlock) {
        self.colorBlock(sender.selectedSegmentIndex);
    }
}

- (IBAction)onSeleteLevel:(UISegmentedControl*)sender {
    if (self.levelBlock) {
        self.levelBlock(sender.selectedSegmentIndex);
    }
}

- (IBAction)onSaveSetting:(id)sender {
    __typeof (&*self) __weak weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.saveBlock) {
            weakSelf.saveBlock();
        }
    }];
}


@end
