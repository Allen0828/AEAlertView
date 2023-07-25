# AEAlertView 
## AEAlertView 目前没有使用到任何第三方库

| Swift        |     版本       | 使用版本  |
| ------------- |:-------------:| -----|
| version      | 4.0 and below  | Pod `'AEAlertView','1.0'` |
| version      | 4.0-5.0        | Pod `'AEAlertView','1.7'` |
| version      | 5.0+           | Pod `'AEAlertView'` |

<font>
     <p>在使用前请先阅读本文档</p>
     <p>在使用过程中如果有任何问题可以直接提 issues</p>
     <p>建议先看看 AlertViewDemo 中的代码，在demo中各种用法都有</p>
</font>

AEAlertView 支持所有控件的左右上下间距
对所有控件都设置为public 你也可以按照自己的需要来自定义你的alertView

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

# 简单使用
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

# 添加到自定义的view上
```swift
func test() {
     let alert = AEAlertView.init(style: .defaulted, title: "title", message: "set gif height Add alert to the current view")
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

     self.view.addSubview(alert)
}
```

# 自定义按钮主题
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
# 设置最大宽度
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











