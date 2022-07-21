# AEAlertView 
## AEAlertView does not depend on any third-party library
[中文文档](https://blog.csdn.net/weixin_40085372/article/details/82623978)

| Swift        |     range       | use  |
| ------------- |:-------------:| -----|
| version      | 4.0 and below  | Pod `'AEAlertView','1.0'` |
| version      | 4.0-5.0        | Pod `'AEAlertView','1.7'` |
| version      | 5.0+           | Pod `'AEAlertView'` |

<font>
     <p>Please read the instructions before using it.</p>
     <p>If you have any problems, please send emails or submit Issues at any time. Thank you very much.</p>
     <p>It is recommended to download AlertViewDemo first, and check the specific usage method.</p>
</font>


# Version 2.3 is updated


<font color=#ff6666>
     <p>2.3 Updates</p>
     <p>Multiple lines of text can be used for buttons, pictures can be set, and pictures can be arranged left and right (Tips: If the height of the button is not set, it will be used uniformly according to the maximum height of the text)</p>
     <p>The previous button attribute setting on alertView is abolished, please use `AEAlertAction` directly for button attribute. </p>
     <p>Add 'public func create() {}' if you don't need to display on UIWindow you can call 'create()' after configuration to add alert to the view you need to add.
     <p>`AEAlertAction` currently only supports 2 display modes `defaulted, cancel`.</p> 
     <p>All setting properties are done in action. If you don't want to use cancel, you can set all action to defaulted.</p>
</font>
     
     v2.3.2- Support setting the maximum width
     v2.3.4- Fix the problem that the title does not wrap lines by default. The number of Title lines can be set use.
                                                                         
  
感谢大家反馈 如果你在使用中遇到任何问题、bug、建议等欢迎提交 [点击进入讨论区](https://github.com/Allen0828/AEAlertView/discussions) 

Thank you for your feedback. If you encounter any problems, bugs, suggestions, etc. in use, you are welcome to submit them [discussions](https://github.com/Allen0828/AEAlertView/discussions) 


# Preview                                                                       

# 2.3
<view><img src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/2.3-001.jpg" width="100"></img><img
src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/2.3-002.jpg" width="100"></img> <img
src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/2.3-003.jpg" width="100"></img>
</view>

# 2.2
<view><img src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/new3.jpeg" width="100"></img><img
src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/gif003.gif" width="100"></img> <img
src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/new7.jpeg" width="100"></img>
</view>

# 2.1 
<view><img src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/succees2.1.gif" width="100"></img><img src="https://github.com/Allen0828/AEAlertView/blob/master/img-folder/error2.1.gif" width="100"></img>
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

-------------------
*** 控件支持 设置左右 上下间距  本来想提供 类方法来一句话调用, 但是每个项目的主题色不同 所有需要你 自己设置自己的主题色***









