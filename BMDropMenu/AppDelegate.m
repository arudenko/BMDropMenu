//
//  AppDelegate.m
//  BMDropMenu
//
//  Created by Adam Eri on 22/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import "AppDelegate.h"
#import "BMViewController.h"
#import "BMNavigationController.h"

@interface AppDelegate () <BMNavigationControllerDelegate>

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];

    BMNavigationController *navigationController = [[BMNavigationController alloc] init];
    navigationController.delegate = self;

    navigationController.barTintColor = [UIColor redColor];
    navigationController.tintColor = [UIColor whiteColor];
    
    [navigationController.menuItems addObjectsFromArray:@[
                                                          @{@"Dashboard" : @"dashboard-big-icon"},
                                                          @{@"Agenda" : @"calendar-icon"},
                                                          @{@"Map" : @"map-icon"},
                                                          @{@"Donation" : @"donation-icon"},
                                                          @{@"Registration" : @"registration-icon"},
                                                          @{@"Getting There" : @"getting-there-icon"}]];

    BMViewController *viewController = [[BMViewController alloc] init];
    viewController.title = @"BMDropDownMenu";
    [navigationController setViewControllers:@[viewController]];

    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark - BMNavigationControllerDelegate

- (UIViewController *)navigationController:(BMNavigationController *)navigationController viewControllerForIndex:(NSInteger)index {
    BMViewController *viewController = [[BMViewController alloc] init];
    viewController.title = [[[navigationController.menuItems objectAtIndex:index] allKeys] firstObject];

    NSString *imageName = (index % 2) ? @"london.jpg" : @"flag.jpg";

    UIImage *imageToDisplay =
    [UIImage imageWithCGImage:[[UIImage imageNamed:imageName] CGImage]
                        scale:[UIScreen mainScreen].scale*0.8
                  orientation: UIImageOrientationUp];

    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:imageToDisplay];
    [viewController.view addSubview:backgroundView];


    return viewController;
}

@end
