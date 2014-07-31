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

@property (nonatomic, strong) UINavigationBar *navigationBar;


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

/**
 *  Animates the colours of the navigation bar.
 *
 *  @param tintColor  UIColor - tint color of the navbar
 *  @param titleColor UIColor - color of the icons and title
 */
- (void)changeNavigationBarTintColor:(UIColor *)tintColor andTitleColor:(UIColor *)titleColor;

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

        // Default colours
        _navigationBarTintColor = [UIColor colorWithWhite:0 alpha:0.7];
        _navigationBarTitleColor = [UIColor colorWithWhite:1 alpha:0.9];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

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

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.view.layer.zPosition = MAXFLOAT;
    self.view.alpha = 0;
    [keyWindow addSubview:self.view];

    [_collectionView registerClass:[BMMenuItem class] forCellWithReuseIdentifier:@"MenuItem"];

    CGFloat numberOfRows = ceilf([_dataSource numberOfItemsInMenuController:self] / 2.0);
    CGFloat maxHeight = numberOfRows * (self.view.frame.size.width / 2.0 - 30.0) + 1.0;

    self.view.frame = CGRectMake(0, -maxHeight, self.view.frame.size.width, maxHeight);
    _visualEffectView.frame = CGRectMake(0, 0, self.view.frame.size.width, maxHeight);
    _collectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, maxHeight);

    [self.view addSubview:_visualEffectView];

    _navigationBar = navigationBar;

    CGRect visibleFrame = self.view.frame;
    visibleFrame.origin.y = navigationBar.frame.origin.y + navigationBar.frame.size.height;
    [self animateViewToRect:visibleFrame];
    _isVisible = YES;

    [self changeNavigationBarTintColor:_navigationBarTintColor andTitleColor:_navigationBarTitleColor];
}

- (void)dismiss {
    CGRect hiddenFrame = self.view.frame;
    hiddenFrame.origin.y = 0-hiddenFrame.size.height;
    [self animateViewToRect:hiddenFrame];
    _isVisible = NO;

    [self changeNavigationBarTintColor:_originalTintColor andTitleColor:_originalTitleColor];
}

#pragma mark - Animations
- (void)animateViewToRect:(CGRect)rect {
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:10
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         self.view.frame = rect;
                         self.view.alpha = !self.view.alpha;
                     } completion:^(BOOL finished) {
                         // completed
                         if (rect.origin.y < 0) {
                             [_delegate menuControllerDidDismissMenu:self];
                             [self.view removeFromSuperview];
                         }
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

- (void)changeNavigationBarTintColor:(UIColor *)tintColor andTitleColor:(UIColor *)titleColor {

    // Add transition to nav bar
    CATransition *transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.duration = 0.5;
    [_navigationBar.layer addAnimation:transition forKey:nil];

    _navigationBar.barTintColor = tintColor;
    _navigationBar.tintColor = titleColor;

    NSMutableDictionary *textAttribs = [[NSMutableDictionary alloc] initWithDictionary:_navigationBar.titleTextAttributes];
    [textAttribs setObject:titleColor forKey:NSForegroundColorAttributeName];

    [_navigationBar setTitleTextAttributes:textAttribs];
}


#pragma mark - UICollectionView Delegate Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BMMenuItem *item = (BMMenuItem *)[collectionView cellForItemAtIndexPath:indexPath];
    [self animateSelectingItem:item];
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
