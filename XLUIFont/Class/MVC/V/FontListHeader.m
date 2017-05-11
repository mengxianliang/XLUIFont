//
//  FontListHeader.m
//  XLUIFont
//
//  Created by MengXianLiang on 2017/5/11.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "FontListHeader.h"

@implementation FontListHeader{
    UILabel *_textLabel;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    _textLabel = [[UILabel alloc] init];
    _textLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_textLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _textLabel.frame = self.contentView.bounds;
}

#pragma mark -
#pragma mark Setter
-(void)setText:(NSString *)text{
    _textLabel.text = [@"\t" stringByAppendingString:text];
}
-(void)setFont:(UIFont *)font{
    _textLabel.font = font;
}

@end
