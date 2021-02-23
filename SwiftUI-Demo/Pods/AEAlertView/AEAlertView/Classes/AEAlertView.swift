//  AEAlertView
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2017年 Allen. All rights reserved.

import UIKit

/// style 主要在于按钮展示的样式不同
public enum AEAlertViewStyle {
    case defaulted,
    custom
}

// custom =
//   ----------------------
//  |        title         |
//  |       message        |
//  |     contentView      |
//  |       customView     |
//  |                      |
//  | ┌──────┐   ┌──────┐  |
//  | └──────┙   └──────┙  |
//   ----------------------
// defaulted =
//  ┌──────────────────────┐
//  |        title         |
//  |       message        |
//  |      contentView     |
//  |      customView      |
//  |                      |
//  |──────────┯───────────|
//  └──────────┷───────────┙


/// 提供快速的使用
extension AEAlertView {
    /// 快速创建一个AlertView
    /// - Parameters:
    ///   - title: 标题
    ///   - actions: 按钮 默认数组第一个为AEAlertActionStyle.cancel样式
    ///   - message: 内容 没设置高度 会根据文字高度改变弹窗的高度
    ///   - bgImage: 背景图片 (默认当图比内容高时 使用图的高 当内容比图高时 使用内容的高)
    ///   - bgImageBottomMargin: 如果设置了 背景图片会自适应高度 当图片过小时 可能会导致文字显示不完整
    ///   - defaultActionColor: default按钮的文字颜色 默认深蓝
    ///   - handler: 按钮的回调 action.tag 对应数组的下标 在回调结束后 自动关闭alertView
    static public func show(title: String?, actions: [String], message: String?, bgImage: UIImage? = UIImage(), bgImageBottomMargin: CGFloat = -1, titleColor: UIColor? = UIColor.black, messageColor: UIColor? = UIColor.darkGray, defaultActionColor: UIColor? = nil, handler: ((AEAlertAction)->())?) {
        let alert = AEAlertView(style: .defaulted, title: title, message: message)
        alert.alertView.backgroundImage.image = bgImage
        if bgImageBottomMargin != -1 {
            alert.backgroundImageBottomMargin = bgImageBottomMargin
        }
        alert.titleColor = titleColor
        alert.messageColor = messageColor
        if defaultActionColor != nil {
            alert.buttonTitleColor = defaultActionColor
        }
        for (idx,item) in actions.enumerated() {
            if idx == 0 {
                let cancel = AEAlertAction.init(title: item, style: .cancel) { (action) in
                    handler?(action)
                    alert.dismiss()
                }
                alert.addAction(action: cancel)
            } else {
                let def = AEAlertAction.init(title: item, style: .defaulted) { (action) in
                    handler?(action)
                    alert.dismiss()
                }
                alert.addAction(action: def)
            }
        }
        alert.show()
    }
    
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
    /// 手动重置按钮
    public func resetActions() {
        createActions()
    }
    /// 清除原有的按钮
    public func removeActions() {
        actions = []
        buttons = []
        createActions()
    }
    /// AEAlertAction 无法满足使用时 也可以使用 AEAlertViewButton 优先使用actions -> buttons
    public func addButton(button: AEAlertViewButton) {
        buttons.append(button)
    }
    /// 设置contentView 推荐宽小于等于 UIScreen.main.bounds.size.width - (24 * 2)
    public func set(content: UIView, width: CGFloat, height: CGFloat) {
        alertView.setContent(view: content, width: width, height: height)
    }
    /// 设置customView 推荐宽小于等于 UIScreen.main.bounds.size.width - (24 * 2)
    public func set(custom: UIView, width: CGFloat, height: CGFloat) {
        alertView.setCustom(view: custom, width: width, height: height)
    }
    /// 使用路径设置背景图片 支持GIF
    public func setBackgroundImage(contentsOf file: String?) {
        alertView.setBackgroundImage(contentsOf: file)
    }
}


open class AEAlertView: UIView {

    /// show动画时间 默认 0.5 如果为0 取消动画
    public var showDuration: CGFloat = 0.5
    /// dismiss动画时间 默认 0.25 如果为0 取消动画
    public var dismissDuration: CGFloat = 0.25
    
    //MARK: 如果自定义了输入框
    /// 点击灰色区域 结束编辑
    public var isClickFinishEditing: Bool = true
    /// 是否监听键盘的事件  注: 当你设置contentView或customView时 包含输入框 可能会使用到该属性
    public var isObserverKeyboard: Bool = true
    /// textField 是否跟随键盘移动 注: 当你设置contentView或customView时 包含输入框 可能会使用到该属性
    public var textFieldFollowKeyboard: Bool = true
    /// textField距离键盘的间距 默认距离键盘 100 注: 当你设置contentView或customView时 包含输入框 可能会使用到该属性
    public var textFieldBottomMargin: CGFloat = 100
    
    /// 设置背景图片
    public var backgroundImage: UIImage? {
        didSet { alertView.backgroundImage.image = backgroundImage }
    }
    
    // MARK: 设置文字属性
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
    
    // MARK: 位置设置
    /// 背景图片的高度 不设置会使用图片本身高度 注：只有在image不为空时生效
    public var backgroundImageHeight: CGFloat = 0 {
        didSet { alertView.backgroundImageHeight = backgroundImageHeight }
    }
    /// 背景图片距离弹窗底部间距 如果为0 弹窗会被image覆盖 注：只有在image不为空时生效 并且为0时 按钮背景色为透明才能看到效果
    public var backgroundImageBottomMargin: CGFloat = 0 {
        didSet { alertView.backgroundImageBottomMargin = backgroundImageBottomMargin }
    }
    /// titleLabel 距离alert背景框 上方间距 默认8
    public var titlePadding: CGFloat = 8 {
        didSet { alertView.titlePadding = titlePadding }
    }
    /// titleLabel 距离alert背景框 左右的距离 默认16
    public var titleTopMargin: CGFloat = 8 {
        didSet { alertView.titleTopMargin = titleTopMargin }
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
    /// 自定义View Top 距离动画ViewBottom 的间距
    public var contentViewTopMargin: CGFloat = 0 {
        didSet { alertView.contentViewTopMargin = contentViewTopMargin }
    }
    /// 动画View Top 距离内容bottom 的间距
    public var customViewTopMargin: CGFloat = 0 {
        didSet { alertView.customViewTopMargin = customViewTopMargin }
    }
    /// 放置按钮的View top 距离自定义ViewBottom 的间距
    public var actionViewTopMargin: CGFloat = 0 {
        didSet { alertView.actionViewTopMargin = actionViewTopMargin }
    }
    /// 放置按钮的View botton 距离alertBotton 的间距
    public var actionViewBottomMargin: CGFloat = 0 {
        didSet { alertView.actionViewBottomMargin = actionViewBottomMargin }
    }
    
    
    //MARK: action 注: 当你使用 AEAlertViewButton作为action时 所有按钮的属性都不会生效 需要你在初始化AEAlertViewButton时自行设置
    public var actionHeight: CGFloat = 40 {
        didSet { alertView.actionHeight = actionHeight }
    }
    /// 两个按钮时 排列方式
    public var actionArrangementMode: AEButtonArrangementMode = .horizontal {
        didSet {
            alertView.actionArrangementMode = actionArrangementMode
        }
    }
    /// cancel 字体
    public var cancelButtonTitleFont: UIFont = UIFont.systemFont(ofSize: 15)
    /// cancel 背景颜色
    public var cancelButtonColor: UIColor? = UIColor.clear
    /// cancel 标题的颜色
    public var cancelButtonTitleColor: UIColor? = UIColor.darkGray
    // 只在 AEAlertViewStyle == custom 才会生效
    /// cancel 描边颜色 默认为灰色
    public var cancelButtonLayerBorderColor: UIColor? = UIColor.darkGray
    /// cancel 描边宽度
    public var cancelButtonLayerBorderWidth: CGFloat = 1
    /// cancel 圆角 默认4
    public var cancelButtonCornerRadius: CGFloat = 4
    
    /// defaulted 字体
    public var buttonTitleFont: UIFont = UIFont.systemFont(ofSize: 15)
    /// defaulted 背景颜色
    public var buttonColor: UIColor? = UIColor.clear //(white: 0.97, alpha: 1.0)
    /// defaulted 标题的颜色
    public var buttonTitleColor: UIColor? = UIColor(red: 26/255, green: 104/255, blue: 254/255, alpha: 1)
    // 只在 AEAlertViewStyle == custom 才会生效
    /// defaulted 描边颜色 默认为浅蓝色
    public var buttonLayerBorderColor: UIColor? = UIColor(red: 26/255, green: 104/255, blue: 254/255, alpha: 1)
    /// defaulted 描边宽度 默认1
    public var buttonLayerBorderWidth: CGFloat = 1
    /// defaulted 圆角 默认4
    public var buttonCornerRadius: CGFloat = 4
    
    /// other 字体
    public var otherButtonTitleFont: UIFont = UIFont.systemFont(ofSize: 15)
    /// other 背景色
    public var otherButtonColor: UIColor? = UIColor.clear //(white: 0.97, alpha: 1.0)
    /// other 标题的颜色
    public var otherButtonTitleColor: UIColor? = UIColor(red: 26/255, green: 104/255, blue: 254/255, alpha: 1)
    // 只在 AEAlertViewStyle == custom 才会生效
    /// other 描边颜色 默认为浅蓝色
    public var otherButtonLayerBorderColor: UIColor? = UIColor(red: 26/255, green: 104/255, blue: 254/255, alpha: 1)
    /// other 描边宽度
    public var otherButtonLayerBorderWidth: CGFloat = 1
    /// other 圆角 默认4
    public var otherButtonCornerRadius: CGFloat = 4
    
    
    /// baseAlert 只能设置属性 不能改变其值
    public var alertView: AEBaseAlertView!
    private var actions: [AEAlertAction] = []
    private var buttons: [AEAlertViewButton] = []
    private var alertStyle: AEAlertViewStyle = .defaulted
    
    public override convenience init(frame: CGRect) {
        self.init(style: .defaulted, title: nil, message: nil)
    }
    public convenience init(style: AEAlertViewStyle) {
        self.init(style: style, title: nil, message: nil)
    }
    public init(style: AEAlertViewStyle, title: String?, message: String?) {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        alertStyle = style
        alertView = AEBaseAlertView(frame: frame)
        alertView.titleLabel.text = title
        alertView.messageTextView.text = message ?? ""
        if style == .custom {
            alertView.alertStyle = .custom
        } else {
            alertView.alertStyle = .apple
        }
        addSubview(alertView)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("AEAlertView-deinit")
    }
    
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

extension AEAlertView {
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
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
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
                    self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                    self.alertView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.alertView.alpha = 1
        }, completion: nil)
    }
    private func dismissAlert() {
        if !Thread.isMainThread { return }
        if isObserverKeyboard {
            NotificationCenter.default.removeObserver(self)
        }
        actions = []
        buttons = []
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
            if action.tag == -1 {
                action.tag = idx
            }
            if action.style == .cancel{
                btn.setTitleColor(cancelButtonTitleColor, for: .normal)
                btn.setTitleColor(cancelButtonTitleColor, for: .highlighted)
                btn.setBackgroundColor(color: cancelButtonColor ?? UIColor(white: 0.97, alpha: 1.0), state: .normal)
                btn.setBackgroundColor(color: cancelButtonColor ?? UIColor(white: 0.97, alpha: 1.0), state: .highlighted)
                btn.titleLabel?.font = cancelButtonTitleFont
                if alertStyle == .custom {
                    btn.layer.cornerRadius = cancelButtonCornerRadius
                    btn.layer.borderWidth = cancelButtonLayerBorderWidth
                    btn.layer.borderColor = (cancelButtonLayerBorderColor ?? UIColor.clear).cgColor
                }
            } else if action.style == .defaulted {
                btn.setTitleColor(buttonTitleColor, for: .normal)
                btn.setTitleColor(buttonTitleColor, for: .highlighted)
                btn.setBackgroundColor(color: buttonColor ?? UIColor.blue, state: .normal)
                btn.setBackgroundColor(color: buttonColor ?? UIColor.red, state: .highlighted)
                btn.titleLabel?.font = buttonTitleFont
                if alertStyle == .custom {
                    btn.layer.cornerRadius = buttonCornerRadius
                    btn.layer.borderWidth = buttonLayerBorderWidth
                    btn.layer.borderColor = (buttonLayerBorderColor ?? UIColor.clear).cgColor
                }
            } else {
                btn.setTitleColor(otherButtonTitleColor, for: .normal)
                btn.setTitleColor(otherButtonTitleColor, for: .highlighted)
                btn.setBackgroundColor(color: otherButtonColor ?? UIColor.red, state: .normal)
                btn.setBackgroundColor(color: otherButtonColor ?? UIColor.red, state: .highlighted)
                btn.titleLabel?.font = otherButtonTitleFont
                if alertStyle == .custom {
                    btn.layer.cornerRadius = otherButtonCornerRadius
                    btn.layer.borderWidth = otherButtonLayerBorderWidth
                    btn.layer.borderColor = (otherButtonLayerBorderColor ?? UIColor.clear).cgColor
                }
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
