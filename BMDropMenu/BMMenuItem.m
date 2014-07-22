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
        _titleLabel.textColor = [UIColor colorWithWhite:1 alpha:0.7];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;

        [self.contentView addSubview:_titleLabel];

        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.alpha = 0.9;

        [self.contentView addSubview:_imageView];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _titleLabel.frame = CGRectMake(5, self.frame.size.height - 40, self.frame.size.width - 10, 20);

    CGFloat imageSize = 55.0;
    _imageView.frame = CGRectMake(self.frame.size.width / 2 - imageSize / 2, 25, imageSize, imageSize);
}

- (void)prepareForReuse {

    _titleLabel.text = nil;
    _imageView.image = nil;

    [super prepareForReuse];
}

@end
