//
//  AEUIAlertView.swift
//  AE抖音
//
//  Created by 张其锋 on 2019/6/25.
//  Copyright © 2019 张其锋. All rights reserved.
//

import UIKit

open class AEUIAlertView: UIView {
    
    open func show() {
        showUIAlert()
    }
    open func close() {
        closeUIAlert()
    }
    ///添加action AddAction
    open func addAction(action: AEAlertAction) {
        actions.append(action)
    }
    ///推荐宽度为屏幕款 * 0.7
    open func setContentView(contentView: UIView, width: CGFloat, height: CGFloat) {
        alertView.setContentView(contentView: contentView, width: NSInteger(width), height: NSInteger(height))
    }
    
    /// 标题
    open var title: String = "" {
        didSet {
            alertView.titleLabel.text = title
        }
    }
    /// 内容
    open var message: String = "" {
        didSet {
            alertView.messageTextView.text = message
        }
    }
    /// Title字体
    open var titleFont: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            alertView.titleLabel.font = titleFont
        }
    }
    /// message字体
    open var messageFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            alertView.messageTextView.font = messageFont
        }
    }
    /// Title字体颜色
    open var titleColor: UIColor = UIColor.black {
        didSet {
            alertView.titleLabel.textColor = titleColor
        }
    }
    /// message字体颜色
    open var messageColor: UIColor = UIColor.darkGray {
        didSet {
            alertView.messageTextView.textColor = messageColor
        }
    }
    
    /// 按钮分割线的颜色
    open var separatorColor: UIColor = UIColor.lightGray {
        didSet {
            acrossView.backgroundColor = separatorColor
            verticalView.backgroundColor = separatorColor
        }
    }
    /// 所有按钮
    open private(set) var actions: [AEAlertAction] = []
    
    /// 确定按钮的背景颜色
    open var buttonColor: UIColor = UIColor.white
    /// 取消按钮的背景颜色
    open var cancelButtonColor: UIColor = UIColor.white
    /// 确定按钮标题的颜色
    open var buttonTitleColor: UIColor = UIColor.blue
    /// 取消按钮标题的颜色
    open var cancelButtonTitleColor: UIColor = UIColor.blue
    /// 按钮的Font 所有按钮
    open var buttonTitleFont: UIFont = UIFont.systemFont(ofSize: 14)
    
    
    public init(title: String?, message: String?) {
        let frame = CGRect(x: 0, y: 0,
                           width: UIScreen.main.bounds.size.width,
                           height: UIScreen.main.bounds.size.height)
        super.init(frame: frame)
        
        buttonTitleFont = UIFont.systemFont(ofSize: 14)
        
        alertView = AEBaseAlertView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        alertView.alertBackgroundView.backgroundColor = UIColor.white
        
        alertView.titleLabel.text = title
        alertView.messageTextView.text = message
        alertView.titleLabel.textColor = UIColor.darkGray
        alertView.messageTextView.textColor = UIColor.lightGray
        
        alertView.titleTopMargin = 16
        alertView.buttonBottomMargin = 0
        
        addSubview(alertView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var alertView: AEBaseAlertView!
    // 当只有两个按钮时的分割线
    private let acrossView = UIView()
    private let verticalView = UIView()
    
}


extension AEUIAlertView {
    /// 设置Button
    private func createActionButtons() {
        
        var buttons: [AEAlertViewButton] = []
        for i in 0..<actions.count {
            
            let action = actions[i]
            let button = AEAlertViewButton(type: .custom)
            
            button.contentEdgeInsets = UIEdgeInsets(top: -15, left: -15, bottom: -15, right: -15)
            button.tag = i
            button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
            button.isEnabled = action.enabled ?? true
            button.type = AEAlertViewButtonType.Filled
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(action.title, for: .normal)
            button.titleLabel?.font = buttonTitleFont
            
            if action.style == AEAlertActionStyle.Cancel {
                
                button.setTitleColor(cancelButtonTitleColor, for: .normal)
                button.setTitleColor(cancelButtonTitleColor, for: .highlighted)
                button.setBackgroundColor(color: cancelButtonColor, state: .normal)
                button.setBackgroundColor(color: cancelButtonColor, state: .highlighted)
                
            } else {
                
                button.setTitleColor(buttonTitleColor, for: .normal)
                button.setTitleColor(buttonTitleColor, for: .highlighted)
                button.setBackgroundColor(color: buttonColor, state: .normal)
                button.setBackgroundColor(color: buttonColor, state: .highlighted)
            }
            buttons.append(button)
            action.actionButton = button
        }
        alertView?.actionButtons = buttons
        
        // 根据按钮数量 添加分割线
        if buttons.count == 1 {
            acrossView.backgroundColor = separatorColor
            alertView.actionButtonContainerView.addSubview(acrossView)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                self.acrossView.frame = CGRect(x: 0, y: 0, width: self.alertView.actionButtonContainerView.frame.size.width, height: 1)
            }
        } else if buttons.count == 2 {
            acrossView.backgroundColor = separatorColor
            verticalView.backgroundColor = separatorColor
            alertView.actionButtonContainerView.addSubview(acrossView)
            alertView.actionButtonContainerView.addSubview( verticalView)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                self.acrossView.frame = CGRect(x: 0, y: 0, width: self.alertView.actionButtonContainerView.frame.size.width, height: 1)
                self.verticalView.frame = CGRect(x: self.alertView.actionButtonContainerView.frame.size.width / 2, y: 0, width: 1, height: self.alertView.actionButtonContainerView.frame.size.height)
            }
        }
    }
    
    /// 展示
    private func showUIAlert() {
        createActionButtons()
        UIApplication.shared.delegate?.window??.addSubview(self)
        
        alertView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        alertView.alpha = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
                        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                        self.alertView.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.alertView.alpha = 1
        },
                       completion: nil)
    }
    
    /// 关闭
    private func closeUIAlert() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.alertView.alpha = 0
            self.alpha = 0
        }) { (finished) in
            for view in self.subviews {
                view.removeFromSuperview()
            }
            self.removeFromSuperview()
        }
    }
    
    @objc private func actionButtonPressed(button: AEAlertViewButton) {
        
        let action = self.actions[button.tag]
        if action.handler != nil {
            action.handler!(action)
        }
    }
    
}


