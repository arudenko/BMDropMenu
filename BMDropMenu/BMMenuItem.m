//
//  BMMenuCell.m
//  BMDropMenu
//
//  Created by Adam Eri on 22/07/2014.
//  Copyright (c) 2014 blackmirror media. All rights reserved.
//

#import "BMMenuItem.h"

@implementation BMMenuItem

- (instancetype)initWithFrame:(CGRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {

        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_titleLabel];

        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _titleLabel.frame = CGRectMake(5, 10, self.frame.size.width - 10, 20);

}

- (void)prepareForReuse {

    // Code comes here
    _titleLabel.text = nil;

    [super prepareForReuse];
}

@end
