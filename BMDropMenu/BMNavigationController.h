//
//  BMNavigationController.h
//  BMDropMenu
//
//  Created by Adam Eri on 23/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMMenuController.h"

#pragma mark - Protocol

@class BMNavigationController;
@protocol BMNavigationControllerDelegate <UINavigationControllerDelegate>

/**
 *  Delegate method asking for the view controller to be displayed by the navigation controller, when a menu item is selected. It passes the index of the selected menu item, expects a ViewController in return.
 *
 *  @param navigationController BMNavigationController
 *  @param index                NSInteger. Intex of the selected menu item.
 *
 *  @return UIViewController to be displayed.
 */
- (UIViewController *)navigationController:(BMNavigationController *)navigationController viewControllerForIndex:(NSInteger)index;

@end

#pragma mark - Public Interface

@interface BMNavigationController : UINavigationController

/**
 *  Items to be displayed in the menu. Array of NSDictionaries, where title is the key and icon image name is the value. E.g. @{@"Dashboard" : @"dashboard-big-icon"}
 */
@property (nonatomic, strong) NSMutableArray *menuItems;

/**
 *  Bar tint colour used in the navigation bar
 */
@property (nonatomic, strong) UIColor *barTintColor;

/**
 *  Tint colour used in the navigation bar
 */
@property (nonatomic, strong) UIColor *tintColor;

/**
 *  Delegate
 */
@property(nonatomic, assign) id<BMNavigationControllerDelegate> delegate;

/**
 *  Shows or hides the menu.
 */
- (void)toggleMenu;

@end
