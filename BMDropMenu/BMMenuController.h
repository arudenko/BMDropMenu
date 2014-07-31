//
//  BMMenuController.h
//  BMDropMenu
//
//  Created by Adam Eri on 22/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMMenuController;

#pragma mark - BMMenuController Delegate
@protocol BMMenuControllerDelegate <NSObject>

/**
 *  Delegate method called when the menu controller selects a menu item.
 *
 *  @param menuController BMMenuController. Instance of the menu controller
 *  @param indexPath      NSIndexPath of the selected item.
 */
- (void)menuController:(BMMenuController *)menuController didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)menuControllerDidDismissMenu:(BMMenuController *)menuController;

@end

#pragma mark - BMMenuController Delegate
@protocol BMMenuControllerDataSource <NSObject>

/**
 *  Datasource delegate method for asking the menu item for the given indexPath. Provide and NSDictionary for the item key being the title, image name string as the value.
 *
 *  @param menuController BMMenuController. Instance of the menu controller
 *  @param indexPath      NSIndexPath of the item to be returned
 *
 *  @return NSDictionary @{"title":"image name"}
 */
- (NSDictionary *)menuController:(BMMenuController *)menuController menuItemForIndexPath:(NSIndexPath *)indexPath;

/**
 *  Datasource delegate method asking for the total number of menu item cells.
 *
 *  @param menuController BMMenuController. Instance of the menu controller
 *
 *  @return NSInteger. Total number of menu items in the menu.
 */
- (NSInteger)numberOfItemsInMenuController:(BMMenuController *)menuController;

@end

#pragma mark - Public Interface
@interface BMMenuController : UIViewController

@property (nonatomic, assign) id<BMMenuControllerDelegate> delegate;
@property (nonatomic, assign) id<BMMenuControllerDataSource> dataSource;

/**
 *  Initiates the menu controller with a blur stlye. Available styles: UIBlurEffectStyleExtraLight, UIBlurEffectStyleLight, UIBlurEffectStyleDark.
 *
 *  @param blurStyle UIBlurEffectStyle
 *
 *  @return BMMenuController
 */
- (instancetype)initWithBlurEffectStyle:(UIBlurEffectStyle)blurStyle;

/**
 *  Indicates whether the menu is currently shown.
 */
@property (nonatomic, assign) BOOL isVisible;

// Properties to customise the appereance of the navigation bar
@property (nonatomic, strong) UIColor *navigationBarTintColor;
@property (nonatomic, strong) UIColor *navigationBarTitleColor;

@property (nonatomic, strong) UIColor *originalTintColor;
@property (nonatomic, strong) UIColor *originalTitleColor;

#pragma mark - User Actions
/**
 *  Method for showing the menu.
 */
- (void)show;

/**
 *  Method for showing the menu from the navigation bar
 *
 *  @param navigationBar UINavigationBar
 */
- (void)showFromNavigationBar:(UINavigationBar *)navigationBar;

/**
 *  Method for hiding the menu.
 */
- (void)dismiss;

@end
