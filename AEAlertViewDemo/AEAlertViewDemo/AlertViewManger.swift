//
//  AlertViewManger.swift
//  AEAlertViewDemo
//
//  Created by Allen on 2018/9/28.
//  Copyright © 2018年 Allen. All rights reserved.
//

import UIKit
//import AEAlertView

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

