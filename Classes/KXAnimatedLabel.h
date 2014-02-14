//
//  KXLabel.h
//  SengokuKareshi
//
//  Created by 桜井雄介 on 2013/02/10.
//  Copyright (c) 2013年 桜井雄介. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KXAnimatedLabel;

/* デリゲート */
@protocol KXAnimatedLabelDelegate <NSObject>
@optional
- (void)labelDidFinishAnimation:(KXAnimatedLabel*)label;
- (void)labelDidTapTwice:(KXAnimatedLabel*)label;

@end

/* 縦揃えの種類 */
typedef enum {
    KXLabelVerticalAlignmentTop = 0,
    KXLabelVerticalAlignmentMiddle,
    KXLabelVerticalAlignmentBottom,
} KXLabelVerticalAlignment;


@interface KXAnimatedLabel : UILabel

/* Delegate */
@property (weak) id<KXAnimatedLabelDelegate> delegate;
/* 縦揃え */
@property () KXLabelVerticalAlignment verticalAlignment;
/* 表示予定の文字 */
@property () NSString *fullText;
/* 現在は表示中か */
@property (readonly) BOOL isAnimating;
/* 現在表示しているのは何文字目か */
@property (readonly) NSInteger currentCharacterIndex;
/* アニメーションの感覚 */
@property (assign) NSTimeInterval duration;

/* すぐにアニメーションを始めるセッタ */
- (void)setFullText:(NSString *)fullText animateImmediately:(BOOL)animate duration:(NSTimeInterval)duration;
/* アニメーションをスタート */
- (void)startAnimation;
/* アニメーションを止める */
- (void)stopAnimation;
/* アニメーション再開 */
- (void)resumeAnimation;
/* アニメーションをスキップ */
- (void)skipAnimation;

@end
