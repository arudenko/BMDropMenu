//
//  BMMenuCell.h
//  BMDropMenu
//
//  Created by Adam Eri on 22/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMMenuItem : UICollectionViewCell

/* 
 Instantiate a BMMenuItem object using the title and icon provided.
 
 @param NSSting title
 @param UIImage icon
 
 @retun BMMenuItem
*/
- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon;

@end
