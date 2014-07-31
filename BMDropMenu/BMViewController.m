//
//  BMViewController.m
//  BMDropMenu
//
//  Created by Adam Eri on 31/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import "BMViewController.h"
#import "BMNavigationController.h"

@interface BMViewController ()

@end

@implementation BMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu-icon"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self.navigationController
                                                                             action:@selector(toggleMenu)];
}



@end
