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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var btnY = 80.0
        
        for i in 0..<6 {
            let btn = UIButton()
            btn.setTitle("Style \(i)", for: .normal)
            btn.backgroundColor = UIColor.blue
            btn.tag = i
            btn.frame = CGRect(x: 100, y: btnY, width: 100, height: 40)
            btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            
            view.addSubview(btn)
            btnY += 45
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let view = AEAlertView(alertViewStyle: .Default)
        view.title = "title"
        view.message = "message, message, message, message,-----11111message, message, message"
//        view.messageHeight = 57
        
        let cancel = AEAlertAction(title: "cancel", style: .Cancel) { (action) in
            view.close()
        }
        
        view.addAction(action: cancel)
        view.show()
    }

    @objc private func btnClick(btn: UIButton) {
        
        let view = UserView(alertViewStyle: .Default, title: "1111", message: "22222")

        switch btn.tag {
        case 0:
            view.title = "默认标题"
            view.message = "默认内容"

            let cancel = AEAlertAction(title: "cancel", style: .Cancel) { (action) in
                view.close()
                print("cancel 点击")
            }
            view.addAction(action: cancel)

            let confirm = AEAlertAction(title: "confirm", style: .Default) { (action) in

                print("confirm 点击")
            }
            view.addAction(action: confirm)

        case 1:
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
            view.buttonLayerBorderColor = UIColor.blue


            let cancel = AEAlertAction(title: "cancel", style: .Cancel) { (action) in
                view.close()
                print("cancel 点击")
            }
            view.addAction(action: cancel)

            let confirm = AEAlertAction(title: "confirm", style: .Default) { (action) in

                print("confirm 点击")
            }
            view.addAction(action: confirm)

        case 2:
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

        case 3:
            view.title = "自定义view"
            view.message = "当有特殊需求时 您可以自定义contentView When there are special needs, you can customize contentView."

            let content = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.7, height: 80))
            content.backgroundColor = UIColor.blue

            view.setContentView(contentView: content, width: UIScreen.main.bounds.size.width * 0.7, height: 80)

            let cancel = AEAlertAction(title: "cancel", style: .Cancel) { (action) in
                view.close()
                print("cancel 点击")
            }
            view.addAction(action: cancel)

            let confirm = AEAlertAction(title: "confirm", style: .Default) { (action) in

                print("confirm 点击")
            }
            view.addAction(action: confirm)

        case 4:
            view.title = "自定义view"
            view.message = "密码框 自定label The password box has its own label."

            let content = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.6, height: 55))
            content.backgroundColor = UIColor.blue

            let label = UILabel(frame: CGRect(x: 0, y: 5, width: 100, height: 20))
            label.text = "输入密码"

            let textField = UITextField(frame: CGRect(x: 5, y: 30, width: 120, height: 23))
            textField.placeholder = "password"
            textField.layer.cornerRadius = 4
            textField.backgroundColor = UIColor.lightGray

            content.addSubview(label)
            content.addSubview(textField)

            view.setContentView(contentView: content, width: UIScreen.main.bounds.size.width * 0.6, height: 80)

            let cancel = AEAlertAction(title: "cancel", style: .Cancel) { (action) in
                view.close()
                print("cancel 点击")
            }
            view.addAction(action: cancel)

            let confirm = AEAlertAction(title: "confirm", style: .Default) { (action) in

                print("confirm 点击")
            }
            view.addAction(action: confirm)


        case 5:
            view.title = "多个按钮"
            view.message = "Multiple buttons arrangement"

            let cancel = AEAlertAction(title: "cancel", style: .Cancel) { (action) in
                view.close()
                print("cancel 点击")
            }
            view.addAction(action: cancel)

            let confirm = AEAlertAction(title: "confirm", style: .Default) { (action) in

                print("confirm 点击")
            }
            view.addAction(action: confirm)

            let other = AEAlertAction(title: "other", style: .Default) { (action) in
                print("other 点击")
            }
            view.addAction(action: other)


        default:
            break
        }



        view.show()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

