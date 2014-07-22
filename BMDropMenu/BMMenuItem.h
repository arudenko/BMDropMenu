//
//  BMMenuCell.h
//  BMDropMenu
//
//  Created by Adam Eri on 22/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMMenuItem : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *imageView;

/* 
 Instantiate a BMMenuItem object using with provided frameRect.
 
 @param CGRect

 @retun BMMenuItem
*/

- (instancetype)initWithFrame:(CGRect)frameRect;



@end
