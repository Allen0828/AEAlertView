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
    ///   - handler: 按钮的回调 action.tag 对应数组的下标 在回调结束后 自动关闭alertView
    static public func show(title: String?, message: String?, actions: [String], bgImage: UIImage? = nil, bgImageBottomMargin: CGFloat = -1, handler: ((AEAlertAction)->())?) {
        let alert = AEAlertView(style: .defaulted, title: title, message: message)
        if (bgImage != nil) {
            alert.alertView.backgroundImage.image = bgImage
            if bgImageBottomMargin != -1 {
                alert.backgroundImageBottomMargin = bgImageBottomMargin
            }
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
    /// 如果你不想使用 show() 来展示 可以调用此方法后 在去手动将alert添加到你需要的视图中
    /// get current view You must add it to superview
    public func create() {
        createActions()
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
        createActions()
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
    public var backgroundImageMode: UIView.ContentMode = .scaleToFill {
        didSet { alertView.backgroundImage.contentMode = backgroundImageMode }
    }
     
    public var alertBackgroundColor: UIColor? {
        didSet { alertView.backgroundView.backgroundColor = alertBackgroundColor }
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
    /// 默认为2 不推荐修改此属性
    public var titleNumberOfLines: Int = 2 {
        didSet { alertView.titleLabel.numberOfLines = titleNumberOfLines }
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
    /// titleLabel 距离alert背景框 左右的距离 默认8
    public var titlePadding: CGFloat = 8 {
        didSet { alertView.titlePadding = titlePadding }
    }
    /// titleLabel 距离alert背景框 上方间距 默认8
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
    
    
    //MARK: action 2.3 开始 action所有设置都在 AEAlertAction中 会根据AEAlertViewStyle来使用合适的配置
    /// 按钮高度,为了保证整齐,如果没有手动设置!会计算所有按钮中的文字获取最大高度!
    public var actionHeight: CGFloat = -1 {
        didSet { alertView.actionHeight = actionHeight }
    }
    /// 两个按钮时 排列方式
    public var actionArrangementMode: AEButtonArrangementMode = .horizontal {
        didSet {
            alertView.actionArrangementMode = actionArrangementMode
        }
    }
    
    
    /// baseAlert 只能设置属性 不能改变其值
    public var alertView: AEBaseAlertView!
    
    /// init
    public override convenience init(frame: CGRect) {
        self.init(style: .defaulted, title: nil, message: nil)
    }
    public convenience init(style: AEAlertViewStyle) {
        self.init(style: style, title: nil, message: nil)
    }
    public convenience init(style: AEAlertViewStyle, maximumWidth: CGFloat) {
        self.init(style: style, title: nil, message: nil, maximumWidth: maximumWidth)
    }
    public convenience init(style: AEAlertViewStyle, title: String?, message: String?) {
        if UIScreen.main.bounds.size.width-48 > 320 {
            self.init(style: style, title: title, message: message, maximumWidth: 320)
        } else {
            self.init(style: style, title: title, message: message, maximumWidth: UIScreen.main.bounds.size.width-48)
        }
    }
    public init(style: AEAlertViewStyle, title: String?, message: String?, maximumWidth: CGFloat) {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        alertStyle = style
        alertView = AEBaseAlertView(frame: frame, maximumWidth: maximumWidth)
        alertView.titleLabel.text = title
        alertView.messageTextView.text = message ?? ""
        if style == .custom {
            alertView.alertStyle = .custom
        } else {
            alertView.alertStyle = .apple
        }
        addSubview(alertView)
    }

    private var actions: [AEAlertAction] = []
    private var alertStyle: AEAlertViewStyle = .defaulted
    
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
        DispatchQueue.main.async {
            UIApplication.shared.alertWindow?.addSubview(self)
            if  self.isObserverKeyboard {
                NotificationCenter.default.addObserver(self, selector: #selector( self.keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector( self.keyBoardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
            }
            
            if self.showDuration == 0.0 {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                return
            }
            self.alertView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.alertView.alpha = 0
            
            UIView.animate(withDuration: TimeInterval(self.showDuration),
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
    }
    private func dismissAlert() {
        DispatchQueue.main.async {
            if self.isObserverKeyboard {
                NotificationCenter.default.removeObserver(self)
            }
            self.actions = []
            if self.dismissDuration == 0.0 {
                for view in self.subviews {
                    view.removeFromSuperview()
                }
                self.removeFromSuperview()
                return
            }
            UIView.animate(withDuration: self.dismissDuration, delay: 0.0, options: .curveEaseIn, animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                self.alertView.alpha = 0
                self.alpha = 0
            }) { (finished) in
                self.removeFromSuperview()
            }
        }
    }
    
    private func createActions() {
        DispatchQueue.main.async {
            if self.actions.count == 0 {
                self.alertView.actionList = []
                return
            }
            var list: [AEAlertViewButton] = []
            for (idx, action) in self.actions.enumerated() {
                let btn = AEAlertViewButton(type: .custom)
                btn.tag = idx
                btn.action = action
                btn.addTarget(self, action: #selector(self.actionPressed), for: .touchUpInside)
                if action.tag == -1 { action.tag = idx }
                action.actionButton = btn
                list.append(btn)
            }
            self.alertView.actionList = list
        }
    }

    @objc private func actionPressed(button: AEAlertViewButton) {
        if button.tag < actions.count {
            if !(actions[button.tag].enabled ?? false) {
                return
            }
            actions[button.tag].handler?(actions[button.tag])
        }
    }
    
}
