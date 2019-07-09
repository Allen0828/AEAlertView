//
//  AEAlertView.swift
//  AEAlertView
//
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2017年 Allen. All rights reserved.
//  默认按钮是带圆角的 其他无差异

import UIKit

/// 弹窗样式
public enum AEAlertViewStyle {
    case Default,
    TextField,
    Image
}


open class AEAlertView: UIView {
    
    /// 展示
    open func show() { showAlert() }
    /// 关闭
    open func close() { closeAlert() }
    /// 弹窗左右距离屏幕的最大宽度 默认左右34 如果小于150或大于屏幕宽 会自动使用默认值
    open var maximumWidth: Int? {
        didSet { setMaximumWidth(width: maximumWidth ?? 0) }
    }
    
    /// 展示时 动画的时间 如果设置0 等于不需要动画 默认0.5秒动画
    open var animationTime: CGFloat = 0.5
    
    /// 推荐宽度为maximumWidth 默认 UIScreen.main.bounds.size.width - (38 * 2)
    open func setContentView(contentView: UIView, width: CGFloat, height: CGFloat) {
        if width > UIScreen.main.bounds.size.width || width < 149 {
            content(view: contentView, width: NSInteger(UIScreen.main.bounds.size.width - (38 * 2)), height: NSInteger(height))
        } else {
            content(view: contentView, width: NSInteger(width), height: NSInteger(height))
        }
    }
    
    /// 弹出标题
    open var title: String? {
        didSet { setTitle(title: title) }
    }
    /// 内容
    open var message: String? {
        didSet { setMessage(message: message) }
    }
    /// 内容高度如果文字超出 文字可以滚动 不可以设置为0
    open var messageHeight: Int? {
        didSet {
            guard let height = messageHeight else { return }
            setMessageHeight(height: height)
        }
    }
    
    /// 添加action AddAction
    open func addAction(action: AEAlertAction) {
        actions?.append(action)
    }
    /// alert背景色
    open var alertViewBackgroundColor: UIColor? {
        didSet { setAlertViewBackgroundColor(color: alertViewBackgroundColor!) }
    }
    
    /// Title字体
    open var titleFont: UIFont! {
        didSet { setTitleFont(font: titleFont) }
    }
    /// Title字体颜色
    open var titleColor: UIColor? {
        didSet { setTitleColor(color: titleColor) }
    }
    /// Title背景颜色
    open var titleBackgroundColor: UIColor? {
        didSet { setTitleBackgroundColor(color: titleBackgroundColor) }
    }
    
    /// message字体
    open var messageFont: UIFont! {
        didSet { setMessageFont(font: messageFont) }
    }
    /// message字体颜色
    open var messageColor: UIColor? {
        didSet { setMessageColor(color: messageColor) }
    }
    /// Message背景颜色
    open var messageBackgroundColor: UIColor? {
        didSet { setMessageBackgroundColor(color: messageBackgroundColor) }
    }
    
    
    // MARK: textField
    /// 新增TextField样式 继承AEUIAlertView可自己设置属性
    open var textField: UITextField = UITextField()
    /// TextField键盘弹窗时 页面向上移动的距离 默认180
    open var textFieldBecomeMargin: Int = 180
    /// textField 是否需要圆角
    open var textFieldRadius: CGFloat? {
        didSet {
            textField.layer.cornerRadius = textFieldRadius ?? 4
            textField.layer.masksToBounds = true
        }
    }
    /// textField tintColor
    open var textFieldTintColor: UIColor? {
        didSet { textField.tintColor = textFieldTintColor }
    }
    /// TextField->leftView
    open var textFieldLeftView: UIView? {
        didSet {
            textField.leftView = textFieldLeftView
            textField.leftViewMode = .always
        }
    }
    /// TextField 占位文本
    open var placeholder: String? {
        didSet { textField.placeholder = placeholder }
    }
    /// TextField 文字
    open var textFieldText: String? {
        get {
            return textField.text
        }
        set {
            textField.text = textFieldText
        }
    }
    /// TextField Size 默认距离 宽maximumWidth-左右20 高40
    open var textFieldSize: CGSize? {
        didSet { setTextFieldSize(size: textFieldSize) }
    }

    // MARK: 按钮相关
    /// 所有按钮
    open private(set) var actions: [AEAlertAction]?
    /// 确定的背景颜色
    open var buttonColor: UIColor?
    /// 取消按钮的背景颜色
    open var cancelButtonColor: UIColor?
    /// 其他按钮的背景颜色
    open var destructiveButtonColor: UIColor?
    /// 禁用时背景色
    open var disabledButtonColor: UIColor?
    /// 确定按钮标题的颜色
    open var buttonTitleColor: UIColor?
    /// 取消按钮标题的颜色
    open var cancelButtonTitleColor: UIColor?
    /// 其他按钮标题的颜色
    open var destructiveButtonTitleColor: UIColor?
    /// 禁用状态按钮标题的颜色
    open var disabledButtonTitleColor: UIColor?
    /// 确定按钮的描边颜色 默认为空
    open var buttonLayerBorderColor: UIColor?
    /// 取消按钮的描边颜色 默认为空
    open var cancelButtonLayerBorderColor: UIColor?
    /// 其他按钮的描边颜色 默认为空
    open var destructiveButtonLayerBorderColor: UIColor?
    /// 按钮圆角 默认4
    open var buttonCornerRadius: CGFloat?
    
    /// 确定按钮字体
    open var buttonTitleFont: UIFont!
    /// 取消按钮的字体
    open var cancelButtonTitleFont: UIFont!
    /// 其他按钮的字体
    open var destructiveButtonTitleFont: UIFont!
    
    // MARK: 设置位置
    /// 标题距离上方间距
    open var titleTopMargin: Int? {
        didSet {
            setTitleTopMargin(margin: titleTopMargin ?? 0)
        }
    }
    /// 标题距离alertView左右的间距
    open var titleLeadingAndTrailingPadding: Int? {
        didSet {
            setTitleLeadingAndTrailingPadding(padding: titleLeadingAndTrailingPadding ?? 0)
        }
    }
    /// 内容距离标题的间距
    open var messageTopMargin: Int? {
        didSet { setMessageTopMargin(margin: messageTopMargin ?? 0) }
    }
    /// 内容距离alertView左右的间距
    open var messageLeadingAndTrailingPadding: Int? {
        didSet {
            setMessageLeadingAndTrailingPadding(padding: messageLeadingAndTrailingPadding ?? 0)
        }
    }
    
    /// 按钮距离AlertView底部的间距
    open var buttonBottomMargin: Int? {
        didSet {
            setButtonBottomMargin(margin: buttonBottomMargin ?? 0)
        }
    }
    /// 内容距离按钮Margin Distance between message and buttons
    open var messageWithButtonMargin: Int? {
        didSet {
            setMessageWithButtonMargin(margin: messageWithButtonMargin ?? 0)
        }
    }
    /// 内容Alignment默认是center Default is center
    open var messageAlignment: NSTextAlignment? {
        didSet {
            guard let alignment = messageAlignment else { return }
            setMessageAlignment(alignment: alignment)
        }
    }
    /// 自定义View距离message间距
    open var contentViewTopMargin: Int? {
        didSet {
            setContentViewTopMargin(margin: contentViewTopMargin ?? 0)
        }
    }
    /// 自定义view距离message底部的间距
    open var contentViewBottomMargin: Int? {
        didSet {
            setContentViewBottomMargin(margin: contentViewBottomMargin ?? 0)
        }
    }
    
    // MARK: 按钮相关的操作
    /// 按钮距离父控件的上下间距
    open var buttonSuperMargin: Int? {
        didSet {
            alertView.buttonSuperMargin = buttonSuperMargin ?? 0
        }
    }
    /// 2个按钮时距离左右的间距
    open var buttonsSuperPadding: Int? {
        didSet {
            alertView.buttonsSuperPadding = buttonsSuperPadding ?? 0
        }
    }
    /// 1个和多个按钮时距离左右的间距
    open var buttonSuperPadding: Int? {
        didSet {
            alertView.buttonSuperPadding = buttonSuperPadding ?? 0
        }
    }
    /// 2个按钮时排列方式
    open var buttonArrangement: AEAlertViewButtonArrangement? {
        didSet {
            guard let type = buttonArrangement else { return }
            alertView.buttonArrangement = type
        }
    }
    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: init
    public convenience init() {
        self.init(alertViewStyle: .Default, title: nil, message: nil)
    }
    
    public override convenience init(frame: CGRect) {
        self.init(alertViewStyle: .Default, title: nil, message: nil)
    }
    
    public convenience init(alertViewStyle: AEAlertViewStyle) {
        self.init(alertViewStyle: alertViewStyle, title: nil, message: nil)
    }
    
    public init(alertViewStyle: AEAlertViewStyle, title: String?, message: String?) {
        let frame = CGRect(x: 0, y: 0,
                           width: UIScreen.main.bounds.size.width,
                           height: UIScreen.main.bounds.size.height)
        super.init(frame: frame)
        
        alertView = AEBaseAlertView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        alertView.alertBackgroundView.backgroundColor = UIColor.white
        
        self.alertViewStyle = alertViewStyle
        actions = NSArray() as? [AEAlertAction]
        buttonTitleFont = UIFont.systemFont(ofSize: 14)
        cancelButtonTitleFont = UIFont.systemFont(ofSize: 14)
        destructiveButtonTitleFont = UIFont.systemFont(ofSize: 14)
        buttonCornerRadius = 4.0
        
        if alertViewStyle == AEAlertViewStyle.Default {
            buttonColor = UIColor.white
            buttonTitleColor = UIColor.red
            buttonLayerBorderColor = UIColor.red
            
            cancelButtonColor = UIColor.white
            cancelButtonTitleColor = UIColor.darkGray
            cancelButtonLayerBorderColor = UIColor.darkGray
            
            destructiveButtonColor = UIColor.white
            destructiveButtonTitleColor = UIColor.darkGray
            destructiveButtonLayerBorderColor = UIColor.darkGray
            
        }else if alertViewStyle == .Image {
            buttonColor = UIColor.orange
            buttonTitleColor = UIColor.white
            
            cancelButtonColor = UIColor.lightGray
            cancelButtonTitleColor = UIColor.white
            
            destructiveButtonColor = UIColor.white
            destructiveButtonTitleColor = UIColor.blue
            
        } else if alertViewStyle == .TextField {
            buttonColor = UIColor.white
            buttonTitleColor = UIColor.red
            buttonLayerBorderColor = UIColor.red
            
            cancelButtonColor = UIColor.white
            cancelButtonTitleColor = UIColor.darkGray
            cancelButtonLayerBorderColor = UIColor.darkGray
            
            destructiveButtonColor = UIColor.white
            destructiveButtonTitleColor = UIColor.darkGray
            destructiveButtonLayerBorderColor = UIColor.darkGray

            textField.font = UIFont.systemFont(ofSize: 15)
            textField.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
            textField.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
            textField.placeholder = "请输入内容"
            
            textFieldSize = CGSize(width: Int(UIScreen.main.bounds.size.width) - 68 - 40, height: 40)
            setTextFieldSize(size: textFieldSize)
            // 监听键盘弹出 收起
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        alertView.titleLabel.text = title
        alertView.titleLabel.textColor = UIColor.black
        alertView.titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        alertView.messageTextView.text = message
        alertView.messageTextView.textColor = UIColor.darkGray
        alertView.messageTextView.font = UIFont.systemFont(ofSize: 14)
        
        addSubview(alertView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
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
            self.transform = CGAffineTransform(translationX: 0, y: CGFloat(-textFieldBecomeMargin))
        }else {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    private var alertView: AEBaseAlertView!
    private var alertViewStyle: AEAlertViewStyle!
    
    private func showAlert() {
        
        createActionButtons()
        UIApplication.shared.delegate?.window??.addSubview(self)
        
        alertView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        alertView.alpha = 0
        
        UIView.animate(withDuration: TimeInterval(animationTime),
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
    
    private func closeAlert() {
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
    
    private func createActionButtons() {
        
        let buttons = NSMutableArray()
        
        guard let actionsCount = actions?.count else {
            return
        }
        for i in 0..<actionsCount {
            
            let action = actions![i]
            let button = AEAlertViewButton(type: .custom)
            
            button.contentEdgeInsets = UIEdgeInsets(top: -15, left: -15, bottom: -15, right: -15)
            button.tag = i
            button.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
            button.isEnabled = action.enabled ?? true
            button.radiusCorner = buttonCornerRadius
            button.type = AEAlertViewButtonType.Bordered
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(action.title, for: .normal)
            button.setTitleColor(disabledButtonTitleColor, for: .disabled)
            button.setBackgroundColor(color: disabledButtonColor ?? UIColor.darkGray, state: .disabled)
            
            if action.style == AEAlertActionStyle.Cancel {
                
                button.setTitleColor(cancelButtonTitleColor, for: .normal)
                button.setTitleColor(cancelButtonTitleColor, for: .highlighted)
                button.setBackgroundColor(color: cancelButtonColor!, state: .normal)
                button.setBackgroundColor(color: cancelButtonColor!, state: .highlighted)
                button.titleLabel?.font = cancelButtonTitleFont
                
                if cancelButtonLayerBorderColor != nil {
                    button.layer.borderWidth = 1.0
                    button.layer.borderColor = cancelButtonLayerBorderColor?.cgColor
                }else {
                    button.layer.borderWidth = 0.0
                }
                
            }else if action.style == AEAlertActionStyle.Destructive {
                
                button.setTitleColor(destructiveButtonTitleColor, for: .normal)
                button.setTitleColor(destructiveButtonTitleColor, for: .highlighted)
                button.setBackgroundColor(color: destructiveButtonColor!, state: .normal)
                button.setBackgroundColor(color: destructiveButtonColor!, state: .highlighted)
                button.titleLabel?.font = destructiveButtonTitleFont
                if alertViewStyle == AEAlertViewStyle.Image {
                    button.type = AEAlertViewButtonType.Filled
                }
                if destructiveButtonLayerBorderColor != nil {
                    button.layer.borderWidth = 1.0
                    button.layer.borderColor = destructiveButtonLayerBorderColor?.cgColor
                }else {
                    button.layer.borderWidth = 0.0
                }
            } else {
                
                button.setTitleColor(buttonTitleColor, for: .normal)
                button.setTitleColor(buttonTitleColor, for: .highlighted)
                button.setBackgroundColor(color: buttonColor!, state: .normal)
                button.setBackgroundColor(color: buttonColor!, state: .highlighted)
                button.titleLabel?.font = buttonTitleFont
                if buttonLayerBorderColor != nil {
                    button.layer.borderWidth = 1.0
                    button.layer.borderColor = buttonLayerBorderColor?.cgColor
                }else {
                    button.layer.borderWidth = 0.0
                }
            }
            
            buttons.add(button)
            action.actionButton = button
        }
        alertView.actionButtons = buttons as? [AEAlertViewButton]
    }
    
    @objc private func actionButtonPressed(button: AEAlertViewButton) {
        
        let action = self.actions![button.tag]
        if action.handler != nil {
            action.handler!(action)
        }
    }
}

// MARK: func
extension AEAlertView {
    
    /// 标题
    private func setTitle(title: String?) {
        alertView.titleLabel.text = title
    }
    /// 内容
    private func setMessage(message: String?) {
        alertView.messageTextView.text = message
    }
    /// 标题字体
    private func setTitleFont(font: UIFont) {
        alertView.titleLabel.font = font
    }
    /// 内容字体
    private func setMessageFont(font: UIFont) {
        alertView.messageTextView.font = font
    }
    /// 标题颜色
    private func setTitleColor(color: UIColor?) {
        alertView.titleLabel.textColor = color
    }
    /// 内容字体颜色
    private func setMessageColor(color: UIColor?) {
        alertView.messageTextView.textColor = color
    }
    /// 标题背景颜色
    private func setTitleBackgroundColor(color: UIColor?) {
        alertView.titleLabel.backgroundColor = color
    }
    /// 内容背景颜色
    private func setMessageBackgroundColor(color: UIColor?) {
        alertView.messageTextView.backgroundColor = color
    }
    
    /// 设置content
    private func content(view: UIView, width: NSInteger, height: NSInteger) {
        alertView.setContentView(contentView: view, width: width, height: height)
    }
    /// 内容距离标题底部
    private func setMessageTopMargin(margin: Int) {
        alertView.messageTopMargin = margin
    }
    /// 标题左右间距
    private func setTitleLeadingAndTrailingPadding(padding: Int) {
        alertView.titleLeadingAndTrailingPadding = NSInteger(padding)
    }
    /// 内容左右间距
    private func setMessageLeadingAndTrailingPadding(padding: Int) {
        alertView.messageLeadingAndTrailingPadding = NSInteger(padding)
    }
    
    private func setButtonBottomMargin(margin: Int) {
        alertView.buttonBottomMargin = NSInteger(margin)
    }
    
    private func setTitleTopMargin(margin: Int) {
        alertView.titleTopMargin = NSInteger(margin)
    }
    
    private func setMessageWithButtonMargin(margin: Int) {
        alertView.messageWithButtonMargin = NSInteger(margin)
    }
    
    private func setMessageAlignment(alignment: NSTextAlignment) {
        alertView.messageAlignment = alignment
    }
    
    private func setMessageHeight(height: Int) {
        alertView.messageHeight = NSInteger(height)
    }
    
    private func setContentViewTopMargin(margin: Int) {
        alertView.contentViewTopMargin = NSInteger(margin)
    }
    
    private func setContentViewBottomMargin(margin: Int) {
        alertView.contentViewBottomMargin = NSInteger(margin)
    }
    
    private func setAlertViewBackgroundColor(color: UIColor) {
        alertView.alertBackgroundView.backgroundColor = color
    }
    
    private func setMaximumWidth(width: Int) {
        if width < 149 || CGFloat(width) > UIScreen.main.bounds.size.width { return }
        alertView.maximumWidth = CGFloat(width)
    }
    
    // 新增TextField 方法
    private func setTextFieldSize(size: CGSize?) {
        guard size != nil else { return }
        alertView.setContentView(contentView: textField, width: Int(size!.width), height: Int(size!.height))
    }
    
}

