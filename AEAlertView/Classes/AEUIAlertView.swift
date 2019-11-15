//
//  AEAlertView.swift
//  AEAlertView
//
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2017年 Allen. All rights reserved.
//  按钮没有圆角


//  ┌──────────────────────┐
//  |        title         |
//  |       message        |
//  |    animationView     |
//  |     contentView      |
//  |                      |
//  |──────────┯───────────|
//  └──────────┷───────────┙

import UIKit

/// style
public enum AEUIAlertViewStyle {
    case defaulted,
    textField
}

open class AEUIAlertView: UIView {

    public func show() {
        showAlert()
    }
    public func dismiss() {
        dismissAlert()
    }
    
    /// 添加action
    public func addAction(action: AEAlertAction) {
        actions.append(action)
    }
    // 手动重置按钮
    public func resetActions() {
        createActions()
    }
    /// AEAlertAction 无法满足使用时 也可以使用 AEAlertViewButton 优先使用actions -> buttons
    public func addButton(button: AEAlertViewButton) {
        buttons.append(button)
    }
    /// 设置animationView 推荐宽小于等于 UIScreen.main.bounds.size.width - (24 * 2)
    public func set(animation: UIView, width: CGFloat, height: CGFloat) {
        alertView.setAnimation(view: animation, width: width, height: height)
    }
    /// 设置contentView 推荐宽小于等于 UIScreen.main.bounds.size.width - (24 * 2)
    public func set(content: UIView, width: CGFloat, height: CGFloat) {
        alertView.setContent(view: content, width: width, height: height)
    }
    
    // MARK: -属性
    /// show动画时间 默认 0.5 如果为0 取消动画
    public var showDuration: CGFloat = 0.5
    /// dismiss动画时间 默认 0.25 如果为0 取消动画
    public var dismissDuration: CGFloat = 0.25
    /// 弹窗最大宽度
    public var alertMaximumWidth: CGFloat = UIScreen.main.bounds.size.width - (24 * 2) {
        didSet { alertView.maximumWidth = alertMaximumWidth }
    }
    /// 点击灰色区域 结束编辑
    public var isClickFinishEditing: Bool = true
    /// 是否监听键盘的事件
    public var isObserverKeyboard: Bool = true
    /// action 分割线颜色
    public var actionSplitLine: UIColor? = UIColor(white: 0.88, alpha: 1.0) {
        didSet {
            alertView.actionSplitLine = actionSplitLine ?? UIColor(white: 0.88, alpha: 1.0)
        }
    }
    
    /// title
    public var title: String? {
        didSet { alertView.titleLabel.text = title }
    }
    public var titleFont: UIFont? {
        didSet { alertView.titleLabel.font = titleFont ?? UIFont.init() }
    }
    public var titleColor: UIColor? {
        didSet { alertView.titleLabel.textColor = titleColor }
    }
    public var titleBackgroundColor: UIColor? {
        didSet { alertView.titleLabel.backgroundColor = titleBackgroundColor }
    }
    public var titleAlignment: NSTextAlignment = .center {
        didSet { alertView.titleLabel.textAlignment = titleAlignment }
    }
    // titleLabel 距离alert背景框 上方间距 默认8
    public var titlePadding: CGFloat = 8 {
        didSet { alertView.titlePadding = titlePadding }
    }
    // titleLabel 距离alert背景框 左右的距离 默认16
    public var titleTopMargin: CGFloat = 8 {
        didSet { alertView.titleTopMargin = titleTopMargin }
    }
    
    /// message
    public var message: String? {
        didSet { alertView.messageTextView.text = message ?? "" }
    }
    public var messageFont: UIFont? {
        didSet { alertView.messageTextView.font = messageFont }
    }
    public var messageColor: UIColor? {
        didSet { alertView.messageTextView.textColor = messageColor }
    }
    public var messageBackgroundColor: UIColor? {
        didSet { alertView.messageTextView.backgroundColor = messageBackgroundColor }
    }
    public var messageAlignment: NSTextAlignment = .center {
        didSet { alertView.messageTextView.textAlignment = messageAlignment }
    }
    /// 内容高度 如果内容超出设置的高 内容可以滑动 不设置会自动计算文字高度
    public var messageHeight: CGFloat = 0 {
        didSet { alertView.messageHeight = messageHeight }
    }
    /// 内容距离alert背景框 左右的距离 默认16
    public var messagePadding: CGFloat = 16 {
        didSet { alertView.messagePadding = messagePadding }
    }
    /// 内容top 距离 标题bottom 间距
    public var messageTopMargin: CGFloat = 6 {
        didSet { alertView.messageTopMargin = messageTopMargin }
    }
    
    /// 动画View Top 距离内容bottom 的间距
    public var animationViewTopMargin: CGFloat = 0 {
        didSet { alertView.animationViewTopMargin = animationViewTopMargin }
    }
    /// 自定义View Top 距离动画ViewBottom 的间距
    public var contentViewTopMargin: CGFloat = 0 {
        didSet { alertView.contentViewTopMargin = contentViewTopMargin }
    }
    /// 放置按钮的View top 距离自定义ViewBottom 的间距
    public var actionViewTopMargin: CGFloat = 0 {
        didSet { alertView.actionViewTopMargin = actionViewTopMargin }
    }
    /// 放置按钮的View botton 距离alertBotton 的间距
    public var actionViewBottomMargin: CGFloat = 0 {
        didSet { alertView.actionViewBottomMargin = actionViewBottomMargin }
    }
    
    /// action
    public var actions: [AEAlertAction] = []
    public var buttons: [AEAlertViewButton] = []
    public var actionHeight: CGFloat = 40 {
        didSet { alertView.actionHeight = actionHeight }
    }
    public var actionPadding: CGFloat = 8 {
        didSet { alertView.actionPadding = actionPadding }
    }
    public var actionMargin: CGFloat = 8 {
        didSet { alertView.actionMargin = actionMargin }
    }
    /// 两个按钮时 排列方式
    public var actionArrangementMode: AEButtonArrangementMode = .horizontal {
        didSet {
            alertView.actionArrangementMode = actionArrangementMode
        }
    }
    // MARK: actionType
    /// defaulted 字体
    public var buttonTitleFont: UIFont = UIFont.systemFont(ofSize: 15)
    /// defaulted 背景颜色
    public var buttonColor: UIColor? = UIColor.white
    /// defaulted 标题的颜色
    public var buttonTitleColor: UIColor? = UIColor.red
    
    /// cancel 字体
    public var cancelButtonTitleFont: UIFont = UIFont.systemFont(ofSize: 15)
    /// cancel 背景颜色
    public var cancelButtonColor: UIColor? = UIColor.white
    /// cancel 标题的颜色
    public var cancelButtonTitleColor: UIColor? = UIColor.darkGray

    /// destructive 字体
    public var destructiveButtonTitleFont: UIFont = UIFont.systemFont(ofSize: 15)
    /// destructive 背景色
    public var destructiveButtonColor: UIColor? = UIColor.white
    /// destructive 标题的颜色
    public var destructiveButtonTitleColor: UIColor? = UIColor.red
    
    // MARK: TextField
    // IF style==textField样式下 生效
    public var textField: UITextField = UITextField()
    /// 默认为 animationWidth-40 高36
    public var textFieldSize: CGSize?
    /// textField 是否跟随键盘移动
    public var textFieldFollowKeyboard: Bool = true
    /// textField距离键盘的间距 默认距离键盘 100
    public var textFieldBottomMargin: CGFloat = 100
    // ENDIF
    
    public override convenience init(frame: CGRect) {
        self.init(style: .defaulted, title: nil, message: nil)
    }
    public convenience init(style: AEUIAlertViewStyle) {
        self.init(style: style, title: nil, message: nil)
    }
    
    public init(style: AEUIAlertViewStyle, title: String?, message: String?) {
        let frame = CGRect(x: 0, y: 0,
                       width: UIScreen.main.bounds.size.width,
                       height: UIScreen.main.bounds.size.height)
        super.init(frame: frame)
        
        alertView = AEBaseAlertView(frame: frame)
        alertView.titleLabel.text = title
        alertView.messageTextView.text = message ?? ""
        alertView.alertStyle = .apple
        alertView.alertBackgroundView.backgroundColor = UIColor.white
        addSubview(alertView)
        
        if style == .textField {
            textField = UITextField(frame: CGRect(x: 0, y: 0, width: alertMaximumWidth - 24, height: 36))
            textField.borderStyle = .roundedRect
            textField.backgroundColor = UIColor(white: 0.899, alpha: 1.0)
            textField.placeholder = "请输入..."
            alertView.setAnimation(view: textField, width: alertMaximumWidth - 24, height: 36)
        }
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var alertView: AEBaseAlertView!
}

extension AEUIAlertView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isClickFinishEditing {
            self.endEditing(true)
        }
    }
    
    @objc private func keyBoardWillShow(_notification: Notification) {
        if !textFieldFollowKeyboard { return }
        let dict = _notification.userInfo
        guard (dict?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect) != nil else {
            return
        }
        guard (dict?["UIKeyboardFrameEndUserInfoKey"] as? CGRect) != nil else {
            return
        }
        if _notification.name.rawValue == "UIKeyboardWillShowNotification" {
            self.transform = CGAffineTransform(translationX: 0, y: CGFloat(-textFieldBottomMargin))
        }else {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
}

extension AEUIAlertView {
    private func showAlert() {
        createActions()
        if #available(iOS 13, *) {
            UIApplication.shared.keyWindow?.addSubview(self)
        } else {
            UIApplication.shared.delegate?.window??.addSubview(self)
        }
        if isObserverKeyboard {
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        if showDuration == 0.0 {
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            return
        }
        alertView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        alertView.alpha = 0
        
        UIView.animate(withDuration: TimeInterval(showDuration),
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
                    self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                    self.alertView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.alertView.alpha = 1
        }, completion: nil)
    }
    private func dismissAlert() {
        if !Thread.isMainThread { return }
        NotificationCenter.default.removeObserver(self)
        
        if dismissDuration == 0.0 {
            for view in self.subviews {
                view.removeFromSuperview()
            }
            self.removeFromSuperview()
            return
        }
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
    
    private func createActions() {
        if actions.count == 0 {
            alertView.actionList = buttons
            return
        }
        var alertButtons: [AEAlertViewButton] = []
        for (idx, action) in actions.enumerated() {
            let btn = AEAlertViewButton(type: .custom)
            btn.tag = idx
            btn.contentEdgeInsets = UIEdgeInsets(top: -15, left: -15, bottom: -15, right: -15)
            btn.addTarget(self, action: #selector(actionPressed), for: .touchUpInside)
            btn.isEnabled = action.enabled ?? true
            btn.setTitle(action.title, for: .normal)
            if action.style == .defaulted {
                btn.setTitleColor(buttonTitleColor, for: .normal)
                btn.setTitleColor(buttonTitleColor, for: .highlighted)
                btn.setBackgroundColor(color: buttonColor ?? UIColor.red, state: .normal)
                btn.setBackgroundColor(color: buttonColor ?? UIColor.red, state: .highlighted)
                btn.titleLabel?.font = buttonTitleFont
            } else if action.style == .cancel {
                btn.setTitleColor(cancelButtonTitleColor, for: .normal)
                btn.setTitleColor(cancelButtonTitleColor, for: .highlighted)
                btn.setBackgroundColor(color: cancelButtonColor ?? UIColor.white, state: .normal)
                btn.setBackgroundColor(color: cancelButtonColor ?? UIColor.white, state: .highlighted)
                btn.titleLabel?.font = cancelButtonTitleFont
            } else {
                btn.setTitleColor(destructiveButtonTitleColor, for: .normal)
                btn.setTitleColor(destructiveButtonTitleColor, for: .highlighted)
                btn.setBackgroundColor(color: destructiveButtonColor ?? UIColor.red, state: .normal)
                btn.setBackgroundColor(color: destructiveButtonColor ?? UIColor.red, state: .highlighted)
                btn.titleLabel?.font = destructiveButtonTitleFont
            }
            action.actionButton = btn
            alertButtons.append(btn)
        }
        alertView.actionList = alertButtons
    }
    @objc private func actionPressed(button: AEAlertViewButton) {
        if button.tag < actions.count {
            actions[button.tag].handler?(actions[button.tag])
        }
    }
}
