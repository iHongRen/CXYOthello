//
//  CXYMainViewController.m
//  CXYHBChess
//
//  Created by iMac on 14-9-2.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYMainViewController.h"
#import "CXYGameViewController.h"
@interface CXYMainViewController ()
{
    IBOutletCollection(UIButton) NSArray *btnsList;
}
@end

@implementation CXYMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = kMAIN_TITLE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)onBattleWithComputer:(id)sender
{
    CXYGameViewController *gameVC = [[CXYGameViewController alloc]initWithNibName:@"CXYGameViewController" bundle:nil];
    gameVC.navigationItem.title = kGAME_TITLE;
    [self.navigationController pushViewController:gameVC animated:YES];
}

- (IBAction)onBattleWithPlayer:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
