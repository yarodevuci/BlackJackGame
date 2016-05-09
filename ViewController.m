//  ViewController.m
//  BlackJackGame
//
//  Created by Yaroslav Dukal on 09.03.15.
//  Copyright (c) 2015 Yaroslav Dukal. All rights reserved.
//

#import "ViewController.h"
#import "blackjack.h"
#import "Menu.h"


@implementation ViewController

@synthesize button1, button2, button3, exitbutton;
@synthesize theBlackJack;

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    autoPlay = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstTwoDealt) name:@"FirstTwoCardsReady" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(donePlaying) name:@"dealerDonePlaying" object:nil];
    button2.title = @"";
    button2.enabled = NO;
    [super viewDidLoad];
}

-(void) donePlaying {
    
    button1.enabled = YES;
    button1.title = @"PLAY";
    button2.enabled = NO;
    button2.title = @"";
    button3.enabled = NO;
    button3.title = @"";
    
    if (autoPlay == YES) {
        if (theBlackJack.totalDealerVallue > 21) {
            NSString* dealerValueText = [[NSString alloc ] initWithFormat:@"Dealer has %i ", theBlackJack.totalDealerVallue];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dealer Busts!" message:dealerValueText  delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: @"Continue", nil];
            
            [alert setDelegate:self];
            [alert show];
            [alert release];
            [dealerValueText release];

            button2.enabled = NO;
            
}   else {
            
            NSString* dealerValueText = [[NSString alloc ] initWithFormat:@"Dealer stands %i  ", theBlackJack.totalDealerVallue];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:dealerValueText  delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: @"Continue", nil];
    
                [alert setDelegate:self];
                [alert show];
                [alert release];
    [dealerValueText release];

    }
    }
    if (autoPlay == NO) {
        if (theBlackJack.totalDealerVallue > 21) {
            NSString* dealerValueText = [[NSString alloc ] initWithFormat:@"Player has %i ", theBlackJack.totalDealerVallue];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Player Busts!" message:dealerValueText  delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: @"Continue", nil];
            
            
            [alert setDelegate:self];
            [alert show];
            [alert release];
            [dealerValueText release];

            button2.enabled = NO;
            
        }   else {
            
            NSString* dealerValueText = [[NSString alloc ] initWithFormat:@"Player stands %i  ", theBlackJack.totalDealerVallue];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:dealerValueText  delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: @"Continue", nil];
            
            [alert setDelegate:self];
            [alert show];
            [alert release];
            [dealerValueText release];

           button2.enabled = NO;
        }
    }

    
}
//Обработчик нажатий
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //NSLog(@"OK button pressed");
    }
    if (buttonIndex == 1)
    {
        [self playBlackJack:self];
    }
}


-(void) firstTwoDealt
{
    if (autoPlay == YES) {
        
    button1.title = @"";
    button2.title = @"Make Dealer Play";
    button2.enabled = YES;
    } else {
        button1.title = @"";
        button2.title = @"Hit Me!";
        button2.enabled = YES;
        
        button3.title = @"STAY";
        button3.enabled = YES;
    }
}
    //go back to main screen
-(IBAction) exitfromGame:(id)sender {
    
    [UIView beginAnimations:@"Flipping back" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view.superview cache:YES];
    [self.view removeFromSuperview];
    [UIView commitAnimations];
}


-(IBAction) playBlackJack:(id)sender
{
    if (autoPlay == YES) {
        autoPlay = NO;
        
    }
    else
    {
        autoPlay = YES;
    }
        button1.title = @"";
     button1.enabled = NO;
     button2.enabled = NO;
     button3.enabled = NO;
    
    button2.title = @"";
    button3.title = @"";
    
    if (theBlackJack.view != nil) {
        
        [theBlackJack.view removeFromSuperview];
        
    }
    
    blackjack *newBlackJack = [[blackjack alloc] initWithNibName:@"blackjack" bundle:nil];
    self.theBlackJack = newBlackJack;
    [self.view insertSubview:theBlackJack.view atIndex:1];
    [newBlackJack release];
    
    theBlackJack.autoPlay = autoPlay;
    
}


-(IBAction) showDealerHand:(id)sender
{
    if (autoPlay == YES)
    {
    button1.enabled = NO;
        button1.title = @"";
    button2.enabled = NO;
    button2.title = @"Dealer Playing...";
    
    [theBlackJack delearMightHit];   // NSLog(@"show hand");
    }
        else
    {
        button1.enabled = NO;
        button2.enabled = YES;
        button2.title = @"HIT!";
        [theBlackJack delearMightHit];
    }
}
-(IBAction) stay:(id)sender {
    [self donePlaying];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
