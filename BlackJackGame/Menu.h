//
//  Menu.h
//  BlackJackGame
//
//  Created by Yaroslav Dukal on 13.03.15.
//  Copyright (c) 2015 Yaroslav Dukal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Menu : UIViewController {
    
    IBOutlet UIButton *startGame;
    IBOutlet UIButton *exitButtonMain;
    IBOutlet UIButton *settingsTab;
    

    
    
}

@property (nonatomic, retain) IBOutlet UIButton *startGame;
@property (nonatomic, retain) IBOutlet UIButton *exitButtonMain;
@property (nonatomic, retain) IBOutlet UIButton *settingsTab;


-(IBAction) enterNewgame:(id)sender;
-(IBAction) exitTheGame:(id)sender;
-(IBAction) enterSettingsMenu:(id)sender;



@end
