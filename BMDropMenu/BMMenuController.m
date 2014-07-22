//
//  BMMenuController.m
//  BMDropMenu
//
//  Created by Adam Eri on 22/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import "BMMenuController.h"
#import "BMMenuItem.h"


#pragma mark - Private Interface
@interface BMMenuController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/**
 *  Collection view holding the menu items.
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  Visual effect view holding the collection view.
 */
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;

#pragma mark - Animations

/**
 *  Animates the menu to the provided rect.
 *
 *  @param rect CGRect
 */
- (void)animateViewToRect:(CGRect)rect;

/**
 *  Animates the passed item when it is selected by the user.
 *
 *  @param item BMMenuItem
 */
- (void)animateSelectingItem:(BMMenuItem *)item;

@end

#pragma mark - Implementation
@implementation BMMenuController

- (instancetype)init {
    return [self initWithBlurEffectStyle:UIBlurEffectStyleDark];
}

- (instancetype)initWithBlurEffectStyle:(UIBlurEffectStyle)blurStyle {
    if (self = [super init]) {

        _isVisible = NO;

        // UICollectionView
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];

        // Visual effect view for the blur background
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:blurStyle]];
        [_visualEffectView.contentView addSubview:_collectionView];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [_collectionView registerClass:[BMMenuItem class] forCellWithReuseIdentifier:@"MenuItem"];

    CGFloat maxHeight = ceilf([_dataSource numberOfItemsInMenuController:self] / 2) * (self.view.frame.size.width / 2 - 30) + 1;

    _visualEffectView.frame = CGRectMake(0, -maxHeight, self.view.frame.size.width, maxHeight);
    _collectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, maxHeight);

    [self.view addSubview:_visualEffectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Actions

- (void)show {
    CGRect visibleFrame = _visualEffectView.frame;
    visibleFrame.origin.y = 0;
    [self animateViewToRect:visibleFrame];
    _isVisible = YES;
}

- (void)showFromNavigationBar:(UINavigationBar *)navigationBar {
    CGRect visibleFrame = _visualEffectView.frame;
    visibleFrame.origin.y = navigationBar.frame.origin.y + navigationBar.frame.size.height;
    [self animateViewToRect:visibleFrame];
    _isVisible = YES;
}

- (void)dismiss {
    CGRect hiddenFrame = _visualEffectView.frame;
    hiddenFrame.origin.y = -hiddenFrame.size.height;
    [self animateViewToRect:hiddenFrame];
    _isVisible = NO;
}

#pragma mark - Animations
- (void)animateViewToRect:(CGRect)rect {
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:10
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         _visualEffectView.frame = rect;
                     } completion:^(BOOL finished) {
                         // completed
                     }];
}

- (void)animateSelectingItem:(BMMenuItem *)item {

    UIColor *originalBackground = item.backgroundColor;

    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        item.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            item.backgroundColor = originalBackground;
        } completion:^(BOOL finished) {
            [self dismiss];
        }];
    }];
}

#pragma mark - UICollectionView Delegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    BMMenuItem *item = (BMMenuItem *)[collectionView cellForItemAtIndexPath:indexPath];
    [self animateSelectingItem:item];

    // TODO: some nice animation on selection
    [_delegate menuController:self didSelectItemAtIndexPath:indexPath];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataSource numberOfItemsInMenuController:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *item = [_dataSource menuController:self menuItemForIndexPath:indexPath];

    static NSString *identifier = @"MenuItem";

    BMMenuItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    cell.titleLabel.text = [[item allKeys] firstObject];
    cell.imageView.image = [UIImage imageNamed:[[item allValues] firstObject]];

    return cell;
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat size = self.view.frame.size.width / 2 - 1;
    return CGSizeMake(size, size - 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

@end
