//
//  AppDelegate.h
//  BlackJackGame
//
//  Created by Yaroslav Dukal on 09.03.15.
//  Copyright (c) 2015 Yaroslav Dukal. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ViewController;
@class Menu;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) Menu *mainMenu;

@end

