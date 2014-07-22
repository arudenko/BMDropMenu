//
//  BMMenuController.h
//  BMDropMenu
//
//  Created by Adam Eri on 22/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMMenuController, BMMenuItem;

#pragma mark - BMMenuController Delegate
@protocol BMMenuControllerDelegate <NSObject>

/**
 *  Delegate method called when the menu controller selects a menu item.
 *
 *  @param menuController BMMenuController. Instance of the menu controller
 *  @param indexPath      NSIndexPath of the selected item.
 */
- (void)menuController:(BMMenuController *)menuController didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - BMMenuController Delegate
@protocol BMMenuControllerDataSource <NSObject>

/**
 *  Datasource delegate method for asking menu item for the given indexPath.
 *
 *  @param menuController BMMenuController. Instance of the menu controller
 *  @param indexPath      NSIndexPath of the item to be returned
 *
 *  @return BMMenuItem
 */
- (BMMenuItem *)menuController:(BMMenuController *)menuController menuItemForIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - Public Interface
@interface BMMenuController : UIViewController


@end
