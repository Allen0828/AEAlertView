# AEAlertView 
## AEAlertView does not depend on any third-party library
[中文文档](https://github.com/Allen0828/AEAlertView/blob/master/README_CN.md)

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

# AEAlertView currently offers two basic boxes
1. You can manually set two custom views when using the basic `AEAlertview`<br />
2. With UITextField, `AETextFieldAlertView` can only add one custom view call `set (custom: UIView, width: CGFloat, height: CGFloat)` when in use<br />
3. `AEWebAlertView` with WKWebView is not included in the AEAlertView library due to app auditing issues. You can find it in the demo AEWebAlertView.swift<br />

# Development Plan
add 3D model with Metal to AlertView

# Version update information at the bottom

感谢大家反馈 如果你在使用中遇到任何问题、bug、建议等欢迎提交 [点击进入讨论区](https://github.com/Allen0828/AEAlertView/discussions) <br />
Thank you for your feedback. If you encounter any problems, bugs, suggestions, etc. in use, you are welcome to submit them [discussions](https://github.com/Allen0828/AEAlertView/discussions) 


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

# Call method and control description
1. title uses UILabel as the basic control, and can only display two rows by default. If multiple rows need to be displayed, please set the titleNumberOfLines property<br />

2. messages use UITextView as the basic control, and the default display without height will automatically refresh the height based on the content, and it can be selected by long pressing.
Turning off automatic refresh height `alertView.textViewIsScrollEnabled` does not recommend setting this property.<br /> 
If it is set, please remember to set `messageHeight` Turn off the long press to select mode `messageIsSelectable`<br />

3. Customized View call set for contentView `set(content: UIView, width: CGFloat, height: CGFloat)`
If you want the width of the view to be the same as that of the alert during setup, pass in -1 width when calling
The default upper spacing between contentView and message is 0<br />

4. CustomView custom view2 calls `set (custom: UIView, width: CGFloat, height: CGFloat)`
If you want the width of the view to be the same as that of the alert during setup, pass in -1 width when calling
The default upper spacing between customView and contentView is 0<br />

5. `ActionContainerView` is a control used to place buttons. Currently, this control cannot set its own properties and can only set the spacing between the top and bottom.
The default distance between actionContainerView and customView is 10, which can be set by calling `actionViewTopMargin`
The default distance between actionContainerView and the bottom of alert is 0, which can be set by calling `actionViewBottomMargin`<br />


call demo code<br />
The simplest example of calling method, no matter how many buttons there are, the pop-up window will disappear after clicking the button
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

If no frame is selected during init when adding to a custom view, it defaults to the same screen size. Therefore, if you want to add to a custom view, you should pass in the frame during initialization
```swift
func test() {
      // frame 使用了当前view的大小 具体请查看demo
     let alert = AEAlertView.init(frame: view.bounds, style: .defaulted, title: "title", message: "set gif height Add alert to the current view")
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

Custom Button Theme Due to the presence of custom buttons in iOS15, if AEAction cannot meet your needs, you can create your own button and add it to alertView
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

Setting the maximum width for the iPad, AlertView will appear larger if you continue to use the screen width for calculation. Therefore, if you use it on the iPad, you should set its maximum width.
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

# Version Updated Record
v2.3.6-<br />
1: If alertView is set to custom style, action will add stroke and rounded corners by default. Setting action.adapterCustom can be canceled<br />
2: The added content can be set as unselectable. The default is selectable, messageIsSelectable<br />
3: When alertView is initialized, an optional parameter of frame is added. If you need to add alert to a custom view, it is best to pass in a custom size. If not, use the default screen width and height<br />
4: When setting a custom View, the width can be consistent with the width of the parent container, and the width can be read by -1<br />
5: Added some debug log printing<br />

v2.3.5-<br />
Fix the error of getting window if target init OS>12<br />

v2.3.4-<br />
Fixed title not wrapping by default. The number of added title lines can be set.

v2.3.2-<br />
Support setting the maximum width










