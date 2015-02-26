//
//  main.m
//  Puzzle 15
//
//  Created by Brad Taylor on 2/17/15.
//  Copyright (c) 2015 Brad Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        srandom( (int) [[NSDate date] timeIntervalSince1970] );
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
