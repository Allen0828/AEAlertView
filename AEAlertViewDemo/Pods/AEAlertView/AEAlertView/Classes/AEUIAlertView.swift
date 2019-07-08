//
//  AEUIAlertView.swift
//  AEAlertView
//
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2017年 Allen. All rights reserved.
//  仿系统UI 按钮之间有线条分割 按钮无边框

import UIKit

/// 弹窗样式 请查看 AEAlertView 的 enum AEAlertViewStyle

/// 主题  确认按钮红色 cancal按钮灰色
public class AEUIAlertView: UIView {
    
    /// 只有一个按钮时 默认取消样式 不会进行回调 多个按钮时 数组第一个不回调
    public class func cancel(_ title: String?, _ message: String?, _ actions: [String], handler:((AEAlertAction)->Void)?) {
        
        let view = AEUIAlertView(title: title, message: message)
        
        if actions.count == 1 {
            let action = AEAlertAction(title: actions[0], style: .Default) { (action) in
                view.close()
            }
            view.actions = [action]
        } else if actions.count == 2 {
            let cancel = AEAlertAction(title: actions[0], style: .Cancel) { (action) in
                view.close()
            }
            let submit = AEAlertAction(title: actions[1], style: .Default) { (action) in
                if handler != nil {
                    handler!(action)
                }
                view.close()
            }
            view.actions = [cancel, submit]
        }
        view.show()
    }
    
    /// 只有一个按钮时 按钮为确定样式 回调所有 点击事件
    public class func show(_ title: String?, _ message: String?, _ actions: [String], handler:((AEAlertAction)->Void)?) {
        
        let view = AEUIAlertView(title: title, message: message)
        
        if actions.count == 1 {
            let action = AEAlertAction(title: actions[0], style: .Default) { (action) in
                if handler != nil {
                    handler!(action)
                }
                view.close()
            }
            view.actions = [action]
        } else if actions.count == 2 {
            let cancel = AEAlertAction(title: actions[0], style: .Cancel) { (action) in
                if handler != nil {
                    handler!(action)
                }
                view.close()
            }
            let submit = AEAlertAction(title: actions[1], style: .Default) { (action) in
                if handler != nil {
                    handler!(action)
                }
                view.close()
            }
            view.actions = [cancel,submit]
        }
        view.show()
    }
    
    /// 有输入框样式  回调会将文字传过去 如果有两个按钮 第一按钮没有回调
    public class func showAlertTextField(_ title: String?, _ message: String?, _ placeholder: String?, text: String = "",  _ actions: [String], handler: ((String)->Void)?) {
        
        let view = AEUIAlertView(title: title, message: message)
        
        let field = UITextField()
        field.placeholder = placeholder
        field.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        field.layer.cornerRadius = 4
        field.layer.masksToBounds = true
        field.font = UIFont.systemFont(ofSize: 14)
        if text.count > 0 {
            field.text = text
        }
        
        let left = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: 20))
        field.leftView = left
        field.tintColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        field.leftViewMode = .always
        
        view.setContent(field, Int(UIScreen.main.bounds.size.width - 68 - 40), 40)
        
        if actions.count == 1 {
            let action = AEAlertAction(title: actions[0], style: .Default) { (action) in
                if handler != nil {
                    handler!(field.text ?? "")
                }
                view.close()
            }
            view.actions = [action]
        } else if actions.count == 2 {
            let cancel = AEAlertAction(title: actions[0], style: .Cancel) { (action) in
                view.close()
            }
            let submit = AEAlertAction(title: actions[1], style: .Default) { (action) in
                if handler != nil {
                    handler!(field.text ?? "")
                }
                view.close()
            }
            view.actions = [cancel,submit]
        }
        view.show()
    }
    
    
    public func show() {
        setActions()
        UIApplication.shared.delegate?.window??.addSubview(self)
        
        baseView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        baseView.alpha = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
                        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                        self.baseView.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.baseView.alpha = 1
        },
                       completion: nil)
    }
    
    public func close() {
        UIView.animate(withDuration: 0.2, animations: {
            self.baseView.alpha = 0
            self.alpha = 0
        }) { (_) in
            for view in self.subviews {
                view.removeFromSuperview()
            }
            self.removeFromSuperview()
        }
    }
    
    public var title: String? {
        didSet {
            if title?.count ?? 0 > 0 {
                baseView.titleTopMargin = 16
            } else {
                baseView.titleTopMargin = 0
            }
            baseView.titleLabel.text = title
        }
    }
    
    public var message: String? {
        didSet {
            baseView.messageTextView.text = message
        }
    }
    
    /// 弹窗左右距离屏幕的最大宽度 默认左右34 如果小于150或大于屏幕宽 会自动使用默认值
    open var maximumWidth: Int? {
        didSet {
            setMaximumWidth(width: maximumWidth ?? 0)
        }
    }
    
    public var actions: [AEAlertAction]?
    
    public func setContent(_ view: UIView, _ width: Int, _ height: Int) {
        
        baseView.setContentView(contentView: view, width: NSInteger(width), height: NSInteger(height))
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public init(title: String?, message: String?) {
        let frame = CGRect(x: 0, y: 0,
                           width: UIScreen.main.bounds.size.width,
                           height: UIScreen.main.bounds.size.height)
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        config(title ?? "", message ?? "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    private var baseView: AEBaseAlertView!
    
    // 横向线条
    let line = UIView()
    // 竖向线条
    let row = UIView()
    
}

extension AEUIAlertView {
    
    private func config(_ title: String, _ message: String) {
        
        baseView = AEBaseAlertView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        addSubview(baseView)
        
        maximumWidth = Int(UIScreen.main.bounds.size.width) - 68
        
        baseView.titleLabel.text = title
        if title.count > 0 {
            baseView.titleTopMargin = 16
        } else {
            baseView.titleTopMargin = 0
        }
        baseView.messageTextView.text = message
        if message.count > 0 {
            baseView.messageTopMargin = 12
            baseView.contentViewTopMargin = 6
        } else {
            baseView.messageTopMargin = 0
            baseView.contentViewTopMargin = 0
        }
        
        
        // 在没有内容之前 间距默认为0
        baseView.alertBackgroundView.backgroundColor = UIColor.white
        baseView.contentViewBottomMargin = 10
        baseView.titleLabel.textColor = UIColor.black
        baseView.messageTextView.textColor = UIColor.darkGray
        baseView.buttonBottomMargin = 0
        baseView.buttonSuperMargin = 2
        
        line.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        baseView.actionButtonContainerView.addSubview(line)
        
        row.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        baseView.actionButtonContainerView.addSubview(row)
        
        /// 在此页面监听 键盘弹出事件
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// 设置按钮
    private func setActions() {
        let buttons = NSMutableArray()
        
        guard let actionsCount = actions?.count else {
            return
        }
        if actionsCount == 1 {
            row.isHidden = true
        }
        
        for i in 0..<actionsCount {
            
            let action = actions![i]
            let button = AEAlertViewButton(type: .custom)
            
            button.contentEdgeInsets = UIEdgeInsets(top: -15, left: -15, bottom: -15, right: -15)
            button.tag = i
            button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
            
            button.isEnabled = action.enabled ?? true
            button.type = AEAlertViewButtonType.Filled
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(action.title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            
            if action.style == AEAlertActionStyle.Cancel {
                button.setTitleColor(UIColor.lightGray, for: .normal)
                button.setTitleColor(UIColor.lightGray, for: .highlighted)
                
            }else if action.style == AEAlertActionStyle.Destructive {
                
                button.setTitleColor(UIColor.orange, for: .normal)
                button.setTitleColor(UIColor.orange, for: .highlighted)
                
            } else {
                // 玫瑰红
                button.setTitleColor(UIColor(red: 232/255, green: 70/255, blue: 83/255, alpha: 1.0), for: .normal)
                button.setTitleColor(UIColor(red: 232/255, green: 70/255, blue: 83/255, alpha: 1.0), for: .highlighted)
            }
            
            buttons.add(button)
            action.actionButton = button
        }
        baseView.actionButtons = buttons as? [AEAlertViewButton]
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.line.frame = CGRect(x: 0, y: 0, width: self.baseView.actionButtonContainerView.frame.size.width, height: 1)
            self.row.frame = CGRect(x: self.baseView.actionButtonContainerView.frame.size.width / 2, y: 0, width: 1, height: self.baseView.actionButtonContainerView.frame.size.height)
        }
    }
    
    /// 按钮点击回调
    @objc private func actionButtonPressed(button: AEAlertViewButton) {
        
        let action = self.actions![button.tag]
        if action.handler != nil {
            action.handler!(action)
        }
    }
    
    /// 键盘通知
    @objc private func keyBoardWillShow(_notification: Notification){
        
        let dict = _notification.userInfo
        guard (dict?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect) != nil else {
            return
        }
        guard (dict?["UIKeyboardFrameEndUserInfoKey"] as? CGRect) != nil else {
            return
        }
        if _notification.name.rawValue == "UIKeyboardWillShowNotification" {
            
            self.transform = CGAffineTransform(translationX: 0, y: -180)
        }else {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    private func setMaximumWidth(width: Int) {
        if width < 149 || CGFloat(width) > UIScreen.main.bounds.size.width { return }
        baseView.maximumWidth = CGFloat(width)
    }
}
