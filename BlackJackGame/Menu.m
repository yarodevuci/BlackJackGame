//
//  Menu.m
//  BlackJackGame
//
//  Created by Yaroslav Dukal on 13.03.15.
//  Copyright (c) 2015 Yaroslav Dukal. All rights reserved.
//

#import "Menu.h"
#import "ViewController.h"

@interface Menu ()

@end

@implementation Menu
@synthesize startGame, settingsTab, exitButtonMain;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)exitTheGame:(id)sender {
    
    exit(0);
    
}

-(IBAction)enterNewgame:(id)sender {
    
    ViewController *mainView = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [UIView beginAnimations:@"Flipping" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    
    [self.view addSubview:mainView.view];
    [UIView commitAnimations];
    
    //[mainView release];
    
}

-(IBAction)enterSettingsMenu:(id)sender {
    
    
     NSLog(@"You will enter Settings of the game");
    
}


- (void)dealloc {
    [startGame release];
    //[exitButtonMain release];
    [settingsTab release];
    [super dealloc];
}
@end
