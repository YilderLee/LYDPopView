//
//  LYDPopoverView.h
//  20150904仿popView
//
//  Created by yons on 15-9-4.
//  Copyright (c) 2015年 iron. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    LYDPopoverViewDirectionBottom,
    LYDPopoverViewDirectionTop,
    LYDPopoverViewDirectionLeft,
    LYDPopoverViewDirectionRight
}LYDPopoverViewDirection;

@class LYDPopoverView;

@protocol LYDPopoverViewDataSource <NSObject>

@optional
/**
 *  行高由代理决定，默认44
 */
- (CGFloat)LYDPopoverView:(LYDPopoverView *)LYDPopoverView tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  表格一共有多少行由代理决定，默认5行
 */
- (NSInteger)numberOfRowsInTable:(LYDPopoverView *)LYDPopoverView;
/**
 *  Cell由代理决定，默认返回带"ha ha"文字的cell
 */
- (UITableViewCell *)LYDPopoverView:(LYDPopoverView *)LYDPopoverView tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol LYDPopoverViewDelegate <NSObject>

@optional
/**
 *  选中cell的回调
 */
- (void)LYDPopoverView:(LYDPopoverView *)LYDPopoverView didSelectRowInTable:(NSInteger)row;

@end

@interface LYDPopoverView : UIView

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, assign) BOOL isCornerRadius;

@property (nonatomic, weak) id<LYDPopoverViewDataSource> dataSource;

@property (nonatomic, weak) id<LYDPopoverViewDelegate> delegate;
//必须用该方法来返回对象
+ (instancetype)LYDPopoverViewWithSize:(CGSize)size andFromView:(CGRect)frame  andDirection:(LYDPopoverViewDirection)direction;
//用该方法来让控件出现在屏幕上
- (void)show;

@end
