//
//  ViewController.m
//  BMDropMenu
//
//  Created by Adam Eri on 22/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import "ViewController.h"

#import "BMMenuController.h"

#pragma mark - Private Interface
@interface ViewController () <BMMenuControllerDelegate, BMMenuControllerDataSource>

@property (nonatomic, strong) NSMutableArray *menuData;

@property (nonatomic, strong) BMMenuController *menuController;

- (void)toggleMenu;
@end

#pragma mark - Implementation
@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        _menuData = [[NSMutableArray alloc] init];

        [_menuData addObject:@{@"Title" : @"testIcon"}];
        [_menuData addObject:@{@"Title" : @"testIcon"}];
        [_menuData addObject:@{@"Title" : @"testIcon"}];

        [_menuData addObject:@{@"Title" : @"testIcon"}];
        [_menuData addObject:@{@"Title" : @"testIcon"}];
        [_menuData addObject:@{@"Title" : @"testIcon"}];

        _menuController = [[BMMenuController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(toggleMenu)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    _menuController.delegate = self;
    _menuController.dataSource = self;

    [self.view addSubview:_menuController.view];
}

- (void)toggleMenu {
    if (_menuController.isVisible) {
        [_menuController dismiss];
    }
    else {
        [_menuController showFromNavigationBar:self.navigationController.navigationBar];
    }
}

#pragma mark - BMMenuControllerDelegate

- (void)menuController:(BMMenuController *)menuController didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - BMMenuControllerDataSource

- (NSInteger)numberOfItemsInMenuController:(BMMenuController *)menuController {
    return [_menuData count];
}

- (NSDictionary *)menuController:(BMMenuController *)menuController menuItemForIndexPath:(NSIndexPath *)indexPath {
    return [_menuData objectAtIndex:indexPath.row];
}

@end
