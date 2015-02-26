//
//  ViewController.h
//  Puzzle 15
//
//  Created by Brad Taylor on 2/17/15.
//  Copyright (c) 2015 Brad Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

-(IBAction) didTapShuffleButton:(UIButton *)sender;
-(IBAction) didTapResetButton:(UIButton *)sender;
-(IBAction) didMoveSlider:(UISlider *)sender;
-(void) didSlideATile:(UISwipeGestureRecognizer *)sender;

@end

