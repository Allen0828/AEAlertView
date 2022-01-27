//
//  AlertView.swift
//  AlertViewDemo
//
//  Created by 锋 on 2020/12/28.
//  Copyright © 2020 张其锋. All rights reserved.
//

import UIKit
import AEAlertView


final class AlertView: AEAlertView {
    /// 只有一个按钮时 按钮为确定样式 (回调所有 点击事件)
    static public func show(_ title: String?, _ message: String?, _ actions: [String], handler:((AEAlertAction)->Void)?) {
        
        let view = AlertView(style: .custom, title: title, message: message)
        if actions.count == 1 {
            let action = AEAlertAction(title: actions[0], style: .defaulted) { (action) in
                handler?(action)
                view.dismiss()
            }
            action.titleColor = .red
            
            view.addAction(action: action)
        } else if actions.count == 2 {
            let cancel = AEAlertAction(title: actions[0], style: .cancel) { (action) in
                handler?(action)
                view.dismiss()
            }
            cancel.titleColor = .red
            cancel.cancelLayerBorderColor = .red
            cancel.layerBorderWidth = 1
            let submit = AEAlertAction(title: actions[1], style: .defaulted) { (action) in
                handler?(action)
                view.dismiss()
            }
            submit.titleColor = .red
            submit.cancelLayerBorderColor = .blue
            submit.layerBorderWidth = 1
            view.addAction(action: cancel)
            view.addAction(action: submit)
        } else if actions.count == 3 {
            
            let cancel = AEAlertAction(title: actions[0], style: .cancel) { (action) in
                view.dismiss()
            }
            let submit = AEAlertAction(title: actions[1], style: .cancel) { (action) in
                handler?(action)
                view.dismiss()
            }
            let didAction = AEAlertAction(title: actions[2], style: .defaulted) { (action) in
                handler?(action)
                view.dismiss()
            }
            view.addAction(action: cancel)
            view.addAction(action: submit)
            view.addAction(action: didAction)
        }
        view.show()
    }
    
    override init(style: AEAlertViewStyle, title: String?, message: String?) {
        super.init(style: style, title: title, message: message)
        
        titleTopMargin = title?.count ?? 0 > 0 ? 6 : 0
        messageTopMargin = message?.count ?? 0 > 0 ? 6 : 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
