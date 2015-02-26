//
//  ViewController.m
//  Puzzle 15
//
//  Created by Brad Taylor on 2/17/15.
//  Copyright (c) 2015 Brad Taylor. All rights reserved.
//

#import "ViewController.h"
#import "PuzzleGame.h"

@interface ViewController () {
    BOOL animationInProgress;
    NSInteger difficulty;
}

@property (nonatomic, strong) NSMutableArray *gameTiles;
@property (nonatomic, strong) PuzzleGame *puzzleGame;

@property (weak, nonatomic) IBOutlet UIButton *oneTile;
@property (weak, nonatomic) IBOutlet UIButton *twoTile;
@property (weak, nonatomic) IBOutlet UIButton *threeTile;
@property (weak, nonatomic) IBOutlet UIButton *fourTile;
@property (weak, nonatomic) IBOutlet UIButton *fiveTile;
@property (weak, nonatomic) IBOutlet UIButton *sixTile;
@property (weak, nonatomic) IBOutlet UIButton *sevenTile;
@property (weak, nonatomic) IBOutlet UIButton *eightTile;
@property (weak, nonatomic) IBOutlet UIButton *nineTile;
@property (weak, nonatomic) IBOutlet UIButton *tenTile;
@property (weak, nonatomic) IBOutlet UIButton *elevenTile;
@property (weak, nonatomic) IBOutlet UIButton *twelveTile;
@property (weak, nonatomic) IBOutlet UIButton *thirteenTile;
@property (weak, nonatomic) IBOutlet UIButton *fourteenTile;
@property (weak, nonatomic) IBOutlet UIButton *fifteenTile;
@property (weak, nonatomic) IBOutlet UIButton *blankTile;

@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *shuffleButton;
@property (weak, nonatomic) IBOutlet UISlider *shuffleSlider;


@end

static const CGFloat animationSpeed = 0.35;

@implementation ViewController

-(void) viewDidLoad {
    [super viewDidLoad];
 
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    self.puzzleGame = [[PuzzleGame alloc] init];
    animationInProgress = NO;
    difficulty = 25;
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSlideATile:)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSlideATile:)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSlideATile:)];
    [downSwipe setDirection:UISwipeGestureRecognizerDirectionDown];
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSlideATile:)];
    [upSwipe setDirection:UISwipeGestureRecognizerDirectionUp];
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
    [self.view addGestureRecognizer:downSwipe];
    [self.view addGestureRecognizer:upSwipe];
    
    [self.puzzleGame startGameWithTiles:self.gameTiles];
}

// array holding tile buttons
-(NSMutableArray *) gameTiles
{
    if ( ! _gameTiles )
        _gameTiles = [NSMutableArray arrayWithObjects:self.oneTile, self.twoTile, self.threeTile, self.fourTile,
                      self.fiveTile, self.sixTile, self.sevenTile, self.eightTile, self.nineTile,
                      self.tenTile, self.elevenTile, self.twelveTile, self.thirteenTile, self.fourteenTile,
                      self.fifteenTile, self.blankTile, nil];
    return _gameTiles;
}

// shuffle button, mix the tiles
-(IBAction) didTapShuffleButton:(UIButton *)sender {
    if ( animationInProgress )
        return;
    NSInteger diffCopy = difficulty;
    [UIView animateWithDuration:animationSpeed animations:^{
        animationInProgress = YES;
        NSMutableArray *array = [self.puzzleGame shuffleTiles];
        UIButton *tile1 = [array objectAtIndex:0];
        UIButton *tile2 = [array objectAtIndex:1];
        CGRect temp = tile2.frame;
        tile2.frame = tile1.frame;
        tile1.frame = temp;
        array = nil;
        tile1 = nil;
        tile2 = nil;
    } completion:^(BOOL finished) {
        animationInProgress = NO;
        if ( --difficulty >= 0 )
            [self didTapShuffleButton:sender];
    }];
    difficulty = diffCopy;
}

// reset button, revert the tiles
-(IBAction) didTapResetButton:(UIButton *)sender {
    if ( animationInProgress )
        return;
    if ( [self.puzzleGame isSolved] )
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Puzzle is already in solved position." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
    else {
        animationInProgress = YES;
        NSMutableArray *array = [self.puzzleGame revertTiles];
        UIButton *tile1 = [array objectAtIndex:0];
        UIButton *tile2 = [array objectAtIndex:1];
        [UIView animateWithDuration:animationSpeed animations:^{
            CGRect temp = tile2.frame;
            tile2.frame = tile1.frame;
            tile1.frame = temp;
        } completion:^(BOOL finished) {
            animationInProgress = NO;
            if ( ! [self.puzzleGame isSolved] )
                [self didTapResetButton:nil];
        }];
    }
}

// moved slider, set difficulty
-(IBAction) didMoveSlider:(UISlider *)sender {
    double value = [self.shuffleSlider value] * 50;
    difficulty = (int) value;
    if ( ! difficulty )
        difficulty = 1;
}

-(void) checkForWinner
{
    if ( [self.puzzleGame isSolved] )
        [[[UIAlertView alloc] initWithTitle:@"You Win!"
                                    message:@"Congratulations, you solved the puzzle!"
                                   delegate:nil
                          cancelButtonTitle:@"Okay"
                          otherButtonTitles:nil]
         show];
}

-(void) didSlideATile:(UISwipeGestureRecognizer *) sender
{
    if (animationInProgress)
        return;
    
    if ([self.puzzleGame canSwipeInDirection:[sender direction]]) {
        animationInProgress = YES;
        NSArray *buttonIndexes = [self.puzzleGame buttonsToSwapWithDirection:[sender direction]];
        UIButton *tile1 = [self.gameTiles objectAtIndex:[[buttonIndexes objectAtIndex:0] integerValue]];
        UIButton *tile2 = [self.gameTiles objectAtIndex:[[buttonIndexes objectAtIndex:1] integerValue]];
        [UIView animateWithDuration:animationSpeed animations:^{
            CGRect temp = tile2.frame;
            tile2.frame = tile1.frame;
            tile1.frame = temp;
        } completion:^(BOOL finished) {
            animationInProgress = NO;
            [self checkForWinner];
        }];
    }
}

- (void) dealloc
{
    self.gameTiles = nil;
    self.puzzleGame = nil;
}

@end
