//
//  NewTestController.swift
//  AlertViewDemo
//
//  Created by Allen0828 on 2023/7/26.
//  Copyright © 2023 张其锋. All rights reserved.
//

import UIKit
import AEAlertView

extension NewTestController {
    
    /// 最快的方式调用
    func callAlert() {
        AEAlertView.show(title: "title title title title title title title title title title ", message: "fastest", actions: ["cancel","ok"]) { action in
            print("dismiss----Fastest \(action)")
        }
    }
    /// 展示alertview的布局和间距
    func showLevel() {
        let v = AEAlertView()
        v.alertView.titleLabel.backgroundColor = UIColor.red
        v.alertView.messageTextView.backgroundColor = UIColor.orange
        v.alertView.contentContainerView.backgroundColor = UIColor.blue
        v.alertView.customContainerView.backgroundColor = UIColor.green
        v.alertView.actionContainerView.backgroundColor = UIColor.purple
        
        v.title = "title"
        v.message = "message\rmessage"
        let cv = UIView()
        cv.backgroundColor = UIColor.red
        v.set(content: cv, width: 10, height: 10)
//        v.set(content: cv, width: -1, height: 10)
        
        let custom = UIView()
        v.set(custom: custom, width: 10, height: 10)
        
        let cancel = AEAlertAction(title: "cancel") { action in
            print(action)
            v.dismiss()
        }
        v.addAction(action: cancel)
        v.show()
    }
    /// 自定义间距
    func customAlert() {
        let v = AEAlertView()
        v.alertView.titleLabel.backgroundColor = UIColor.red
        v.alertView.messageTextView.backgroundColor = UIColor.orange
        v.alertView.contentContainerView.backgroundColor = UIColor.blue
        v.alertView.customContainerView.backgroundColor = UIColor.green
        v.alertView.actionContainerView.backgroundColor = UIColor.purple
        
        v.title = "title"
        v.message = "message\rmessage"
        let cv = UIView()
        cv.backgroundColor = UIColor.red
        v.set(content: cv, width: 10, height: 40)
        let custom = UIView()
        v.set(custom: custom, width: 10, height: 40)
        
        // 间距
        v.titleTopMargin = 0
        v.titlePadding = 0
        v.messageTopMargin = 0
        v.messagePadding = 0
        v.actionViewTopMargin = 0
        
        let cancel = AEAlertAction(title: "cancel") { action in
            print(action)
            v.dismiss()
        }
        v.addAction(action: cancel)
        v.show()
    }
    /// 自定义按钮样式
    func customAction() {
        let alert = AEAlertView(style: .custom, title: "custom view", message: "At most two can be set")

        let v1 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        v1.backgroundColor = UIColor.blue
        alert.set(content: v1, width: 300, height: 60)
        let v2 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        v2.backgroundColor = UIColor.red
        alert.set(custom: v2, width: 300, height: 60)

        /// 如果样式为custom 按钮默认是带有描边和圆角的  可以通过设置 action.adapterCustom 来关闭
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        cancel.tag = 1001
        cancel.layerBorderColor = UIColor.red
        cancel.layerCornerRadius = 20

        let dev = AEAlertAction.init(title: "dev", style: .defaulted) { (action) in
            print("\(action.tag)")
        }
        dev.tag = 1002
        dev.titleColor = UIColor.orange
        dev.backgroundColor = UIColor.yellow
        dev.adapterCustom = false

        alert.addAction(action: cancel)
        alert.addAction(action: dev)
        alert.show()
    }
    /// 内容超过最大高度
    func messageExceedHeight() {
        let message = """
        臣本布衣，躬耕于南阳，苟全性命于乱世，不求闻达于诸侯。先帝不以臣卑鄙，猥自枉屈，三顾臣于草庐之中，咨臣以当世之事，由是感激，遂许先帝以驱驰。后值倾覆，受任于败军之际，奉命于危难之间，尔来二十有一年矣。
        
        先帝知臣谨慎，故临崩寄臣以大事也。受命以来，夙夜忧叹，恐托付不效，以伤先帝之明；故五月渡泸，深入不毛。今南方已定，兵甲已足，当奖率三军，北定中原，庶竭驽钝，攘除奸凶，兴复汉室，还于旧都。此臣所以报先帝而忠陛下之职分也。至于斟酌损益，进尽忠言，则攸之、祎、允之任也。
        
        愿陛下托臣以讨贼兴复之效，不效，则治臣之罪，以告先帝之灵。若无兴德之言，则责攸之、祎、允等之慢，以彰其咎；陛下亦宜自谋，以咨诹善道，察纳雅言，深追先帝遗诏。臣不胜受恩感激。
        
        今当远离，临表涕零，不知所言。
        
        The minister was originally a commoner, and he worked hard in Nanyang. Gou Quan lived in troubled times and did not seek to be known to the princes. The first emperor didn't think his ministers were despicable, he was obscene and self-defeating, he paid three visits to his ministers in the thatched hut, and the counselors were grateful for the affairs of the world, so Xu Xiandi drove him away. It has been twenty years since I was overthrown, when I was appointed by the defeated army, and when I was ordered to be in danger.
                
        The first emperor and his ministers were cautious, so he sent his ministers to take important matters before the collapse. Since he was ordered, Suye sighed with sorrow, fearing that the entrustment would not work and hurt the emperor's sagacity; so he crossed Lu in May and went deep into the barren. Now that the south has been set, the army is full, and the three armies will be rewarded to set the central plains in the north, wipe out the culprits, revive the Han Dynasty, and return to the old capital. The reason why this minister is loyal to His Majesty is to report to the late emperor. As for profit and loss, you, you, yi, and yi are the ones who make the best of their loyalty.
                
        May your Majesty call on the king's spirit to bring the thief back to life, but if he does not, then he will be punished. If there are no words of virtue, then blame you, yi, yun, etc. for their slowness, so as to show their blame; your majesty should also seek for himself, to consult the good way, to examine the elegant words, and to pursue the late emperor's edict. The minister is very grateful.
                
        Now stay away, I don't know what to say.
        """
        let v = AEAlertView(style: .defaulted, title: "内容超过最大高度\r内容超过最大高度\r内容超过最大高度", message: message)
        v.titleNumberOfLines = 3
        v.actionViewTopMargin = 0
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            v.dismiss()
        }
        let dev = AEAlertAction(title: "dev") { action in
            v.dismiss()
        }
        v.addAction(action: cancel)
        v.addAction(action: dev)
        v.show()
    }
    func setMessageHeight() {
        let message = """
        臣本布衣，躬耕于南阳，苟全性命于乱世，不求闻达于诸侯。先帝不以臣卑鄙，猥自枉屈，三顾臣于草庐之中，咨臣以当世之事，由是感激，遂许先帝以驱驰。后值倾覆，受任于败军之际，奉命于危难之间，尔来二十有一年矣。
        
        先帝知臣谨慎，故临崩寄臣以大事也。受命以来，夙夜忧叹，恐托付不效，以伤先帝之明；故五月渡泸，深入不毛。今南方已定，兵甲已足，当奖率三军，北定中原，庶竭驽钝，攘除奸凶，兴复汉室，还于旧都。此臣所以报先帝而忠陛下之职分也。至于斟酌损益，进尽忠言，则攸之、祎、允之任也。
        
        愿陛下托臣以讨贼兴复之效，不效，则治臣之罪，以告先帝之灵。若无兴德之言，则责攸之、祎、允等之慢，以彰其咎；陛下亦宜自谋，以咨诹善道，察纳雅言，深追先帝遗诏。臣不胜受恩感激。
        
        今当远离，临表涕零，不知所言。
        
        The minister was originally a commoner, and he worked hard in Nanyang. Gou Quan lived in troubled times and did not seek to be known to the princes. The first emperor didn't think his ministers were despicable, he was obscene and self-defeating, he paid three visits to his ministers in the thatched hut, and the counselors were grateful for the affairs of the world, so Xu Xiandi drove him away. It has been twenty years since I was overthrown, when I was appointed by the defeated army, and when I was ordered to be in danger.
                
        The first emperor and his ministers were cautious, so he sent his ministers to take important matters before the collapse. Since he was ordered, Suye sighed with sorrow, fearing that the entrustment would not work and hurt the emperor's sagacity; so he crossed Lu in May and went deep into the barren. Now that the south has been set, the army is full, and the three armies will be rewarded to set the central plains in the north, wipe out the culprits, revive the Han Dynasty, and return to the old capital. The reason why this minister is loyal to His Majesty is to report to the late emperor. As for profit and loss, you, you, yi, and yi are the ones who make the best of their loyalty.
                
        May your Majesty call on the king's spirit to bring the thief back to life, but if he does not, then he will be punished. If there are no words of virtue, then blame you, yi, yun, etc. for their slowness, so as to show their blame; your majesty should also seek for himself, to consult the good way, to examine the elegant words, and to pursue the late emperor's edict. The minister is very grateful.
                
        Now stay away, I don't know what to say.
        """
        let v = AEAlertView(style: .defaulted, title: "内容超过最大高度\r内容超过最大高度\r内容超过最大高度", message: message)
        v.actionViewTopMargin = 0
        // 禁止内容被选中
        v.messageIsSelectable = false
        v.messageHeight = 300
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            v.dismiss()
        }
        let dev = AEAlertAction(title: "dev") { action in
            v.dismiss()
        }
        v.addAction(action: cancel)
        v.addAction(action: dev)
        v.show()
    }
    ///
    func setBackImage() {
        AEAlertView.show(title: "title", message: "set background image", actions: ["cancel", "ok"], bgImage: UIImage(named: "006")) { action in
            print("dismiss----background")
        }
    }
    /// 背景图片尺寸修改
    func setBackImageSize() {
        let alert = AEAlertView.init(style: .defaulted, title: "background image is too long", message: "两种解决方法：\r1: 不设置backgroundImageBottomMargin, 只设置image的高度-注高度可能会引起图片变形-需要设置contentMode\r\r2: 不设置backgroundImageBottomMargin，也不设置backgroundImageHeight，根据内容自动计算（可以设置messageHeight来固定大小）\r 注：超过弹窗最大高度 将会默认显示最大高度")
        alert.backgroundImage = UIImage(named: "001")
        // 方式1
        alert.backgroundImageHeight = 300
        alert.alertView.backgroundImage.contentMode = .scaleAspectFill
        // 方式2
//        alert.messageHeight = 600

        alert.titleColor = UIColor.red
        alert.messageColor = UIColor.red
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        alert.addAction(action: cancel)
        alert.show()
    }
    /// 设置gif图片
    func setGIFImage() {
        // 如果想将alert 添加到自定义view上 再初始化是应该传frame 以确保alert的尺寸
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
    ///  设置按钮多样性
    func setActionStyle() {
        // 你也可以试试 在custom模式下的 按钮样式
        let alert = AETextFieldAlertView(style: .defaulted, title: "custom action", message: "Please check the default values before using")
        let cancel = AEAlertAction.init(title: "cancel\rcancel\rcancel", style: .cancel) { (action) in
            alert.dismiss()
        }
        cancel.cancelTitleColor = UIColor.red
        cancel.numberOfLines = 0
        let dev = AEAlertAction.init(title: "dev", style: .defaulted) { (action) in
            print("\(alert.textFieldText)")
            print("\(action.tag)")
        }
        dev.image = UIImage(named: "index_def_icon")
//        dev.imagePlacement = .right

        alert.addAction(action: cancel)
        alert.addAction(action: dev)
        alert.show()
    }
    
    // 动画成功
    private func animationSuccess() {
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
    private func animationFail() {
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
    
    func nilMessage() {
        AEAlertView.show(title: "title", message: nil, actions: ["cancel", "ok"], bgImage: UIImage(named: "006")) { action in
            print("dismiss----background")
        }
    }
}




class NewTestController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(view.bounds) //(0.0, 0.0, 390.0, 844.0)
        navigationController?.navigationBar.isTranslucent = false
        
        let table = UITableView(frame: view.bounds)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 40
        view.addSubview(table)
    }
    
    let arr = ["alertview的标准布局和间距","自定义间距", "自定义按钮样式", "内容超过最大高度", "手动设置内容高度并禁止选中", "设置背景图片", "背景图片尺寸修改", "设置gif图片并将alert添加到当前view上", "设置按钮多样性", "最便捷的调用方式", "动画成功", "动画失败", "不设置内容"]

}

extension NewTestController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let la = UILabel(frame: CGRect(x: 32, y: 0, width: self.view.bounds.size.width-32, height: 40))
        la.text = arr[indexPath.row]
        cell.contentView.addSubview(la)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showLevel()
        case 1:
            customAlert()
        case 2:
            customAction()
        case 3:
            messageExceedHeight()
        case 4:
            setMessageHeight()
        case 5:
            setBackImage()
        case 6:
            setBackImageSize()
        case 7:
            setGIFImage()
        case 8:
            setActionStyle()
        case 9:
            callAlert()
        case 10:
            animationSuccess()
        case 11:
            animationFail()
        case 12:
            nilMessage()
            
            
        default: break
        }
        
    }
    
    
}
