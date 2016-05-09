//
//  blackjack.h
//  BlackJackGame
//
//  Created by Yaroslav Dukal on 09.03.15.
//  Copyright (c) 2015 Yaroslav Dukal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface blackjack : UIViewController
{
    
    IBOutlet UIImageView* topCard;
    
    int currentCard, totalDealerVallue;
    NSArray *cardKeys;
    NSMutableArray *cardValues;
    NSMutableArray *cardsShuffled;
    NSDictionary *dictionary;
    NSMutableString *currentName;
    
    CGRect cardLocation;
    CGRect startLocation;
    CGRect nextCardLocation;
    
    UIImageView* faceDownCard;
    UIImageView* nextCardToFLip;
    
    BOOL autoPlay;
    
}
@property (nonatomic) int totalDealerVallue;
@property (nonatomic, retain)  IBOutlet UIImageView* topCard;
@property (nonatomic, retain)  NSArray *cardKeys;
@property (nonatomic, retain)  NSMutableArray *cardValues;
@property (nonatomic, retain)  NSDictionary *dictionary;
@property (nonatomic, retain)  NSMutableArray *cardsShuffled;
@property (nonatomic, retain)  NSMutableString *currentName;
@property (nonatomic, retain)  UIImageView* faceDownCard;
@property (nonatomic, retain)  UIImageView* nextCardToFLip;
@property (nonatomic) BOOL autoPlay;

-(void) shuffleDeck;
-(void) dealCards;
-(void) firstTwoCardsDealt;
-(void) delearMightHit;
-(void) dealNewCard;
-(void) revealHiddenCard;
-(void) dealNewCardDone;
-(void) flipCardDone;
-(void) flipCard;
-(void) dealWithAces;
@end
