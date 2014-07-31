//
//  BMNavigationController.m
//  BMDropMenu
//
//  Created by Adam Eri on 23/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import "BMNavigationController.h"
#import "AppDelegate.h"

@interface BMNavigationController () <BMMenuControllerDelegate, BMMenuControllerDataSource>

@property (nonatomic, strong) BMMenuController *menuController;

- (void)pushFadeViewController:(UIViewController *)viewController;

@end

@implementation BMNavigationController

- (instancetype)init {
    if (self = [super init]) {
        _menuItems = [[NSMutableArray alloc] init];
        _menuController = [[BMMenuController alloc] init];
    }
    return self;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    _barTintColor = barTintColor;
    self.navigationBar.barTintColor = barTintColor;
    _menuController.originalTintColor = barTintColor;
}

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    self.navigationBar.tintColor = tintColor;
    _menuController.originalTitleColor = tintColor;

    NSMutableDictionary *textAttribs = [[NSMutableDictionary alloc] initWithDictionary:self.navigationBar.titleTextAttributes];
    [textAttribs setObject:tintColor forKey:NSForegroundColorAttributeName];
    [self.navigationBar setTitleTextAttributes:textAttribs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuController.delegate = self;
    _menuController.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushFadeViewController:(UIViewController *)viewController {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];

    [self setViewControllers:@[viewController] animated:NO];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)toggleMenu {
    if (_menuController.isVisible) {
        [_menuController dismiss];
    }
    else {
        [_menuController showFromNavigationBar:self.navigationBar];
    }
}

#pragma mark - BMMenuControllerDelegate

- (void)menuController:(BMMenuController *)menuController didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.title = [[[_menuItems objectAtIndex:indexPath.row] allKeys] firstObject];
    UIViewController *viewController = [self.delegate navigationController:self viewControllerForIndex:indexPath.row];
    [self pushFadeViewController:viewController];
}

- (void)menuControllerDidDismissMenu:(BMMenuController *)menuController {
//
}

#pragma mark - BMMenuControllerDataSource

- (NSInteger)numberOfItemsInMenuController:(BMMenuController *)menuController {
    return [_menuItems count];
}

- (NSDictionary *)menuController:(BMMenuController *)menuController menuItemForIndexPath:(NSIndexPath *)indexPath {
    return [_menuItems objectAtIndex:indexPath.row];
}


@end
