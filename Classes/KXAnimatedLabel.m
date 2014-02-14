//
//  KXLabel.m
//  SengokuKareshi
//
//  Created by 桜井雄介 on 2013/02/10.
//  Copyright (c) 2013年 桜井雄介. All rights reserved.
//

#import "KXAnimatedLabel.h"

@interface KXAnimatedLabel ()
{
    // アニメーション用のタイマー
    NSTimer *_timer;
}
/* プライベートイニシャライザ */
- (void)_commonInit;
/* アニメーションコールバック */
- (void)_addCharacter;
/* アニメーションフィニッシャ */
- (void)_finishAnimation;
@end

@implementation KXAnimatedLabel

@synthesize verticalAlignment = _verticalAlignment;
@synthesize fullText = _fullText;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _commonInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _commonInit];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case KXLabelVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case KXLabelVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case KXLabelVerticalAlignmentMiddle:
        default:
            // 中央揃え
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

#pragma mark - Public

- (void)startAnimation
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(_addCharacter) userInfo:nil repeats:YES];
    [_timer fire];
    _isAnimating = YES;
}

- (void)stopAnimation
{
    [_timer invalidate];
}

- (void)resumeAnimation
{
    [_timer fire];
}

- (void)skipAnimation
{
    [self _finishAnimation];
    [self setText:_fullText];
}

#pragma mark - Private

- (void)_commonInit
{
    _fullText = @"";
    _isAnimating = NO;
    _currentCharacterIndex = 0;
    [self setVerticalAlignment:KXLabelVerticalAlignmentTop];
    [self setLineBreakMode:NSLineBreakByCharWrapping];
    [self setUserInteractionEnabled:YES];
}

- (void)_addCharacter
{
    _currentCharacterIndex++;
    if (_currentCharacterIndex > [_fullText length]) {
        [self _finishAnimation];
        return;
    }
    NSRange r = NSMakeRange(0, _currentCharacterIndex);
    NSString *s = [_fullText substringWithRange:r];
    [self setText:s];
}

- (void)_finishAnimation
{
    [_timer invalidate];
    _isAnimating = NO;
    _currentCharacterIndex = 0;
    if ([_delegate respondsToSelector:@selector(labelDidFinishAnimation:)]) {
        [_delegate labelDidFinishAnimation:self];
    }
}

#pragma mark - Accessors

- (NSString *)fullText
{
    return _fullText;
}

- (void)setFullText:(NSString *)fullText
{
    _fullText = fullText;
    [self _finishAnimation];
}

- (void)setFullText:(NSString *)fullText animateImmediately:(BOOL)animate duration:(NSTimeInterval)duration
{
    _duration = duration;
    [self setFullText:fullText];
    if (animate) {
        [self startAnimation];
    }
}

- (KXLabelVerticalAlignment)verticalAlignment
{
    return _verticalAlignment;
}

- (void)setVerticalAlignment:(KXLabelVerticalAlignment)verticalAlignment
{
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

#pragma mark - UIResponder

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isAnimating) {
        // アニメーション中はスキップ
        [self skipAnimation];
    }else{
        // 非アニメーション中はdelegateに通知して新しいテキストをもらう
        if ([_delegate respondsToSelector:@selector(labelDidTapTwice:)]) {
            [_delegate labelDidTapTwice:self];
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
