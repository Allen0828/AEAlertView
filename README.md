# AEAlertView
Custom AlertView supports multiple modes 自定义AlertView 支持多种模式弹窗 
If your swift version is less than 4, you can   如果你的swift版本是4.0以下, 你可以

pod'AEAlertView','1.0'


![Image text](https://raw.githubusercontent.com/Allen0828/AEAlertView/master/img-folder/11.gif)


代码调用方式 是仿系统的 如果你遇到的需求是 全局使用同样样式的弹窗 你可以封装一个Manger 来管理  代码底层使用VFL 你可以自己修改他的尺寸,

Code calls are system-like if you encounter a requirement that the same style of pop-up windows be used globally you can encapsulate a Manger to manage the underlying code using VFL and you can modify its size yourself.

当然你也可以创建一个管理类来保存全局的统一性
``` swift
import UIKit
import AEAlertView

///可以继承自AEAlertView 来保存全局样式统一性
class UserView: AEAlertView {
    
    override init(alertViewStyle: AEAlertViewStyle, title: String?, message: String?) {
        super.init(alertViewStyle: alertViewStyle, title: title, message: message)
        
        buttonColor = UIColor.red
        cancelButtonColor = UIColor.darkGray
        cancelButtonTitleColor = UIColor.white
        
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///也可以写一个快速实现方法
    public func alert(title: String, message: String, actions: [String], handler:((AEAlertAction)->Void)?) {

        self.title = title
        self.message = message
        buttonCornerRadius = 20

        let cancel = AEAlertAction(title: actions[0], style: .Cancel) { (cancel) in
            self.close()
        }
        
        addAction(action: cancel)
        if actions.count > 1 {
            let def = AEAlertAction(title: actions[1], style: .Default) { (action) in
                if handler != nil {
                    handler!(action)
                }
                self.close()
            }
            addAction(action: def)
        }
        show()
    }
    
}
```

如果是局部调用的话 只要简单实现就可以

``` swift
let view = AEAlertView(alertViewStyle: .Default)

view.title = "Title"
view.message = "Message"

let cancel = AEAlertAction(title: "cancel", style: .Cancel) { (action) in
  view.close()
  print("cancel 点击") 
}
view.addAction(action: cancel)
            
let confirm = AEAlertAction(title: "confirm", style: .Default) { (action) in
  print("confirm 点击")
}
view.addAction(action: confirm)

view.show()
```


``` swift
let view = AEAlertView()
view.title = "自定义"
view.message = "自定义距离 颜色 样式 Custom distance color style"
view.titleFont = UIFont.systemFont(ofSize: 20)
view.titleColor = UIColor.blue
view.messageFont = UIFont.systemFont(ofSize: 18)
view.messageColor = UIColor.orange

view.titleTopMargin = 6
view.messageWithButtonMargin = 6

view.cancelButtonColor = UIColor.orange
view.cancelButtonTitleColor = UIColor.white
view.buttonColor = UIColor.red
view.buttonTitleColor = UIColor.white
view.buttonLayerBorderColor = nil     //设置为nil 取消描边


let cancel = AEAlertAction(title: "cancel", style: .Cancel) { (action) in
    view.close()
    print("cancel 点击")
}
view.addAction(action: cancel)

let confirm = AEAlertAction(title: "confirm", style: .Default) { (action) in

    print("confirm 点击")
}
view.addAction(action: confirm)

view.show()
```




``` swift
let view = AEAlertView()
view.title = "Too much content"
view.message = "内容太多时 设置messageHeight 可以让内容超出部分滚动 When messageHeight is too much content, the content can be rolled beyond the part."
view.messageHeight = 100

let cancel = AEAlertAction(title: "cancel", style: .Cancel) { (action) in
    view.close()
    print("cancel 点击")
}
view.addAction(action: cancel)

let confirm = AEAlertAction(title: "confirm", style: .Default) { (action) in

    print("confirm 点击")
}
view.addAction(action: confirm)

view.show()
```

