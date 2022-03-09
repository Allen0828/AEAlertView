//
//  TestViewController.swift
//  dev-alert
//
//  Created by gw_pro on 2021/11/18.
//

import UIKit

extension TestViewController {
    
    // MARK: - alert
    private func alertType1() {
        AEAlertView.show(title: "title", message: "fastest", actions: ["ok"]) { action in
            print("dismiss----Fastest")
        }
    }
    private func alertType2() {
        AEAlertView.show(title: "title", message: "set background image", actions: ["cancel", "ok"], bgImage: UIImage(named: "006")) { action in
            print("dismiss----background")
        }
    }
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
    private func alertType4() {
        AEAlertView.show(title: "title", message: "set background image The image is not displayed on the button", actions: ["cancel", "ok"], bgImage: UIImage(named: "006"), bgImageBottomMargin: 40) { action in
            print("dismiss----background image")
        }
    }
    // 背景图片太长
    private func alertType5() {
        let alert = AEAlertView.init(style: .defaulted, title: "background image is too long", message: "两种解决方法：\r1: 不设置backgroundImageBottomMargin, 只设置image的高度-注高度可能会引起图片变形-需要设置contentMode\r\r2: 不设置backgroundImageBottomMargin，也不设置backgroundImageHeight，根据内容自动计算（可以设置messageHeight来固定大小）\r 注：超过弹窗最大高度 将会默认显示最大高度", maximumWidth: 600)
        alert.backgroundImage = UIImage(named: "001")
        // 方式1
//        alert.backgroundImageHeight = 300
//        alert.alertView.backgroundImage.contentMode = .scaleAspectFill
        // 方式2
        alert.messageHeight = 600
        
        alert.titleColor = UIColor.red
        alert.messageColor = UIColor.red
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        alert.addAction(action: cancel)
        alert.show()
    }
    // 内容过多
    private func alertType6() {
        let alert = AEAlertView.init(style: .custom, title: "too much to show", message: "臣本布衣，躬耕于南阳，苟全性命于乱世，不求闻达于诸侯。先帝不以臣卑鄙，猥自枉屈，三顾臣于草庐之中，咨臣以当世之事，由是感激，遂许先帝以驱驰。后值倾覆，受任于败军之际，奉命于危难之间，尔来二十有一年矣。         \r\r先帝知臣谨慎，故临崩寄臣以大事也。受命以来，夙夜忧叹，恐托付不效，以伤先帝之明；故五月渡泸，深入不毛。今南方已定，兵甲已足，当奖率三军，北定中原，庶竭驽钝，攘除奸凶，兴复汉室，还于旧都。此臣所以报先帝而忠陛下之职分也。至于斟酌损益，进尽忠言，则攸之、祎、允之任也。 \r\r愿陛下托臣以讨贼兴复之效，不效，则治臣之罪，以告先帝之灵。若无兴德之言，则责攸之、祎、允等之慢，以彰其咎；陛下亦宜自谋，以咨诹善道，察纳雅言，深追先帝遗诏。臣不胜受恩感激。 \r\r今当远离，临表涕零，不知所言。")
        alert.messageHeight = 300
//        alert.messagePadding = 30
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        alert.addAction(action: cancel)
        alert.show()
    }
    private func alertType7() {
        let alert = AEAlertView(style: .custom, title: "custom view", message: "At most two can be set", maximumWidth: 600)
        
        let v1 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        v1.backgroundColor = UIColor.blue
        alert.set(content: v1, width: 300, height: 60)
        
        let v2 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        v2.backgroundColor = UIColor.red
        alert.set(custom: v2, width: 300, height: 60)
        
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        cancel.tag = 1001
        // 可以设置按钮颜色
        cancel.cancelTitleColor = UIColor.red
        cancel.cancelLayerBorderColor = UIColor.darkGray
        cancel.layerBorderWidth = 1
        
        let dev = AEAlertAction.init(title: "dev", style: .defaulted) { (action) in
            print("\(action.tag)")
        }
        dev.tag = 1002
        dev.titleColor = UIColor.orange
        dev.backgroundColor = UIColor.yellow
        dev.layerBorderColor = UIColor.orange
        dev.layerBorderWidth = 1
        
        alert.addAction(action: cancel)
        alert.addAction(action: dev)
        alert.show()
    }
    private func alertType8() {
//        AEBaseAlertView.MaximumWidth = 200
        
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
    
    // MARK: - alertFiled
    private func alertFieldType1() {
        AETextFieldAlertView.show(title: "title", message: "messages", actions: ["cancel","dev"]) { action, text in
            print("input----\(text)")
        }
    }
    private func alertFieldType2() {
        AETextFieldAlertView.show(title: "title", message: "messages", placeholder: "please input", text: "", actions: ["cancel","dev"], bgImage: UIImage(named: "006")) { action, text in
            print("input----\(text)")
        }
    }
    private func alertFieldType3() {
        let alert = AETextFieldAlertView.init(style: .defaulted, title: "title", message: "set gif height Add alert to the current view")
        alert.setBackgroundImage(contentsOf: Bundle.main.path(forResource: "003", ofType: "gif"))
        
        alert.backgroundImageHeight = 300
        alert.messageColor = UIColor.red
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            print("input----\(alert.textFieldText)")
            alert.dismiss()
        }
        cancel.cancelTitleColor = .red
        
        alert.addAction(action: cancel)
        alert.create()
        
        view.addSubview(alert)
    }
    private func alertFieldType4() {
        AETextFieldAlertView.show(title: "title", message: "set background image The image is not displayed on the button", actions: ["cancel", "ok"], bgImage: UIImage(named: "006"), bgImageBottomMargin: 40) { action, text  in
            print("input----\(text)")
        }
    }
    private func alertFieldType5() {
        let alert = AETextFieldAlertView.init(style: .defaulted, title: "background image is too long", message: "两种解决方法：\r1: 不设置backgroundImageBottomMargin, 只设置image的高度-注高度可能会引起图片变形-需要设置contentMode\r\r2: 不设置backgroundImageBottomMargin，也不设置backgroundImageHeight，根据内容自动计算（可以设置messageHeight来固定大小）\r 注：超过弹窗最大高度 将会默认显示最大高度")
        alert.backgroundImage = UIImage(named: "001")
        // 方式1
        alert.backgroundImageHeight = 400    // 如果高度过小 可能会导致内容显示不全
        alert.alertView.backgroundImage.contentMode = .scaleAspectFill
        // 方式2
//        alert.messageHeight = 600
        
        alert.titleColor = UIColor.red
        alert.messageColor = UIColor.red
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        cancel.cancelTitleColor = .red
        alert.addAction(action: cancel)
        alert.show()
    }
    private func alertFieldType6() {
        let alert = AETextFieldAlertView.init(style: .custom, title: "too much to show", message: "臣本布衣，躬耕于南阳，苟全性命于乱世，不求闻达于诸侯。先帝不以臣卑鄙，猥自枉屈，三顾臣于草庐之中，咨臣以当世之事，由是感激，遂许先帝以驱驰。后值倾覆，受任于败军之际，奉命于危难之间，尔来二十有一年矣。         \r\r先帝知臣谨慎，故临崩寄臣以大事也。受命以来，夙夜忧叹，恐托付不效，以伤先帝之明；故五月渡泸，深入不毛。今南方已定，兵甲已足，当奖率三军，北定中原，庶竭驽钝，攘除奸凶，兴复汉室，还于旧都。此臣所以报先帝而忠陛下之职分也。至于斟酌损益，进尽忠言，则攸之、祎、允之任也。 \r\r愿陛下托臣以讨贼兴复之效，不效，则治臣之罪，以告先帝之灵。若无兴德之言，则责攸之、祎、允等之慢，以彰其咎；陛下亦宜自谋，以咨诹善道，察纳雅言，深追先帝遗诏。臣不胜受恩感激。 \r\r今当远离，临表涕零，不知所言。", maximumWidth: 300)
        alert.messageHeight = 300
//        alert.messagePadding = 30 // 两个不应该同时使用 会有约束冲突警告 但是不影响使用 会在下个版本修复
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(alert.textFieldText)")
            print("\(action.tag)")
            alert.dismiss()
        }
        cancel.layerBorderWidth = 1
        cancel.cancelLayerBorderColor = UIColor.darkGray
        let dev = AEAlertAction(title: "dev") { action in
            alert.dismiss()
        }
        dev.layerBorderWidth = 1
        dev.layerBorderColor = UIColor.red
        dev.layerCornerRadius = 4
        alert.addAction(action: cancel)
        alert.addAction(action: dev)
        alert.show()
    }
    private func alertFieldType7() {
        let alert = AETextFieldAlertView(style: .custom, title: "custom view", message: "At most one can be set")
        let v2 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        v2.backgroundColor = UIColor.red
        alert.set(custom: v2, width: 300, height: 60)
        
        let cancel = AEAlertAction.init(title: "cancel", style: .cancel) { (action) in
            print("\(action.tag)")
            alert.dismiss()
        }
        cancel.tag = 1001
        cancel.layerBorderWidth = 1
        
        let dev = AEAlertAction.init(title: "dev", style: .defaulted) { (action) in
            print("\(action.tag)")
        }
        dev.tag = 1002
        dev.titleColor = UIColor.orange
        dev.backgroundColor = UIColor.yellow
        dev.layerBorderColor = UIColor.orange
        dev.layerBorderWidth = 1
        
        alert.addAction(action: cancel)
        alert.addAction(action: dev)
        alert.show()
    }
    private func alertFieldType8() {
        let alert = AETextFieldAlertView(style: .defaulted, title: "custom action", message: "Please check the default values before using")
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
    
    
    // MARK: - alertCustom
    // 动画成功
    private func alertCustomType1() {
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
    private func alertCustomType2() {
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
    private func alertCustomType3() {
//        AlertView.show("产品就要这样的", "产品: 砍我可以-砍需求不行", ["呵呵", "哦哦"]) { (action) in
//            print(action.tag)
//        }
    }
    
}



class TestViewController: UIViewController {
    
    let alertTypes = ["最快的方式调用", "设置背景图片", "设置背景图片Gif", "图片不出现在按钮上", "图片过长", "内容超出", "使用自定义view", "按钮多样性"]
    let alertFieldTypes = ["最快的方式调用", "设置背景图片", "设置背景图片Gif", "图片不出现在按钮上", "图片过长", "内容超出", "使用自定义view", "按钮多样性"]
    // 自定义
    let alertCustomTypes = ["动画成功", "动画失败", "继承alertView"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        scrollView.frame = self.view.bounds
        view.addSubview(scrollView)
        
        let btnX: CGFloat = 10
        var btnY: CGFloat = 60
        let btnW: CGFloat = (UIScreen.main.bounds.size.width -  30) / 2
        let btnH: CGFloat = 40
        alertLa.frame = CGRect(x: btnX, y: btnY-40, width: btnW, height: 40)
        scrollView.addSubview(alertLa)
        for (index, item) in alertTypes.enumerated() {
            let btn = UIButton(frame: CGRect(x: btnX, y: btnY, width: btnW, height: btnH))
            btn.setTitle(item, for: .normal)
            btn.backgroundColor = UIColor.red
            btn.tag = index
            btnY += 41
            btn.addTarget(self, action: #selector(alertClick), for: .touchUpInside)
            scrollView.addSubview(btn)
        }
        btnY = 60
        alertFieldLa.frame = CGRect(x: btnW+10, y: btnY-40, width: btnW, height: 40)
        scrollView.addSubview(alertFieldLa)
        for (index, item) in alertFieldTypes.enumerated() {
            let btn = UIButton(frame: CGRect(x: btnW+10, y: btnY, width: btnW, height: btnH))
            btn.setTitle(item, for: .normal)
            btn.backgroundColor = UIColor.blue
            btn.tag = index
            btnY += 41
            btn.addTarget(self, action: #selector(alertFieldClick), for: .touchUpInside)
            scrollView.addSubview(btn)
        }
        btnY += 60
        alertCustomLa.frame = CGRect(x: 10, y: btnY, width: btnW*2, height: 40)
        scrollView.addSubview(alertCustomLa)
        btnY += 40
        for (index, item) in alertCustomTypes.enumerated() {
            let btn = UIButton(frame: CGRect(x: 10, y: btnY, width: btnW*2, height: btnH))
            btn.setTitle(item, for: .normal)
            btn.backgroundColor = UIColor.orange
            btn.tag = index
            btnY += 41
            btn.addTarget(self, action: #selector(alertCustomClick), for: .touchUpInside)
            scrollView.addSubview(btn)
        }
        scrollView.contentSize = CGSize(width: 0, height: btnY+100)
    }
    
    lazy var scrollView = UIScrollView()
    lazy var alertLa: UILabel = {
        let la = UILabel()
        la.text = "AEAlertView"
        la.font = UIFont.systemFont(ofSize: 13)
        la.textAlignment = .center
        return la
    }()
    lazy var alertFieldLa: UILabel = {
        let la = UILabel()
        la.text = "AEAlertFieldView"
        la.font = UIFont.systemFont(ofSize: 13)
        la.textAlignment = .center
        return la
    }()
    lazy var alertCustomLa: UILabel = {
        let la = UILabel()
        la.text = "AEAlertCustomView"
        la.font = UIFont.systemFont(ofSize: 13)
        la.textAlignment = .center
        return la
    }()
    
    @objc private func alertClick(btn: UIButton) {
        switch btn.tag {
        case 0: alertType1()
        case 1: alertType2()
        case 2: alertType3()
        case 3: alertType4()
        case 4: alertType5()
        case 5: alertType6()
        case 6: alertType7()
        case 7: alertType8()
        default:
            break
        }
    }
    
    @objc private func alertFieldClick(btn: UIButton) {
        switch btn.tag {
        case 0: alertFieldType1()
        case 1: alertFieldType2()
        case 2: alertFieldType3()
        case 3: alertFieldType4()
        case 4: alertFieldType5()
        case 5: alertFieldType6()
        case 6: alertFieldType7()
        case 7: alertFieldType8()
        default:
            break
        }
    }
    
    @objc private func alertCustomClick(btn: UIButton) {
        switch btn.tag {
        case 0: alertCustomType1()
        case 1: alertCustomType2()
        case 2: alertCustomType3()
        default:
            break
        }
    }
    
}
