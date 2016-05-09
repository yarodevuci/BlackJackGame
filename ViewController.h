//  ViewController.h
//  BlackJackGame
//
//  Created by Yaroslav Dukal on 09.03.15.
//  Copyright (c) 2015 Yaroslav Dukal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class blackjack;  //adding class blackjack



@interface ViewController : UIViewController <UIAlertViewDelegate>{
    
    
    IBOutlet UIBarButtonItem *button1;
    IBOutlet UIBarButtonItem *button2;
    IBOutlet UIBarButtonItem *button3;
    
    IBOutlet UIButton *exitbutton;
    
    blackjack *theBlackJack;
    
    BOOL autoPlay;
    
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *button1;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *button2;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *button3;
@property (nonatomic, retain) IBOutlet UIButton *exitbutton;
@property (nonatomic, retain) blackjack *theBlackJack;

-(IBAction) playBlackJack:(id)sender;
-(IBAction) showDealerHand:(id)sender;
-(IBAction) stay:(id)sender;
-(IBAction) exitfromGame:(id)sender;

-(void) firstTwoDealt;

@end
