# AEAlertView
Custom AlertView supports multiple modes 自定义AlertView 支持多种模式弹窗 
If your swift version is less than 4, you can   如果你的swift版本是4.0以下, 你可以

pod'AEAlertView','1.0'

以支持 swift 5.0 如果有什么问题 请联系我 我会及时回复  

2.0.1 新增 UIAlertView  并且将baseView开放出来， 如果你有特殊需求可直接继承 AEBaseAlertView 更能完善你的弹窗。
在所以弹窗类型中添加了 textfield类型 具体可以看演示代码 下面放上图

![Image text](https://raw.githubusercontent.com/Allen0828/AEAlertView/master/img-folder/11.gif)

![Image text](https://github.com/Allen0828/AEAlertView/blob/master/img-folder/001.jpeg) ![Image text](https://github.com/Allen0828/AEAlertView/blob/master/img-folder/002.jpeg)


代码调用方式 是仿系统的 如果你遇到的需求是 全局使用同样样式的弹窗 你可以封装一个Manger 来管理  代码底层使用VFL 你可以自己修改他的尺寸,

Code calls are system-like if you encounter a requirement that the same style of pop-up windows be used globally you can encapsulate a Manger to manage the underlying code using VFL and you can modify its size yourself.

当然你也可以创建一个管理类来保存全局的统一性 并且提供快速调用类方法
``` swift
import UIKit
import AEAlertView

class AlertView: AEAlertView {
    
    ///MARK: 快速调用
    public class func alert(_ title: String, _ message: String, _ actions:[String], handler:((AEAlertAction)->Void)?) {
        
        let alertView = AlertView()
        alertView.title = title
        alertView.message = message
        
        let cancel = AEAlertAction(title: actions[0], style: .Cancel) { (action) in
            print("取消")
            alertView.close()
        }
        alertView.addAction(action: cancel)
        
        if actions.count > 1 {
            let def = AEAlertAction(title: actions[1], style: .Default) { (action) in
                if handler != nil {
                    handler!(action)
                }
                alertView.close()
            }
            alertView.addAction(action: def)
        }
        
        alertView.show()
    }

    
    override init(alertViewStyle: AEAlertViewStyle, title: String?, message: String?) {
        super.init(alertViewStyle: alertViewStyle, title: title, message: message)
        
        self.buttonColor = UIColor.red
        self.cancelButtonColor = UIColor.white
        self.cancelButtonLayerBorderColor = UIColor.red
        self.cancelButtonTitleColor = UIColor.red
        self.titleTopMargin = 16
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
```

在外部调用示例
``` swift
AlertView.alert("提示", "是否去分享", ["取消","确认"]) { (action) in
            print("确认")
        }
```

复制代码看看效果吧


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

