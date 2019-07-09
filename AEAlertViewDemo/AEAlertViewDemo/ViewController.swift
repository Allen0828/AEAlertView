//
//  ViewController.swift
//  AEAlertViewDemo
//
//  Created by Allen on 2018/9/10.
//  Copyright © 2018年 Allen. All rights reserved.
//

import UIKit
import AEAlertView

// MARK: 继承UI样式的AlertView
class uiAlertView: AEUIAlertView {
    
    override init(alertViewStyle: AEAlertViewStyle, title: String?, message: String?) {
        super.init(alertViewStyle: alertViewStyle, title: title, message: message)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 继承普通样式的AlertView
class alertView: AEAlertView {
    
    // 在init 方法中 设置初始位置 按钮颜色 主题颜色等
    override init(alertViewStyle: AEAlertViewStyle, title: String?, message: String?) {
        super.init(alertViewStyle: alertViewStyle, title: title, message: message)
        
        // demo中 默认 取消为蓝色 确定为红色
        cancelButtonLayerBorderColor = UIColor.blue
        cancelButtonTitleColor = UIColor.blue
        
        buttonTitleColor = UIColor.red
        buttonLayerBorderColor = UIColor.red
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class ViewController: UIViewController {
    
    let types = ["普通样式", "UI普通样式",
                 "修改控件位置", "UI修改控件位置",
                 "textFlied", "UItextFlied",
                 "自定义Content", "UI自定义Content",
                 "内容超出", "UI内容超出"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var btnX: CGFloat = 10
        var btnY: CGFloat = 60
        let btnW: CGFloat = (UIScreen.main.bounds.size.width -  30) / 2
        let btnH: CGFloat = 40
        for (index, item) in types.enumerated() {
            let btn = UIButton(frame: CGRect(x: btnX, y: btnY, width: btnW, height: btnH))
            btn.setTitle(item, for: .normal)
            btn.tag = index
            
            if index % 2 == 0 {
                btnX = btnW + 10
                btn.backgroundColor = UIColor.red
            } else {
                btnY += 50
                btnX = 10
                btn.backgroundColor = UIColor.blue
            }
            btn.addTarget(self, action: #selector(typeButtonClick), for: .touchUpInside)
            
            view.addSubview(btn)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension ViewController {
    
    @objc private func typeButtonClick(btn: UIButton) {
        if btn.tag % 2 == 0 {
            alertViewShowType(tag: btn.tag)
        } else {
            uiAlertViewShowType(tag: btn.tag)
        }
    }

    private func alertViewShowType(tag: Int) {
        
        let view = alertView(alertViewStyle: .Default, title: nil, message: nil)
        
        var title = "这是默认的"
        var message = "内容默认的样式"
        
        
        if tag == 2 {
            title = "修改控件位置"
            message = "修改控件位置后的样式"
            // 修改title 顶部距离
            view.titleTopMargin = 8
            // 内容距离 title
            view.messageTopMargin = 2
            // 内容距离下方按钮位置
            view.messageWithButtonMargin = 0
        } else if tag == 4 {
            // 有输入框的情况下 需要重新创建 alertViewStyle 必须在初始化时就设置好
            let textView = alertView(alertViewStyle: .TextField, title: "自定义", message: "自定义的样式")
            textView.titleTopMargin = 13
            textView.messageWithButtonMargin = 4
            
            textView.textField.placeholder = "自定义"
            textView.textFieldLeftView = UIView(frame: CGRect(x: 6, y: 0, width: 10, height: 10))
            textView.textFieldRadius = 6
            
            // 设置按钮竖排展示
            textView.buttonArrangement = .Vertical
            
            let action_one = AEAlertAction(title: "取消", style: .Cancel) { (action) in
                textView.close()
            }
            let action_two = AEAlertAction(title: "知道了", style: .Default) { (action) in
                print("输入框的文字是----\(textView.textFieldText ?? "")")
            }
            
            let action_t = AEAlertAction(title: "测试3个按钮", style: .Default) { (action) in
                print("输入框的文字是----\(textView.textFieldText ?? "")")
            }
            textView.addAction(action: action_one)
            textView.addAction(action: action_two)
            textView.addAction(action: action_t)
            textView.show()
            
            return
        } else if tag == 6 {
            // 先定义宽度 如果没有给AlertView 设置过宽度 默认弹窗框的宽度是 UIScreen.main.bounds.size.width - (38 * 2)
            
            let width = UIScreen.main.bounds.size.width - (38 * 2)
            // 自定义 content
            let content = UIView()
            content.backgroundColor = UIColor.orange
            
            let label = UILabel(frame: CGRect(x: 8, y: 0, width: width - 16, height: 30))
            label.text = "可以自定义密码框: 再次确认密码"
            
            let label1 = UILabel(frame: CGRect(x: 8, y: 38, width: width - 16, height: 30))
            label1.text = "也可以自定义你想要的内容: 比如图片"
            
            let label2 = UILabel(frame: CGRect(x: 8, y: 76, width: width - 16, height: 50))
            label2.text = "注意: 使用了自定义Content, 就不能使用TextFelid样式, 因为它使用的就是contentView 你可以在自定义的View 自己添加"
            label2.font = UIFont.systemFont(ofSize: 10)
            label2.numberOfLines = 3
            
            content.addSubview(label)
            content.addSubview(label1)
            content.addSubview(label2)
            
            title = "自定义"
            message = "可以选择要不要内容"
            
            // 使用默认的宽
            view.setContentView(contentView: content, width: width, height: 136)
            
            /// 可以设置 控件位置
            title = "不要内容,自定义位置"
            message = ""
            view.titleTopMargin = 12
            view.messageWithButtonMargin = 0
            view.messageTopMargin = 0
            view.contentViewTopMargin = 0
            
        } else if tag == 8 {
            // 内容过多
            title = "内容过多 并且不设置内容高度 "
            message = "臣本布衣，躬耕于南阳，苟全性命于乱世，不求闻达于诸侯。先帝不以臣卑鄙，猥自枉屈，三顾臣于草庐之中，咨臣以当世之事，由是感激，遂许先帝以驱驰。后值倾覆，受任于败军之际，奉命于危难之间，尔来二十有一年矣。         \r\r先帝知臣谨慎，故临崩寄臣以大事也。受命以来，夙夜忧叹，恐托付不效，以伤先帝之明；故五月渡泸，深入不毛。今南方已定，兵甲已足，当奖率三军，北定中原，庶竭驽钝，攘除奸凶，兴复汉室，还于旧都。此臣所以报先帝而忠陛下之职分也。至于斟酌损益，进尽忠言，则攸之、祎、允之任也。 \r\r愿陛下托臣以讨贼兴复之效，不效，则治臣之罪，以告先帝之灵。若无兴德之言，则责攸之、祎、允等之慢，以彰其咎；陛下亦宜自谋，以咨诹善道，察纳雅言，深追先帝遗诏。臣不胜受恩感激。 \r\r今当远离，临表涕零，不知所言。"
            
            // 设置内容最大高度 如果超出 可以滑动
            title = "设置了内容最大高度"
            
            view.messageHeight = 300
            
        }
        
        
        view.title = title
        view.message = message
        
        let action_one = AEAlertAction(title: "取消", style: .Cancel) { (action) in
            view.close()
        }
        let action_two = AEAlertAction(title: "知道了", style: .Default) { (action) in
            
        }
        view.addAction(action: action_one)
        view.addAction(action: action_two)
        view.show()
    }
    
    private func uiAlertViewShowType(tag: Int) {
        let view = uiAlertView(alertViewStyle: .Default)
        
        var title = "这是默认的"
        var message = "内容默认的样式"
        
        if tag == 3 {
            title = "修改控件位置"
            message = "修改控件位置后的样式"
            
            // 修改title 顶部距离
            view.titleTopMargin = 8
            // 内容距离 title
            view.messageTopMargin = 2
            // 内容距离下方按钮位置
            view.messageWithButtonMargin = 0
        } else if tag == 5 {
            // 有输入框的情况下 需要重新创建 alertViewStyle 必须在初始化时就设置好
            let textView = uiAlertView(alertViewStyle: .TextField, title: "自定义", message: "自定义的样式")
            textView.titleTopMargin = 13
            
            textView.textField.placeholder = "自定义"
            textView.textFieldLeftView = UIView(frame: CGRect(x: 6, y: 0, width: 10, height: 10))
            textView.textFieldRadius = 6
            
            // 可以设置 按钮竖排显示
            textView.buttonArrangement = .Vertical
            
            let action_one = AEAlertAction(title: "取消", style: .Cancel) { (action) in
                textView.close()
            }
            let action_two = AEAlertAction(title: "知道了", style: .Default) { (action) in
                print("输入框的文字是----\(textView.textFieldText ?? "")")
            }
            let action_t = AEAlertAction(title: "测试3个按钮", style: .Default) { (action) in
                print("输入框的文字是----\(textView.textFieldText ?? "")")
            }
            textView.addAction(action: action_one)
            textView.addAction(action: action_two)
            textView.addAction(action: action_t)
            textView.show()
            
            return
        } else if tag == 7 {
            // 先定义宽度 如果没有给AlertView 设置过宽度 默认弹窗框的宽度是 UIScreen.main.bounds.size.width - (38 * 2)
            
            let width = UIScreen.main.bounds.size.width - (38 * 2)
            // 自定义 content
            let content = UIView()
            content.backgroundColor = UIColor.orange
            
            let label = UILabel(frame: CGRect(x: 8, y: 0, width: width - 16, height: 30))
            label.text = "可以自定义密码框: 再次确认密码"
            
            let label1 = UILabel(frame: CGRect(x: 8, y: 38, width: width - 16, height: 30))
            label1.text = "也可以自定义你想要的内容: 比如图片"
            
            let label2 = UILabel(frame: CGRect(x: 8, y: 76, width: width - 16, height: 50))
            label2.text = "注意: 使用了自定义Content, 就不能使用TextFelid样式, 因为它使用的就是contentView 你可以在自定义的View 自己添加"
            label2.font = UIFont.systemFont(ofSize: 10)
            label2.numberOfLines = 3
            
            content.addSubview(label)
            content.addSubview(label1)
            content.addSubview(label2)
            
            title = "自定义"
            message = "可以选择要不要内容"
            
            // 使用默认的宽
            view.setContentView(contentView: content, width: width, height: 136)
            
            /// 可以设置 控件位置
            title = "不要内容,自定义位置"
            message = ""
            view.titleTopMargin = 12
            view.messageWithButtonMargin = 0
            view.messageTopMargin = 0
            view.contentViewTopMargin = 0
        } else if tag == 9 {
            // 内容过多
            title = "内容过多 并且不设置内容高度 "
            message = "臣本布衣，躬耕于南阳，苟全性命于乱世，不求闻达于诸侯。先帝不以臣卑鄙，猥自枉屈，三顾臣于草庐之中，咨臣以当世之事，由是感激，遂许先帝以驱驰。后值倾覆，受任于败军之际，奉命于危难之间，尔来二十有一年矣。         \r\r先帝知臣谨慎，故临崩寄臣以大事也。受命以来，夙夜忧叹，恐托付不效，以伤先帝之明；故五月渡泸，深入不毛。今南方已定，兵甲已足，当奖率三军，北定中原，庶竭驽钝，攘除奸凶，兴复汉室，还于旧都。此臣所以报先帝而忠陛下之职分也。至于斟酌损益，进尽忠言，则攸之、祎、允之任也。 \r\r愿陛下托臣以讨贼兴复之效，不效，则治臣之罪，以告先帝之灵。若无兴德之言，则责攸之、祎、允等之慢，以彰其咎；陛下亦宜自谋，以咨诹善道，察纳雅言，深追先帝遗诏。臣不胜受恩感激。 \r\r今当远离，临表涕零，不知所言。"
            
            // 设置内容最大高度 如果超出 可以滑动
            title = "设置了内容最大高度"
            
            view.messageHeight = 300
        }
        
        
        view.title = title
        view.message = message
        
        let action_one = AEAlertAction(title: "取消", style: .Cancel) { (action) in
            view.close()
        }
        let action_two = AEAlertAction(title: "知道了", style: .Default) { (action) in
            
        }
        view.addAction(action: action_one)
        view.addAction(action: action_two)
        view.show()
    }

}

