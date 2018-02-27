//
//  CMTextView.m
//  CMInputView
//
//  Created by CrabMan on 16/9/9.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "CMInputView.h"

@interface CMInputView ()<UITextViewDelegate>
/**
 *  UITextView作为placeholderView，使placeholderView等于UITextView的大小，字体重叠显示，方便快捷，解决占位符问题.
 */
@property (nonatomic, weak) UILabel *placeholderView;

/**
 *  文字高度
 */
@property (nonatomic, assign) NSInteger textH;

/**
 *  文字最大高度
 */
@property (nonatomic, assign) NSInteger maxTextH;


@end

@implementation CMInputView

- (void)textValueDidChanged:(CM_textHeightChangedBlock)block{
    
    _textChangedBlock = block;

}
- (UILabel *)placeholderView
{
    if (!_txtStr) {
        if (!_placeholderView ) {
            UILabel *placeholderView = [[UILabel alloc] initWithFrame:self.bounds];
            _placeholderView = placeholderView;
            //防止textView输入时跳动问题
            //        _placeholderView.scrollEnabled = NO;
            //        _placeholderView.showsHorizontalScrollIndicator = NO;
            //        _placeholderView.showsVerticalScrollIndicator = NO;
            _placeholderView.userInteractionEnabled = NO;
            _placeholderView.font =  self.font;
            _placeholderView.textColor = [UIColor lightGrayColor];
            _placeholderView.backgroundColor = [UIColor clearColor];
            
            [self addSubview:placeholderView];
        }

    }
       return _placeholderView;
}

- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines
{
    _maxNumberOfLines = maxNumberOfLines;
    
    /**
     *  根据最大的行数计算textView的最大高度
     *  计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
     */
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    
}

- (void)setCornerRadius:(NSUInteger)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

/**
 *  通过设置placeholder设置私有属性placeholderView中的textColor
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderView.textColor = placeholderColor;
}
/**
 *  通过设置placeholder设置私有属性placeholderView中的textColor
 */
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderView.text = placeholder;
}
/**
 *  通过设置_placeholderFont设置私有属性placeholderView中的Font
*/
- (void)setPlaceholderFont:(UIFont *)placeholderFont {

    _placeholderFont = placeholderFont;
    
    self.placeholderView.font = placeholderFont;
}

-(void)setTxtStr:(NSString *)txtStr {
    _txtStr = txtStr;
    self.text = txtStr;
    self.textColor = kBlackTextColor;
  
//    [self contentSizeToFit];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self.delegate = self;
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    self.returnKeyType =UIReturnKeyDone;
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //实时监听textView值得改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

- (void)textDidChange
{
    // 根据文字内容决定placeholderView是否隐藏
    self.placeholderView.hidden = self.text.length > 0;
    
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (_textH != height) { // 高度不一样，就改变了高度
        
        // 当高度大于最大高度时，需要滚动
        self.scrollEnabled = height > _maxTextH && _maxTextH > 0;
        
        _textH = height;
        
        //当不可以滚动（即 <= 最大高度）时，传值改变textView高度
        if (_textChangedBlock && self.scrollEnabled == NO) {
            _textChangedBlock(self.text,height);
            
            [self.superview layoutIfNeeded];
            self.placeholderView.frame = self.bounds;

        }
    }
    [self contentSizeToFit];
}

- (void)contentSizeToFit {
    //先判断一下有没有文字（没文字就没必要设置居中了）
    if([self.text length]>0) {
        //textView的contentSize属性
        CGSize contentSize = self.contentSize;
        //textView的内边距属性
        UIEdgeInsets offset; CGSize newSize = contentSize;
        //如果文字内容高度没有超过textView的高度
        if(contentSize.height <= self.frame.size.height) {
            //textView的高度减去文字高度除以2就是Y方向的偏移量，也就是textView的上内边距
            CGFloat offsetY = (self.frame.size.height - contentSize.height)/2;
            offset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
        } else
                //如果文字高度超出textView的高度
            {
                newSize = self.frame.size; offset = UIEdgeInsetsZero;
                CGFloat fontSize = 14;
                //通过一个while循环，设置textView的文字大小，使内容不超过整个textView的高度（这个根据需要可以自己设置）
                while (contentSize.height > self.frame.size.height) {
                    [self setFont:[UIFont fontWithName:@"Helvetica Neue" size:fontSize--]];
                    contentSize = self.contentSize;
                }
                newSize = contentSize;
            }
        //根据前面计算设置textView的ContentSize和Y方向偏移量
        [self setContentSize:newSize];
        [self setContentInset:offset];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [self resignFirstResponder];
    return YES;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
