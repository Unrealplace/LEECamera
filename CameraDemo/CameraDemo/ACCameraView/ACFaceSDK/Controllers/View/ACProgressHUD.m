//
//  ACProgressHUD.m
//  ArtCameraPro
//
//  Created by NicoLin on 2017/8/16.
//  Copyright © 2017年 NicoLin. All rights reserved.
//

#import "ACProgressHUD.h"
#import "ACCameraHeader.h"
#import "UIView+ACCameraFrame.h"

@interface NSString (HudSize)
- (CGFloat)widthForFont:(UIFont *)font ;
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode ;
@end

@implementation NSString (HudSize)

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}
- (CGFloat)widthForFont:(UIFont *)font {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}
@end

static NSTimeInterval const NormalAnimationDuration = 0.32f;
static NSTimeInterval const NormalDelayDuration = 1.44f;
static NSTimeInterval const FastAnimationDuration = 0.25f;
static NSTimeInterval const FastDelayDuration = 0.5f;

static NSTimeInterval const SlowAnimationDuration = 0.32f;
static NSTimeInterval const SlowDelayDuration = 2.44f;

@interface ACProgressHUD ()<CAAnimationDelegate>

@property (nonatomic, strong)UILabel * contentsToast;

@property (nonatomic, strong)UIImageView * animateView;

@property (nonatomic, readonly) UIWindow *frontWindow;

@property (nonatomic, assign)ACProgressHUDAnimateEffect animateEffect;

@property (nonatomic, assign)NSTimeInterval animateDuration; //出现消失时间

@property (nonatomic, assign)NSTimeInterval delayDuration; //持续显示时间

@end

@implementation ACProgressHUD

+ (ACProgressHUD*)sharedView {
    static dispatch_once_t once;
    static ACProgressHUD *sharedView;
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:ACCAMERA_SCREEN_BOUNDS]; });
    return sharedView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;

        [self addSubview:self.contentsToast];
        [self addSubview:self.animateView];
        
    }
    return self;
}

- (UILabel *)contentsToast {
    if (!_contentsToast) {
        _contentsToast = [[UILabel alloc] init];
        _contentsToast.ca_size = CGSizeMake(60.0f, 29.0f);
        _contentsToast.center = self.center;
        _contentsToast.backgroundColor = ACCAMERA_RGBAColor(0, 0, 0, 0.7f);
        _contentsToast.layer.cornerRadius = 2.0f;
        _contentsToast.layer.opacity = 0.0f;
        _contentsToast.font =  ACCAMERA_ACFont(12.0f);
        _contentsToast.textColor = [UIColor whiteColor];
        _contentsToast.textAlignment = NSTextAlignmentCenter;
        _contentsToast.userInteractionEnabled = NO;
        _contentsToast.layer.masksToBounds = YES;
    }
    return _contentsToast;
}

- (UIImageView *)animateView {
    if (!_animateView) {
        _animateView = [[UIImageView alloc] init];
        _animateView.ca_size = CGSizeMake(50.0f, 21.0f);
        _animateView.contentMode = UIViewContentModeScaleAspectFill;
        _animateView.center = self.center;
        _animateView.backgroundColor = [UIColor clearColor];
        _animateView.animationImages = [self animationImages]; //获取Gif图片列表        
        _animateView.animationDuration = 1;     //执行一次完整动画所需的时长
//        _animateView.animationRepeatCount = 1;  //动画重复次数
    }
    return _animateView;
}

- (NSArray *)animationImages
{
    NSFileManager *fielM = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Loading" ofType:@"bundle"];
    NSArray *arrays = [[fielM contentsOfDirectoryAtPath:path error:nil] sortedArrayUsingComparator:^NSComparisonResult(NSString *path1, NSString *path2) {
        
        return (NSComparisonResult)[path1 compare:path2 options:NSNumericSearch];
    }];
    
    NSMutableArray *imagesArr = [NSMutableArray array];
    for (NSString *name in arrays) {
        UIImage *image = [UIImage imageNamed:[(@"Loading.bundle") stringByAppendingPathComponent:name]];
        if (image) {
            [imagesArr addObject:image];
        }
    }
    return imagesArr;
}

- (UIWindow *)frontWindow {
#if !defined(SV_APP_EXTENSIONS)
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
        
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported) {
            return window;
        }
    }
#endif
    return nil;
}

- (void)setAnimateEffect:(ACProgressHUDAnimateEffect)animateEffect {
    _animateEffect = animateEffect;
    
    switch (self.animateEffect) {
        case ACProgressHUDAnimateEffectNormal:
            {
                self.animateDuration = NormalAnimationDuration;
                self.delayDuration = NormalDelayDuration;
            }
            break;
        case ACProgressHUDAnimateEffectSlow:
        {
            self.animateDuration = SlowAnimationDuration;
            self.delayDuration = SlowDelayDuration;
        }
            break;
        case ACProgressHUDAnimateEffectFast:
            {
                self.animateDuration = FastAnimationDuration;
                self.delayDuration = FastDelayDuration;
            }
            break;
            
        default:
            break;
    }
//
//    [ACProgressHUD sharedView].contentsToast.pop_duration = self.animateDuration;
//    [ACProgressHUD sharedView].animateView.pop_duration = self.animateDuration;
}

#pragma mark - contents label
+ (void)showWithContents:(NSString *)contents {
    
    [self showWithContents:contents position:[ACProgressHUD sharedView].center];
}

//label显示中心，默认为屏幕中心
+ (void)showWithContents:(NSString *)contents position:(CGPoint)position {
    
    [self showWithContents:contents position:position animateEffect:ACProgressHUDAnimateEffectNormal];
}

+ (void)showWithContents:(NSString *)contents animateEffect:(ACProgressHUDAnimateEffect)animateEffect {
    
    [self showWithContents:contents position:[ACProgressHUD sharedView].center animateEffect:animateEffect];
}

+ (void)showWithContents:(NSString *)contents position:(CGPoint)position animateEffect:(ACProgressHUDAnimateEffect)animateEffect {
    
    [ACProgressHUD sharedView].animateEffect = animateEffect;
    [ACProgressHUD sharedView].contentsToast.text = contents;
    [ACProgressHUD sharedView].contentsToast.ca_width = [contents widthForFont:[ACProgressHUD sharedView].contentsToast.font] + 15.0f * 2;
    [ACProgressHUD sharedView].contentsToast.center = position;

    if (![ACProgressHUD sharedView].superview) {
        [[ACProgressHUD sharedView].frontWindow addSubview:[ACProgressHUD sharedView]];
        [ACProgressHUD sharedView].animateView.alpha = 0.0f;
        
        [UIView animateWithDuration:0.32f animations:^{
            [ACProgressHUD sharedView].contentsToast.layer.opacity = 1.0f;

        } completion:^(BOOL finished) {
            [self addAnimationToToast];
            return ;
        }];
//        [NSObject pop_animate:^{        
//            [ACProgressHUD sharedView].contentsToast.layer.pop_easeInEaseOut.opacity = 1.0f;
//            
//        } completion:^(BOOL finished) {
//            [self addAnimationToToast];
//            return ;
//        }];
    }
    
    [self addAnimationToToast];
}

+ (void)addAnimationToToast {
    //动画
    [[ACProgressHUD sharedView].contentsToast.layer removeAllAnimations];
    CABasicAnimation *toastAnimation      = [CABasicAnimation animationWithKeyPath:@"opacity"];
    toastAnimation.duration                  = [ACProgressHUD sharedView].animateDuration;
    toastAnimation.autoreverses           = NO;
    toastAnimation.repeatCount            = 0.0;
    toastAnimation.removedOnCompletion    = NO;
    toastAnimation.fillMode               = kCAFillModeForwards;
    toastAnimation.beginTime              = CACurrentMediaTime() + [ACProgressHUD sharedView].delayDuration; // 秒后执行
    toastAnimation.toValue                = [NSNumber numberWithFloat:0.0];
    toastAnimation.delegate = [ACProgressHUD sharedView];
    [[ACProgressHUD sharedView].contentsToast.layer addAnimation:toastAnimation forKey:@"animateOpacity"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag && [ACProgressHUD sharedView].superview) {

        [ACProgressHUD sharedView].contentsToast.alpha = 0.0f;
        [ACProgressHUD sharedView].contentsToast.text = nil;
        [ACProgressHUD sharedView].contentsToast.center = [ACProgressHUD sharedView].center;
        [ACProgressHUD sharedView].animateEffect = ACProgressHUDAnimateEffectNormal;
        [[ACProgressHUD sharedView] removeFromSuperview];
    }
}


#pragma mark - animateView
+ (void)showProgress {
    
    [self showProgressWithPosition:[ACProgressHUD sharedView].center allowUserInteraction:YES];
}

+ (void)showProgressWithPosition:(CGPoint)position {
    
    [self showProgressWithPosition:position allowUserInteraction:YES];
}

+ (void)showProgressWithAllowUserInteraction:(BOOL)userInteraction {
    
    [self showProgressWithPosition:[ACProgressHUD sharedView].center allowUserInteraction:userInteraction];
}

+ (void)showProgressWithPosition:(CGPoint)position allowUserInteraction:(BOOL)userInteraction {
    
    if (![ACProgressHUD sharedView].superview) {
        [[ACProgressHUD sharedView].frontWindow addSubview:[ACProgressHUD sharedView]];
    }
    
    [ACProgressHUD sharedView].userInteractionEnabled = !userInteraction;
    [ACProgressHUD sharedView].contentsToast.layer.opacity = 0.0f;
    [ACProgressHUD sharedView].animateView.center = position;
    [ACProgressHUD sharedView].animateView.alpha = 1.0f;
    [[ACProgressHUD sharedView].animateView startAnimating];
}

+ (void)dismissProgress {
 
    if (![ACProgressHUD sharedView].superview) {
        return;
    }
    
    [ACProgressHUD sharedView].userInteractionEnabled = NO;
    [[ACProgressHUD sharedView].animateView stopAnimating];
    [ACProgressHUD sharedView].animateView.alpha = 0.0f;
    [ACProgressHUD sharedView].animateView.center = [ACProgressHUD sharedView].center;
    [[ACProgressHUD sharedView] removeFromSuperview];
}

@end
