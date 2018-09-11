# AEAlertView
Custom AlertView supports multiple modes 自定义AlertView 支持多种模式弹窗 
If your swift version is less than 4, you can   如果你的swift版本是4.0以下, 你可以

pod'AEAlertView','1.0'


![Image text](https://raw.githubusercontent.com/Allen0828/AEAlertView/master/img-folder/11.gif)


代码调用方式 是仿系统的 如果你遇到的需求是 全局使用同样样式的弹窗 你可以封装一个Manger 来管理  代码底层使用VFL 你可以自己修改他的尺寸,

Code calls are system-like if you encounter a requirement that the same style of pop-up windows be used globally you can encapsulate a Manger to manage the underlying code using VFL and you can modify its size yourself.


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
