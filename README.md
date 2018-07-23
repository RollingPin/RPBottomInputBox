# RPBottomInputBox
一个简易的列表底部输入框, 可实现文字的输入和动态刷新列表
并实现键盘动态控制

# ScreenShot
![image](https://github.com/RollingPin/RPBottomInputBox/blob/master/RPBottomInputBox/RPBottomInputBox/gif_RPBottomInputBox.gif)

# summary

```
@protocol WTBottomInputViewDelegate <NSObject>

-(void)WTBottomInputViewSendTextMessage:(NSString *)message;

@end
```
用于获取输入框当前输入信息,在这个代理方法中处理列表刷新数据
