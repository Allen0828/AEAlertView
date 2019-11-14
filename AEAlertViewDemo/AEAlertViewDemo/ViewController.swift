//
//  ViewController.swift
//  AEAlertViewDemo
//
//  Created by Allen on 2018/9/10.
//  Copyright © 2018年 Allen. All rights reserved.
//

import UIKit
import AEAlertView


class ViewController: UIViewController {
    
    let types = ["普通样式", "UI普通样式",
    "修改控件位置", "UI修改控件位置",
    "textFlied", "UItextFlied",
    "自定义Content", "UI自定义Content",
    "内容超出", "UI内容超出",
    "只有图片", "动画成功",
    "动画失败"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let base = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        base.backgroundColor = UIColor.purple
        base.setTitle("base", for: .normal)
        base.addTarget(self, action: #selector(baseClick), for: .touchUpInside)
        view.addSubview(base)
        base.center = CGPoint(x: view.center.x, y: 50)
        
        var btnX: CGFloat = 10
        var btnY: CGFloat = 100
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
    
    @objc private func typeButtonClick(btn: UIButton) {
        if btn.tag % 2 == 0 {
            alertViewShowType(tag: btn.tag)
        } else {
            uiAlertViewShowType(tag: btn.tag)
        }
    }
    
    private func alertViewShowType(tag: Int) {
        let view = AEAlertView(style: .defaulted)
        var title = "默认"
        var message = "内容默认的样式"
        let action_one = AEAlertAction(title: "取消", style: .cancel) { (action) in
            view.dismiss()
        }
        let action_two = AEAlertAction(title: "知道了", style: .defaulted) { (action) in
            
        }
        
        if tag == 0 {
            view.title = title
            view.message = message
            
            view.addAction(action: action_one)
            view.addAction(action: action_two)
            view.show()
        } else if tag == 2 {
            title = "修改控件位置"
            message = "修改控件位置后的样式"
            view.title = title
            view.message = message
            view.titleTopMargin = 0
            view.messageTopMargin = 0
            view.animationViewTopMargin = 0
            view.contentViewTopMargin = 0
            view.actionViewTopMargin = 0
            
            view.addAction(action: action_one)
            view.show()
        } else if tag == 4 {
            let textView = AEAlertView(style: .textField, title: "自定义", message: "自定义的样式")
            textView.textFiled.placeholder = "自定义"
            let action_one = AEAlertAction(title: "取消", style: .cancel) { (action) in
                textView.dismiss()
            }
            let action_two = AEAlertAction(title: "知道了", style: .defaulted) { (action) in
                print("输入框的文字是----\(textView.textFiled.text ?? "")")
            }
            let action_t = AEAlertAction(title: "测试3个按钮", style: .defaulted) { (action) in
                print("输入框的文字是----\(textView.textFiled.text ?? "")")
            }
            textView.addAction(action: action_one)
            textView.addAction(action: action_two)
            textView.addAction(action: action_t)
            textView.show()
        } else if tag == 6 {
            title = "自定义content"
            message = "自定义content"
            view.title = title
            view.message = message
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
            img.image = UIImage(named: "001")
            img.contentMode = .scaleAspectFill
            img.layer.masksToBounds = true

            view.set(animation: img, width: 300, height: 200)

            view.addAction(action: action_one)
            view.addAction(action: action_two)
            view.show()
        } else if tag == 8 {
            title = "内容过多 并且不设置内容高度 "
            message = "臣本布衣，躬耕于南阳，苟全性命于乱世，不求闻达于诸侯。先帝不以臣卑鄙，猥自枉屈，三顾臣于草庐之中，咨臣以当世之事，由是感激，遂许先帝以驱驰。后值倾覆，受任于败军之际，奉命于危难之间，尔来二十有一年矣。         \r\r先帝知臣谨慎，故临崩寄臣以大事也。受命以来，夙夜忧叹，恐托付不效，以伤先帝之明；故五月渡泸，深入不毛。今南方已定，兵甲已足，当奖率三军，北定中原，庶竭驽钝，攘除奸凶，兴复汉室，还于旧都。此臣所以报先帝而忠陛下之职分也。至于斟酌损益，进尽忠言，则攸之、祎、允之任也。 \r\r愿陛下托臣以讨贼兴复之效，不效，则治臣之罪，以告先帝之灵。若无兴德之言，则责攸之、祎、允等之慢，以彰其咎；陛下亦宜自谋，以咨诹善道，察纳雅言，深追先帝遗诏。臣不胜受恩感激。 \r\r今当远离，临表涕零，不知所言。"
            // 设置内容最大高度 如果超出 可以滑动
            title = "设置了内容最大高度"
            view.title = title
            view.message = message
            view.messageHeight = 200
            
            view.addAction(action: action_one)
            view.addAction(action: action_two)
            view.show()
        } else if tag == 10 {
            view.titleTopMargin = 0
            view.messageTopMargin = 0
            view.messageHeight = 0
            view.animationViewTopMargin = 0
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
            img.image = UIImage(named: "001")
            img.contentMode = .scaleAspectFill
            img.layer.masksToBounds = true
            view.set(animation: img, width: view.alertMaximumWidth, height: 200)

            view.addAction(action: action_one)
            view.addAction(action: action_two)
            view.show()
        } else {
            let animV = AEAlertView(style: .textField, title: "请输入密码", message: nil)
            animV.titleTopMargin = 0
            animV.textFiled.placeholder = "密码"
            
            let action_one = AEAlertAction(title: "取消", style: .cancel) { (action) in
                animV.dismiss()
            }
            let action_two = AEAlertAction(title: "确定", style: .defaulted) { (action) in
                animV.actions = []
                animV.resetActions()
                
                let animation = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
                let anim = AEBeginLineAnimation.initShow(in: animation.bounds, lineWidth: 4, lineColor: UIColor.blue)
                animation.addSubview(anim)
                
                animV.textFiled.isHidden = true
                animV.set(animation: animation, width: 80, height: 80)
                
                // 模拟失败
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    anim.paused()
                    anim.removeFromSuperview()
                    let fail = AELineFailAnimation.initShow(in: animation.bounds, lineColor: UIColor.red)
                    animation.addSubview(fail)
                    
                    let cancel = AEAlertAction(title: "取消", style: .cancel) { (action) in
                        animV.dismiss()
                    }
                    animV.addAction(action: cancel)
                    animV.resetActions()
                }
                
            }
            animV.addAction(action: action_one)
            animV.addAction(action: action_two)
            animV.show()
        }
    }
    
    private func uiAlertViewShowType(tag: Int) {
        let view = AEUIAlertView(style: .defaulted)
        var title = "默认"
        var message = "内容默认的样式"
        let action_one = AEAlertAction(title: "取消", style: .cancel) { (action) in
            view.dismiss()
        }
        let action_two = AEAlertAction(title: "知道了", style: .defaulted) { (action) in
            
        }
        
        if tag == 1 {
            view.title = title
            view.message = message
            view.actionSplitLine = UIColor.orange
            
            view.addAction(action: action_one)
            view.addAction(action: action_two)
            view.show()
        } else if tag == 3 {
            title = "修改控件位置"
            message = "修改控件位置后的样式"
            view.title = title
            view.message = message
            view.actionSplitLine = UIColor.purple
            view.titleTopMargin = 0
            view.messageTopMargin = 0
            view.animationViewTopMargin = 0
            view.contentViewTopMargin = 0
            view.actionViewTopMargin = 0
            
            view.addAction(action: action_one)
            view.show()
        }else if tag == 5 {
            let textView = AEUIAlertView(style: .textField, title: "自定义", message: "自定义的样式")
            textView.textFiled.placeholder = "自定义"
            let action_one = AEAlertAction(title: "取消", style: .cancel) { (action) in
                textView.dismiss()
            }
            let action_two = AEAlertAction(title: "知道了", style: .defaulted) { (action) in
                print("输入框的文字是----\(textView.textFiled.text ?? "")")
            }
            let action_t = AEAlertAction(title: "测试3个按钮", style: .defaulted) { (action) in
                print("输入框的文字是----\(textView.textFiled.text ?? "")")
            }
            textView.addAction(action: action_one)
            textView.addAction(action: action_two)
            textView.addAction(action: action_t)
            textView.show()
        } else if tag == 7 {
            title = "自定义content"
            message = "自定义content"
            view.title = title
            view.message = message
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
            img.image = UIImage(named: "001")
            img.contentMode = .scaleAspectFill
            img.layer.masksToBounds = true

            view.set(animation: img, width: 300, height: 200)

            view.addAction(action: action_one)
            view.addAction(action: action_two)
            view.show()
        } else if tag == 9 {
            title = "内容过多 并且不设置内容高度 "
            message = "臣本布衣，躬耕于南阳，苟全性命于乱世，不求闻达于诸侯。先帝不以臣卑鄙，猥自枉屈，三顾臣于草庐之中，咨臣以当世之事，由是感激，遂许先帝以驱驰。后值倾覆，受任于败军之际，奉命于危难之间，尔来二十有一年矣。         \r\r先帝知臣谨慎，故临崩寄臣以大事也。受命以来，夙夜忧叹，恐托付不效，以伤先帝之明；故五月渡泸，深入不毛。今南方已定，兵甲已足，当奖率三军，北定中原，庶竭驽钝，攘除奸凶，兴复汉室，还于旧都。此臣所以报先帝而忠陛下之职分也。至于斟酌损益，进尽忠言，则攸之、祎、允之任也。 \r\r愿陛下托臣以讨贼兴复之效，不效，则治臣之罪，以告先帝之灵。若无兴德之言，则责攸之、祎、允等之慢，以彰其咎；陛下亦宜自谋，以咨诹善道，察纳雅言，深追先帝遗诏。臣不胜受恩感激。 \r\r今当远离，临表涕零，不知所言。"
            // 设置内容最大高度 如果超出 可以滑动
            title = "设置了内容最大高度"
            view.title = title
            view.message = message
            view.messageHeight = 200
            
            view.addAction(action: action_one)
            view.addAction(action: action_two)
            view.show()
        } else {
            let animV = AEUIAlertView(style: .textField, title: "请输入密码", message: nil)
            animV.textFiled.placeholder = "密码"
            
            let action_one = AEAlertAction(title: "取消", style: .cancel) { (action) in
                animV.dismiss()
            }
            let action_two = AEAlertAction(title: "确定", style: .defaulted) { (action) in
                animV.actions = []
                animV.resetActions()
                
                let animation = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
                let anim = AEBeginLineAnimation.initShow(in: animation.bounds, lineWidth: 4, lineColor: UIColor.blue)
                animation.addSubview(anim)
                
                animV.textFiled.isHidden = true
                animV.set(animation: animation, width: 80, height: 80)
                
                // 模拟失败
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    anim.paused()
                    anim.removeFromSuperview()
                    let fail = AELineSuccessAnimation.initShow(in: animation.bounds, lineColor: UIColor.red)
                    animation.addSubview(fail)
                    
                    let cancel = AEAlertAction(title: "成功了", style: .defaulted) { (action) in
                        animV.dismiss()
                    }
                    animV.addAction(action: cancel)
                    animV.resetActions()
                }
                
            }
            animV.addAction(action: action_one)
            animV.addAction(action: action_two)
            animV.show()
        }
    }
}

extension ViewController {
    @objc private func baseClick() {
        let view = baseAlertView()
        self.view.addSubview(view)
    }
}

// MARK: - 如果AEAlertView 和 AEUIAlertView  都无法满足需求 可以使用AEBaseAlertView
class baseAlertView: AEBaseAlertView {
    
    override init(frame: CGRect) {
        let rect = UIScreen.main.bounds
        super.init(frame: rect)
        
//        backgroundColor = UIColor.darkGray
        titleLabel.backgroundColor = UIColor.purple
        titlePadding = 0
        titleTopMargin = 0
        messageTextView.backgroundColor = UIColor.orange
        messagePadding = 0
        messageTopMargin = 0
        animationViewTopMargin = 0
        contentViewTopMargin = 0
        
        titleLabel.text = "Title Label"
        messageTextView.text = "message TextView"
        let animation = UILabel()
        animation.backgroundColor = UIColor.green
        animation.text = "animationView"
        animation.textAlignment = .center
        setAnimation(view: animation, width: maximumWidth, height: 50)
        
        let content = UILabel()
        content.backgroundColor = UIColor.red
        content.text = "contentView"
        content.textAlignment = .center
        setContent(view: content, width: maximumWidth, height: 50)
        
        let cancel = UIButton()
        cancel.setTitleColor(UIColor.red, for: .normal)
        cancel.setTitle("取消", for: .normal)
        cancel.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        actionList = [cancel]
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func cancelClick() {
//        self.actionList = []
        
        self.removeFromSuperview()
    }
}
