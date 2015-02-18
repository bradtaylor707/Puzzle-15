//
//  ViewController.m
//  Puzzle 15
//
//  Created by Brad Taylor on 2/17/15.
//  Copyright (c) 2015 Brad Taylor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
}

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

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
- (IBAction)didTapShuffleButton:(UIButton *)sender {
    NSLog(@"Tapped the %@ button.", [sender currentTitle]);
}
- (IBAction)didTapResetButton:(UIButton *)sender {
    NSLog(@"Tapped the %@ button.", [sender currentTitle]);
}
- (IBAction)didTapTileButton:(UIButton *)sender {
    NSLog(@"Tapped the %@ button.", [sender currentTitle]);
}
- (IBAction)didMoveSlider:(UISlider *)sender {
    NSLog(@"Slider is now at %@", @([self.shuffleSlider value]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
