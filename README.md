# ViewControllerTransition

### 简介

在日常工作中我们通常会遇到,底部弹出view的需求,正常情况我们比较简单的实现方式就是在view层添加一个新的view 然后做一下动画效果,但是如果这个页面可以调到二级页面且二级页面也是半屏的方式展示的,那么我们在使用view的方式局限性就比较多了。

下面我们换个思路通过模拟专场动画的方式来实现这个功能。

### 效果

老规矩,先上效果

![](https://ws1.sinaimg.cn/large/006tKfTcly1g0g5mrm5f7g30b80lwdkk.gif)

在上面的demo中我们简单的实现了简单的 push pop modal dismiss的动画。

### 实现

#### 如何使用

只需要我们在push或者pop操作的时候设置一下代理即可

```objc
- (void)pushToFirst {
    FirstViewController *firstVc = [[FirstViewController alloc] init];
    self.navigationController.delegate = self.delegate;
    [self.navigationController pushViewController:firstVc animated:YES];
}
```

#### 方法分析

第一步中我们遵守了UINavigationController的一个代理协议,下面我们来看一下这个代理中的方法。

下面我们只列出跟动画相关的代理方法

```objc

@optional

// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);

```
可以看到我们在这个方法中可以拿到`fromViewController`和`toViewController` 也就是本次动画是由哪一个页面跳转到哪个页面。operation对应的是这个页面进入时的动画方式(push/pop)

同时,我们可以看到这个代理方法是有返回值的 返回的是一个遵守`UIViewControllerAnimatedTransitioning`协议的对象。

下面我们来看一下这个协议：

```objc


@protocol UIViewControllerAnimatedTransitioning <NSObject>

// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;

@optional

/// A conforming object implements this method if the transition it creates can
/// be interrupted. For example, it could return an instance of a
/// UIViewPropertyAnimator. It is expected that this method will return the same
/// instance for the life of a transition.
- (id <UIViewImplicitlyAnimating>) interruptibleAnimatorForTransition:(id <UIViewControllerContextTransitioning>)transitionContext NS_AVAILABLE_IOS(10_0);

// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL) transitionCompleted;

@end


```
下面我们对这几个方法进行简单的介绍


| 方法名 | 方法说明 |
| --- | --- | 
| transitionDuration | 动画持续时间 |  
| animateTransition | 具体动画的处理(重点方法) |  
| interruptibleAnimatorForTransition |动画被打断时会动画处理(iOS10新增)|
| animationEnded | 动画结束|

这里只有上面两个方法是必须实现的。

下面我们主要看一下我们要实现的主要方法

```objc
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
```
这个方法只有一个参数 `transitionContext`,那么我们看下从这个参数中我们可以获取到哪些内容：

先`UIViewControllerContextTransitioning`这个协议

首先看到的是

```objc
// The view in which the animated transition should take place.
#if UIKIT_DEFINE_AS_PROPERTIES
@property(nonatomic, readonly) UIView *containerView;
#else
- (UIView *)containerView;
#endif
```
通过注释我们了解到 这个协议有一个containerView容器视图,这个视图就是我们UINavigationController的容器视图(可以理解为这是NavigationController.ViewControllers的容器)


接着我们在重点关注一下下面的方法

```objc
// Currently only two keys are defined by the system:
//   UITransitionContextToViewControllerKey
//   UITransitionContextFromViewControllerKey
- (nullable __kindof UIViewController *)viewControllerForKey:(UITransitionContextViewControllerKey)key;

// Currently only two keys are defined by the system:
//   UITransitionContextToViewKey
//   UITransitionContextFromViewKey
- (nullable __kindof UIView *)viewForKey:(UITransitionContextViewKey)key NS_AVAILABLE_IOS(8_0);
```

从这里我们可以清晰的看到,通过这两个方法我们可以拿到执行动画是前后的两个控制器以及控制器的两个view。

#### 具体实现

通过上面我们知道了如果要实现专场动画我们需要实现哪些方法这些方法中我们可以获取到哪些参数。

那么我们下面要做的事情就比较清晰了：
在按到fromViewController和toViewController的基础上我们如何做动画

在回忆下我们的需求：

半屏幕弹出模拟modal/dismiss动画,模拟半屏情况下的push和pop动画。

想必这些简单的frame动画对大家来说都很简单了(没啥追求简单实现动画即可)

demo中动画非常简单 求勿喷！！！！

#### 问题

因为是转场动画结束之后 fromViewController会随着动画的结束而消失,因此我们在modal的时候需要将上一个页面进行截图。一次来模拟后面控制器存在的情况。

这就产生了一个问题 上面的区域无法响应事件,如果你的需求在半屏弹窗弹出的同时需要响应点击事件那么这种方式可能还有问题(还有有解决方案的朋友留言,大家一起完善)

### 总结

通过转场动画的方式实现这种稍微复杂一点的半屏弹窗可以使我们不用因为半屏展示做一些冗余的操作,而且不需要自己去管理多个view把声明周期的管理交还给系统。










