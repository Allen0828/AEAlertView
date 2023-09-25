# AEAlertView 
## AEAlertView 目前没有使用到任何第三方库

## 安装指南

- 从Xcode15.0 开始，要求库的最低版本为iOS12.0，因此AEAlertView在2.3.8中最低支持的版本为iOS12.0， 如果你的项目中兼容12以下，请使用2.3.6

>
> | UIKit | SwiftUI | Xcode | AEAlertView |
> |---|---|---|---|
> | iOS 8+ | iOS 13+ | 12.0 | ~> 1.0 |
> | iOS 11+ | iOS 13+ | 13.0 | ~> 1.7 |
> | iOS 12+ | iOS 14+ | 13.0 | ~> 2.0 |
> | iOS 12+ | iOS 12+ | 15.0 | ~> 2.3.8 |

#### Swift Package Manager

- File > Swift Packages > Add Package Dependency
- Add `https://github.com/Allen0828/AEAlertView.git`
- Select "Up to Next Major" with "2.3.8"

#### CocoaPods
```ruby
source 'https://cdn.cocoapods.org/'
platform :ios, '12.0'
use_frameworks!

target 'MyApp' do
  pod 'AEAlertView', '~> 2.3.8'
end
```

<font>
     <p>在使用前请先阅读本文档</p>
     <p>在使用过程中如果有任何问题可以直接提 issues</p>
     <p>建议先看看 AlertViewDemo 中的代码，在demo中各种用法都有</p>
</font>

AEAlertView 支持所有控件的左右上下间距
对所有控件都设置为public 你也可以按照自己的需要来自定义你的alertView

# AEAlertView 目前提供了两种基础框 
1 基础的alertview 你可以在使用时，手动设置两个自定义view<br />
2 带有UITextField `AETextFieldAlertView` 在使用时只能添加一个自定义view 调用 `set(custom: UIView, width: CGFloat, height: CGFloat)`<br />
3 带有WKWebView的 `AEWebAlertView` 考虑到app审核问题，此功能不在AEAlertView 库中。你可以在demo中找到它 `AEWebAlertView.swift`<br />

# 开发计划
后续会添加 3D模型展示到Alert中


# Preview                                                                       

# 2.3
<view><img src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/2.3-001.jpg" width="100"></img><img
src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/2.3-002.jpg" width="100"></img> <img
src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/2.3-003.jpg" width="100"></img>
</view>

# 2.2
<view>

<img src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/new3.jpeg" width="100"></img><img
src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/gif003.gif" width="100"></img> <img
src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/new7.jpeg" width="100"></img>

</view>

# other 
<view>

<img src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/new1.jpeg" width="150"></img>
<img src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/succees2.1.gif" width="150"></img>
<img src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/uiAlertView_GIF.gif" width="150"></img>

</view>

# 如果有 你有任何问题 或者 好的建议 欢迎联系我  - email: allen.zhang0828@gmail.com -


# 调用方式和控件说明
1 title 使用UILabe 作为基础控件，默认只能显示两行，如果需要显示多行请设置`titleNumberOfLines` 属性<br />

2 message 使用UITextView 作为基础控件，默认无高度显示会根据内容自动刷新高度，并且默认是可长按选中的。<br />
    关闭自动刷新高度`alertView.textViewIsScrollEnabled` 不推荐设置此属性，如果设置了请记得设置`messageHeight`.<br />
    关闭长按可选中模式`messageIsSelectable` <br /> 
    
3 contentView 自定义的View 调用`set(content: UIView, width: CGFloat, height: CGFloat)`<br />
    如果在设置时希望view的宽度和alert同宽，在调用时 width 传入 -1<br />
    contentView 默认和 message 的上间距是0<br />
    
4 customView 自定义view2 调用`set(custom: UIView, width: CGFloat, height: CGFloat)`<br />
    如果在设置时希望view的宽度和alert同宽，在调用时 width 传入 -1<br />
    customView 默认和 contentView 的上间距是0<br />
    
5 actionContainerView 用于放置按钮的控件，目前该控件不能设置自身属性，只能设置上下的间距。<br />
    actionContainerView 默认和 customView 的上间距是 10 可以调用`actionViewTopMargin` 来设置<br />
    actionContainerView 默认和alert 底部的间距是 0  可以调用`actionViewBottomMargin` 来设置<br />



最简单的调用方式实例，此方法无论按钮有几个，在点击按钮后弹窗都会消失
```swift
func test() {
    AEAlertView.show(title: "title", message: "fastest", actions: ["ok"]) { action in
        print("dismiss----Fastest")
    }
    // set background image
    AEAlertView.show(title: "title", message: "set background image", actions: ["cancel", "ok"], bgImage: UIImage(named: "006")) { action in
        print("dismiss----background")
    }
}
```

添加到自定义的view上 如果在init时没有选择传入frame 默认是和屏幕size一致，因此如果你想添加到自定义view上 应该在初始化时传入frame
```swift
func test() {
    // frame 使用了当前view的大小 具体请查看demo
    let alert = AEAlertView.init(frame: view.bounds, style: .defaulted, title: "title", message: "set gif height Add alert to the current view")
    alert.setBackgroundImage(contentsOf: Bundle.main.path(forResource: "003", ofType: "gif"))
    alert.messageHeight = 250
    
    alert.messageColor = UIColor.red
    let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
        alert.dismiss()
    }
    cancel.cancelTitleColor = .red
    alert.addAction(action: cancel)
    alert.create()

    view.addSubview(alert)
}
```

自定义按钮主题  由于iOS15中 出现了自定义Button 因此如果AEAction不能满足你的需求，你可以自己创建button 并添加到alertView中
```swift
func test() {
        let alert = AEAlertView(style: .defaulted, title: "custom action", message: "Please check the default values before using")
        let cancel = AEAlertAction.init(title: "cancel\rcancel\rcancel", style: .cancel) { (action) in
            alert.dismiss()
        }
        cancel.cancelTitleColor = UIColor.red
        cancel.numberOfLines = 0
        
        let dev = AEAlertAction.init(title: "dev", style: .defaulted) { (action) in
           
        }
        dev.image = UIImage(named: "index_def_icon")
//        dev.imagePlacement = .right
        
        alert.addAction(action: cancel)
        alert.addAction(action: dev)
        alert.show()
}
```

设置最大宽度  对于ipad 而言，alertView如果继续使用屏幕宽度来计算 会显的很大，因此如果你在ipad中使用时，应该设置它的最大宽度。
```swift
private func alertType3() {
  let alert = AEAlertView.init(style: .defaulted, title: "title", message: "set gif height Add alert to the current view", maximumWidth: 600)
  alert.setBackgroundImage(contentsOf: Bundle.main.path(forResource: "003", ofType: "gif"))
        
  alert.backgroundImageHeight = 300
  alert.messageColor = UIColor.red
  let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
       print("\(action.tag)")
      alert.dismiss()
  }
  cancel.cancelTitleColor = .red
        
  alert.addAction(action: cancel)
  alert.create()
        
  view.addSubview(alert)
}
```





