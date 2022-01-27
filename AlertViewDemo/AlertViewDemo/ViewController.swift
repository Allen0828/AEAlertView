//
//  ViewController.swift
//  转场动画
//
//  Created by 张其锋 on 2019/8/14.
//  Copyright © 2019 张其锋. All rights reserved.
//

import UIKit
import AEAlertView

class ViewController: UIViewController {

    let types = ["最快的方式调用", "设置背景图片",
    "图片不出现在按钮上", "最快的输入框",
    "内容超出", "图片过长",
    "使用自定义view", "继承alertView",
    "动画成功", "动画失败",
    "正常的Gif背景", "不正常的Gif背景"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        switch btn.tag {
        case 0:
            test0()
        case 1:
            test1()
        case 2:
            test2()
        case 3:
            test3()
        case 4:
            test4()
        case 5:
            test5()
        case 6:
            test6()
        case 7:
            test7()
        case 8:
            test8()
        case 9:
            test9()
        case 10:
            test10()
        case 11:
            test11()
        default:
            break
        }
    }
    
    
    // 最快的方式调用
    private func test0() {
        AEAlertView.show(title: "提示", actions: ["好的"], message: "最快的调用方式") { (action) in
            print("\(action.tag) --- 自动关闭了")
        }
    }
    // 设置背景图片  (默认使用计算的高度 - 当设置了backgroundImageBottomMargin 属性时 会使用图片高度)
    private func test1() {
        AEAlertView.show(title: "提示", actions: ["cancel", "dev"], message: "(默认使用计算的高度 - 当设置了backgroundImageBottomMargin 属性时 会使用图片高度)") { (action) in
            print("\(action.tag) --- 自动关闭了")
        }
    }
    // 设置图片 Margin  在默认样式下 按钮占用40的高度 如果是3个按钮 高度为80 4个为120 以此类推
    private func test2() {
        AEAlertView.show(title: "提示", actions: ["cancel", "dev"], message: "(设置图片 Margin  在默认样式下 按钮占用40的高度 如果是3个按钮 高度为80 4个为120 以此类推 - 注: 使用了bgImageBottomMargin 会根据图片的大小来计算弹窗高度--除非你的内容比图片高)", bgImage: UIImage(named: "001"), bgImageBottomMargin: 40, titleColor: UIColor.red, messageColor: UIColor.red, defaultActionColor: UIColor.red) { (action) in
            print("\(action.tag) --- 自动关闭了")
        }
    }
    // 最快的输入框
    private func test3() {
        let alert = AETextFieldAlertView.show(title: "", message: "正在展示最快速的出现输入框", bgImage: UIImage(named: "002"), placeholder: "点我试试")
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag) --- 输入框的文字=\(alert.textFieldText)")
            alert.dismiss()
        }
        alert.addAction(action: cancel)
        alert.show()
    }
    // 内容超出
    private func test4() {
        let alert = AEAlertView.init(style: .custom, title: "展示的内容过多", message: "臣本布衣，躬耕于南阳，苟全性命于乱世，不求闻达于诸侯。先帝不以臣卑鄙，猥自枉屈，三顾臣于草庐之中，咨臣以当世之事，由是感激，遂许先帝以驱驰。后值倾覆，受任于败军之际，奉命于危难之间，尔来二十有一年矣。         \r\r先帝知臣谨慎，故临崩寄臣以大事也。受命以来，夙夜忧叹，恐托付不效，以伤先帝之明；故五月渡泸，深入不毛。今南方已定，兵甲已足，当奖率三军，北定中原，庶竭驽钝，攘除奸凶，兴复汉室，还于旧都。此臣所以报先帝而忠陛下之职分也。至于斟酌损益，进尽忠言，则攸之、祎、允之任也。 \r\r愿陛下托臣以讨贼兴复之效，不效，则治臣之罪，以告先帝之灵。若无兴德之言，则责攸之、祎、允等之慢，以彰其咎；陛下亦宜自谋，以咨诹善道，察纳雅言，深追先帝遗诏。臣不胜受恩感激。 \r\r今当远离，临表涕零，不知所言。")
        alert.messageHeight = 300
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        alert.addAction(action: cancel)
        alert.show()
    }
    // 图片太长
    private func test5() {
        let alert = AEAlertView.init(style: .defaulted, title: "背景图片太长", message: "两种解决方法：\r1: 不设置backgroundImageBottomMargin, 只设置image的高度-注高度可能会引起图片变形-需要设置contentMode\r\r2: 不设置backgroundImageBottomMargin，也不设置backgroundImageHeight，根据内容自动计算（可以设置messageHeight来固定大小）\r 注：超过弹窗最大高度 将会默认显示最大高度")
        alert.backgroundImage = UIImage(named: "000")
        // 方式1
        //        alert.backgroundImageHeight = 300
        //        alert.alertView.backgroundImage.contentMode = .scaleAspectFill
        // 方式2
        alert.messageHeight = 400
        
        alert.messageColor = UIColor.red
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        alert.addAction(action: cancel)
        alert.show()
    }
    
    // 使用自定义View 自定义view 在AEAlertView中可以设置2个 在AETextFiledAlertView中只能设置一个
    private func test6() {
        let alert = AETextFieldAlertView.init(style: .custom, title: "自定义", message: "注意 textField已经占用了一个自定义view的位置")
        // 设置自定义view时 X Y 不会生效
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        v.backgroundColor = UIColor.red
        alert.set(custom: v, width: 300, height: 60)
        
        // 可以设置按钮颜色
        alert.cancelButtonLayerBorderColor = UIColor.darkGray
        alert.cancelButtonTitleColor = UIColor.darkGray
        alert.buttonColor = UIColor.red
        alert.buttonTitleColor = UIColor.white
        alert.buttonLayerBorderColor = UIColor.red
        
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        cancel.tag = 1001
        alert.addAction(action: cancel)
        let dev = AEAlertAction.init(title: "dev", style: .defaulted) { (action) in
            print("\(action.tag)")
        }
        dev.tag = 1002
        alert.addAction(action: dev)
        alert.show()
    }
    // 继承子AEAlertView
    private func test7() {
        AlertView.show("产品就要这样的", "产品: 砍我可以-砍需求不行", ["呵呵", "哦哦"]) { (action) in
            print(action.tag)
        }
    }
    
    // 动画成功
    private func test8() {
        let alert = AETextFieldAlertView.init(style: .defaulted, title: "请输入密码", message: nil)
        alert.textField.placeholder = "随便输入。。。"
        let cancel = AEAlertAction(title: "取消", style: .cancel) { (action) in
            alert.dismiss()
        }
        let action_two = AEAlertAction(title: "确定", style: .defaulted) { (action) in
            alert.removeActions()
            
            let animation = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            let anim = AEBeginLineAnimation.initShow(in: animation.bounds, lineWidth: 4, lineColor: UIColor.blue)
            animation.addSubview(anim)
            
            alert.textField.isHidden = true
            alert.customViewTopMargin = -60
            alert.set(custom: animation, width: 80, height: 80)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                anim.paused()
                anim.removeFromSuperview()
                let fail = AELineSuccessAnimation.initShow(in: animation.bounds, lineColor: UIColor.red)
                animation.addSubview(fail)
                
                let cancel = AEAlertAction(title: "成功了", style: .defaulted) { (action) in
                    alert.dismiss()
                }
                alert.addAction(action: cancel)
                alert.resetActions()
            }
        }
        alert.addAction(action: cancel)
        alert.addAction(action: action_two)
        alert.show()
        
    }
    // 动画失败
    private func test9() {
        let animV = AETextFieldAlertView.init(style: .defaulted, title: "请输入密码", message: nil)
        animV.textField.placeholder = "密码"
        
        let action_one = AEAlertAction(title: "取消", style: .cancel) { (action) in
            animV.dismiss()
        }
        let action_two = AEAlertAction(title: "确定", style: .defaulted) { (action) in
            animV.removeActions()
            
            let animation = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            let anim = AEBeginLineAnimation.initShow(in: animation.bounds, lineWidth: 4, lineColor: UIColor.blue)
            animation.addSubview(anim)
            
            animV.textField.isHidden = true
            animV.customViewTopMargin = -60
            animV.set(custom: animation, width: 80, height: 80)
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
    private func test10() {
        let alert = AEAlertView.init(style: .defaulted, title: "背景图片太长", message: "设置了gif高度")
        alert.setBackgroundImage(contentsOf: Bundle.main.path(forResource: "003", ofType: "gif"))
        
        alert.backgroundImageHeight = 300
        alert.messageColor = UIColor.red
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        alert.addAction(action: cancel)
        alert.show()
    }
    private func test11() {
        let alert = AEAlertView.init(style: .defaulted, title: "背景图片太长", message: "设置了gif高度")
        alert.setBackgroundImage(contentsOf: Bundle.main.path(forResource: "gif004", ofType: "gif"))
        alert.alertView.backgroundImage.contentMode = .scaleAspectFit
        
        alert.messageColor = UIColor.red
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        alert.addAction(action: cancel)
        alert.show()
    }
}

