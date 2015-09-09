# LYDPopView
you can use this popView in iPhone like UIPopoverController in iPad do!

//必须用该方法来返回对象
//you must use this method to init
+(instancetype)LYDPopoverViewWithSize:(CGSize)size andFromView:(CGRect)frame  andDirection:(LYDPopoverViewDirection)direction;
//用该方法来让控件出现在屏幕上
//use this method to show it in screen
-(void)show;
