//
//  blackjack.m
//  BlackJackGame
//
//  Created by Yaroslav Dukal on 09.03.15.
//  Copyright (c) 2015 Yaroslav Dukal. All rights reserved.
//

#import "blackjack.h"

@interface blackjack ()

@end

@implementation blackjack

@synthesize totalDealerVallue;
@synthesize topCard;
@synthesize cardKeys, cardValues, cardsShuffled;
@synthesize dictionary;
@synthesize currentName;
@synthesize faceDownCard;
@synthesize nextCardToFLip;
@synthesize autoPlay;

- (void)viewDidLoad
{
    currentCard = 1;
    totalDealerVallue = 0;
    startLocation = topCard.frame;
  
    
    cardKeys = [[NSArray alloc] initWithObjects:
                @"clubAce", @"diamondAce", @"heartace", @"spadeAce",
                
                @"club2",
                @"diamond2",
                @"heart2",
                @"spade2",
                
                @"club3",
                @"diamond3",
                @"heart3",
                @"spade3",
                
                @"club4",
                @"diamond4",
                @"heart4",
                @"spade4",
                
                @"club5",
                @"diamond5",
                @"heart5",
                @"spade5",
                
                @"club6",
                @"diamond6",
                @"heart6",
                @"spade6",
                
                @"club7",
                @"diamond7",
                @"heart7",
                @"spade7",
                
                @"club8",
                @"diamond8",
                @"heart8",
                @"spade8",
                
                @"club9", @"diamond9", @"heart9", @"spade9",
                @"club10", @"diamond10", @"heart10", @"spade10",
                
                @"clubjack", @"diamondjack", @"heartjack", @"spadejack",
                @"clubqueen", @"diamondqueen", @"heartqueen", @"spadequeen",
                @"clubking", @"diamondking", @"heartking", @"spadeking",
                nil];
    
    cardValues = [[NSMutableArray alloc] init];
    
    int b = 1;
    
    for (int a = 1; a <= 13; a++)
    {
        if (a < 10) {
            b = a;
        }
        else {
            b = 10;
        }
        
        if (a == 1)
        {
            b = 11;
        }
        
        [cardValues addObject:[NSNumber numberWithInt:b]];
        [cardValues addObject:[NSNumber numberWithInt:b]];
        [cardValues addObject:[NSNumber numberWithInt:b]];
        [cardValues addObject:[NSNumber numberWithInt:b]];

    }
    
    dictionary = [[NSDictionary alloc] initWithObjects: cardValues forKeys:cardKeys];
    //NSLog(@" %@ ", dictionary);
    
    [self performSelector:@selector(shuffleDeck) withObject:nil afterDelay:0.5];
    [super viewDidLoad];
}

- (void) shuffleDeck
{
    cardsShuffled = [[NSMutableArray alloc] initWithArray:cardKeys];
    long a = [cardsShuffled count];
    
    for (int b = 0; b < a; b++)
    {
        int randomObject = arc4random() % [cardsShuffled count];
        NSString *swapObject = [[NSString alloc] init];
        swapObject = [cardsShuffled objectAtIndex:b];
        [cardsShuffled replaceObjectAtIndex:b withObject: [cardsShuffled objectAtIndex:randomObject]];
        [cardsShuffled replaceObjectAtIndex: randomObject withObject:swapObject];
        
        [swapObject release];
    }
    
    [self dealCards];
}


- (void) dealCards {
    
    while (currentCard <= 2) {
        
        currentName = [NSMutableString stringWithFormat:@"%@", [cardsShuffled objectAtIndex:currentCard]];
        totalDealerVallue+= [[dictionary valueForKey:[cardsShuffled objectAtIndex:currentCard]] intValue];
        
        UIImageView *imageview = [[UIImageView alloc] init];
        
        if (currentCard == 1)
        {
            
            if (autoPlay == YES) {
                imageview.image = [UIImage imageNamed:@"cardback"];

            } else {
                imageview.image = [UIImage imageNamed:currentName];
            }
    } else if (currentCard == 2)
        {
            imageview.image = [UIImage imageNamed:currentName];
        }
        
         cardLocation = CGRectMake(currentCard * 20, currentCard * 30, 71, 96);
         nextCardLocation = CGRectMake( (currentCard + 1) * 20, (currentCard + 1) * 30, 71, 96);
        
         imageview.tag = currentCard;
        
        [self.view addSubview:imageview];
        [self.view insertSubview:topCard aboveSubview:imageview];
       
        imageview.frame = startLocation;  //Start location for animation from the deck
        
        [UIView beginAnimations:@"Deal Cards" context:nil];
        [UIView setAnimationDuration: .5];
        
        if (currentCard == 2) {
            [UIView setAnimationDelay:1];
            [UIView setAnimationDidStopSelector:@selector(firstTwoCardsDealt)];
        }
        [UIView setAnimationDelegate:self];
        [UIView setAnimationRepeatCount:0];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        imageview.frame = cardLocation;  // where to put card after done animation

        [UIView commitAnimations];
        currentCard += 1;
    }
    
    faceDownCard = (UIImageView* )[self.view viewWithTag:1];
    faceDownCard.userInteractionEnabled = YES;
    
}

-(void) dealNewCard {

    topCard.hidden = NO;
    topCard.image = [UIImage imageNamed:@"cardback"];
    
    [UIView beginAnimations:@"Animate Dealing" context:nil];
    [UIView setAnimationDidStopSelector:@selector(dealNewCardDone)];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
   // topCard.frame = startLocation;
   // topCard.frame = nextCardLocation;
    
    [UIView commitAnimations];
    
}
-(void) dealNewCardDone {
    
    currentName = [NSMutableString stringWithFormat:@"%@", [cardsShuffled objectAtIndex:currentCard]];
    totalDealerVallue+= [[dictionary valueForKey:[cardsShuffled objectAtIndex:currentCard]] intValue];
    [self dealWithAces];
    
    UIImageView *myview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:currentName]];
    
    cardLocation = CGRectMake(currentCard * 20, currentCard * 30, 71, 96);
    nextCardLocation = CGRectMake( (currentCard + 1) * 20, (currentCard + 1) * 30, 71, 96);
    [self flipCard];
    myview.frame = cardLocation;
    myview.tag = currentCard;

    nextCardToFLip = myview;
    nextCardToFLip.hidden = YES;

    [self.view addSubview:myview];
    
    [self.view insertSubview:topCard aboveSubview:myview];
    
    
    currentCard++;
    
}


-(void) revealHiddenCard {
    
    if (autoPlay == YES) {
    [UIView beginAnimations:@"Reveal first Card" context:nil];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:faceDownCard cache:YES];
    
    currentName = [NSMutableString stringWithFormat:@"%@", [cardsShuffled objectAtIndex:1] ];
    faceDownCard.image = [UIImage imageNamed:currentName];
    [UIView commitAnimations];
}
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName: @"dealerDonePlaying" object:nil];
}
    

-(void) dealWithAces {
    if (totalDealerVallue >= 22)
    {
        if ([[dictionary valueForKey:[cardsShuffled objectAtIndex:currentCard]] intValue]  ==  11) {
            totalDealerVallue-=10;
            
        }
    }
    
}

-(void) flipCard
{
    [UIView beginAnimations:@"Flio Top Card" context:nil];
    [UIView setAnimationDidStopSelector:@selector(flipCardDone)];
    [UIView setAnimationDuration: 1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:0];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:topCard cache:YES];
    
    topCard.image = [UIImage imageNamed:currentName];
    
    [UIView commitAnimations];
}

-(void) flipCardDone
{
    topCard.hidden = YES;
    nextCardToFLip.hidden = NO;
    
if (autoPlay == YES)
    {
        [self delearMightHit];
    }
}

-(void) firstTwoCardsDealt
{
     NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName: @"FirstTwoCardsReady" object:nil];
    
}

-(void) delearMightHit
{
    if (autoPlay == YES) {
        if (totalDealerVallue <= 16)
        {
            [self dealNewCard];
        }
        else {
            [self performSelector:@selector(revealHiddenCard) withObject:nil afterDelay:0.5];
            
        } }
    // Player is playing.................
    if (autoPlay == NO) {
        if (totalDealerVallue <= 20)
        {
            [self dealNewCard];
        }
        else {
            NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName: @"dealerDonePlaying" object:nil];
            
        }
    }
    
    
}
- (void)viewDidUnload {
    cardKeys = nil;
    cardsShuffled = nil;
    cardValues = nil;
    dictionary = nil;
    [super viewDidUnload];
    
}
-(void) dealloc
{
    [cardKeys release];
    [cardValues release];
    [dictionary release];
    
    [super dealloc];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch* touch = [touches anyObject];
    CGPoint startTouchlocation = [touch locationInView:touch.view];
    
    if ([[self.view viewWithTag:1] hitTest:startTouchlocation withEvent:event]) {
        
        if (autoPlay == NO) {
             [self delearMightHit];
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
