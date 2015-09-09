//
//  ViewController.m
//  20150904仿popView
//
//  Created by yons on 15-9-4.
//  Copyright (c) 2015年 iron. All rights reserved.
//

#import "ViewController.h"
#import "LYDPopoverView.h"
#define kUIScreenHeight [UIScreen mainScreen].bounds.size.height
#define kUIScreenWidth [UIScreen mainScreen].bounds.size.width
@interface ViewController () <LYDPopoverViewDataSource,LYDPopoverViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor blackColor];
    CGFloat redViewH = 44;
    CGFloat redViewY = kUIScreenHeight - redViewH;

    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, redViewY, kUIScreenWidth, kUIScreenHeight)];
    redView.backgroundColor = [UIColor colorWithRed:246/255.f green:246/255.f blue:246/255.f alpha:1.0];
    [self.view addSubview:redView];
    UIButton *firstBtn = [[UIButton alloc] init];
    [firstBtn setTitle:@"Top" forState:UIControlStateNormal];
    [firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    firstBtn.frame = CGRectMake(0, 0, kUIScreenWidth / 4, redViewH);
    firstBtn.backgroundColor = [UIColor yellowColor];
    [firstBtn addTarget:self action:@selector(firstBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [redView addSubview:firstBtn];
    
    UIButton *seconBtn = [[UIButton alloc] init];
    [seconBtn setTitle:@"Bottom" forState:UIControlStateNormal];
    [seconBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    seconBtn.frame = CGRectMake(kUIScreenWidth / 4, 0, kUIScreenWidth / 4, redViewH);
    seconBtn.backgroundColor = [UIColor yellowColor];
    [seconBtn addTarget:self action:@selector(seconBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [redView addSubview:seconBtn];
    
    UIButton *thirdBtn = [[UIButton alloc] init];
    [thirdBtn setTitle:@"Left" forState:UIControlStateNormal];
    [thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    thirdBtn.frame = CGRectMake(kUIScreenWidth / 2, 0, kUIScreenWidth / 4, redViewH);
    thirdBtn.backgroundColor = [UIColor yellowColor];
    [thirdBtn addTarget:self action:@selector(thirdBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [redView addSubview:thirdBtn];
    
    UIButton *forthBtn = [[UIButton alloc] init];
    [forthBtn setTitle:@"Right" forState:UIControlStateNormal];
    [forthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forthBtn.frame = CGRectMake(kUIScreenWidth - kUIScreenWidth / 4, 0, kUIScreenWidth / 4, redViewH);
    forthBtn.backgroundColor = [UIColor yellowColor];
    [forthBtn addTarget:self action:@selector(forthBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [redView addSubview:forthBtn];
}

- (void)firstBtnDidClick
{

    LYDPopoverView *popView = [LYDPopoverView LYDPopoverViewWithSize:CGSizeMake(kUIScreenWidth / 4, 5 * 44) andFromView:self.btn.frame andDirection:LYDPopoverViewDirectionTop];
    popView.borderColor = [UIColor redColor];
    popView.delegate = self;
    popView.dataSource = self;
    [popView show];
}

- (void)seconBtnDidClick
{
    
    LYDPopoverView *popView = [LYDPopoverView LYDPopoverViewWithSize:CGSizeMake(kUIScreenWidth / 4, 5 * 44) andFromView:self.btn.frame andDirection:LYDPopoverViewDirectionBottom];
    popView.isCornerRadius = YES;
    popView.borderWidth = 1;
    popView.delegate = self;
    popView.dataSource = self;
    [popView show];
}

- (void)thirdBtnDidClick
{
    LYDPopoverView *popView = [LYDPopoverView LYDPopoverViewWithSize:CGSizeMake(kUIScreenWidth / 4, 5 * 44) andFromView:self.btn.frame andDirection:LYDPopoverViewDirectionLeft];
    popView.delegate = self;
    popView.dataSource = self;
    [popView show];
}

- (void)forthBtnDidClick
{
    
    LYDPopoverView *popView = [LYDPopoverView LYDPopoverViewWithSize:CGSizeMake(kUIScreenWidth / 4, 5 * 44) andFromView:self.btn.frame andDirection:LYDPopoverViewDirectionRight];
    popView.delegate = self;
    popView.dataSource = self;
    [popView show];
}

- (NSInteger)numberOfRowsInTable:(LYDPopoverView *)LYDPopoverView
{
    return 10;
}

- (UITableViewCell *)LYDPopoverView:(LYDPopoverView *)LYDPopoverView tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserID = @"lydcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    cell.textLabel.text = @"呵呵";
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
}

- (void)LYDPopoverView:(LYDPopoverView *)LYDPopoverView didSelectRowInMainTable:(NSInteger)row
{

}

@end
