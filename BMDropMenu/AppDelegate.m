//
//  AppDelegate.m
//  BMDropMenu
//
//  Created by Adam Eri on 22/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    ViewController *viewController = [[ViewController alloc] init];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor blackColor];
    UIImage *imageToDisplay =
    [UIImage imageWithCGImage:[[UIImage imageNamed:@"testImage.jpg"] CGImage]
                        scale:[UIScreen mainScreen].scale*0.32
                  orientation: UIImageOrientationUp];

    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:imageToDisplay];
    [self.window addSubview:backgroundView];

    [self.window setRootViewController:viewController];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
