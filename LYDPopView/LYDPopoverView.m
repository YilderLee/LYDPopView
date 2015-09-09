//
//  LYDPopoverView.m
//  20150904仿popView
//
//  Created by yons on 15-9-4.
//  Copyright (c) 2015年 iron. All rights reserved.
//

#import "LYDPopoverView.h"
#define kUIScreenHeight [UIScreen mainScreen].bounds.size.height
#define kUIScreenWidth [UIScreen mainScreen].bounds.size.width
@interface LYDPopoverView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) LYDPopoverViewDirection direction;

@property (nonatomic, strong) UIButton *coverBtn;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGRect fromFrame;

@end

@implementation LYDPopoverView

#pragma mark - settet&getter

- (UIButton *)coverBtn
{
    if (_coverBtn == nil) {
        _coverBtn = [[UIButton alloc] init];
        _coverBtn.backgroundColor = [UIColor clearColor];
    }
    return _coverBtn;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
}

- (void)setIsCornerRadius:(BOOL)isCornerRadius
{
    _isCornerRadius = isCornerRadius;
    if (_isCornerRadius == YES) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
}

- (void)setBackgroundView:(UIImageView *)backgroundView
{
    _backgroundView = backgroundView;
    _backgroundView.frame = self.bounds;
    [self addSubview:backgroundView];
}

#pragma mark - 初始化类方法

+ (instancetype)LYDPopoverViewWithSize:(CGSize)size andFromView:(CGRect)frame  andDirection:(LYDPopoverViewDirection)direction
{
    LYDPopoverView *popView = [[self alloc] init];
    popView.direction = direction;
    popView.size = size;
    popView.fromFrame = frame;
    return popView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    _tableView = [[UITableView alloc] init];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _backgroundView.frame = self.bounds;
    _tableView.frame = self.bounds;
    
}

- (void)show
{
    // 获得主窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self.coverBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.coverBtn.frame = CGRectMake(0, 0, kUIScreenWidth, kUIScreenHeight);
    [window addSubview:self.coverBtn];
    
    if (_direction == LYDPopoverViewDirectionTop) {
        self.frame = CGRectMake(_fromFrame.origin.x, _fromFrame.origin.y + _fromFrame.size.height, _size.width, _size.height);
    }
    else if(_direction == LYDPopoverViewDirectionRight)
    {
        self.frame = CGRectMake(_fromFrame.origin.x + _fromFrame.size.width, _fromFrame.origin.y + _fromFrame.size.height * 0.5 - _size.height * 0.5, _size.width, _size.height);
    }
    else if(_direction == LYDPopoverViewDirectionLeft)
    {
        self.frame = CGRectMake(_fromFrame.origin.x - _size.width, _fromFrame.origin.y + _fromFrame.size.height * 0.5 - _size.height * 0.5, _size.width, _size.height);
    }
    else
    {
        self.frame = CGRectMake(_fromFrame.origin.x, _fromFrame.origin.y - _size.height, _size.width, _size.height);
    }
    [window addSubview:self];
}

- (void)dismiss
{
    [self.coverBtn removeFromSuperview];
    [self removeFromSuperview];
    
}
#pragma mark - tableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(LYDPopoverView:tableView:heightForRowAtIndexPath:)]) {
        return [self.dataSource LYDPopoverView:self tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInTable:)]) {
        return [self.dataSource numberOfRowsInTable:self];
    }
        return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataSource respondsToSelector:@selector(LYDPopoverView:tableView:cellForRowAtIndexPath:)])
    {
        UITableViewCell *cell = [self.dataSource LYDPopoverView:self tableView:tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell ==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        cell.textLabel.text = @"haha";
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.delegate respondsToSelector:@selector(LYDPopoverView:didSelectRowInTable:)]) {
        [self.delegate LYDPopoverView:self didSelectRowInTable:indexPath.row];
    }
    [self dismiss];
}

@end
