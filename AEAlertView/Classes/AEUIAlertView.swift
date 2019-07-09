//
//  AEUIAlertView.swift
//  AEAlertView
//
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2017年 Allen. All rights reserved.
//  仿系统UI 按钮之间有线条分割 按钮无边框

import UIKit

// 弹窗样式 请查看 AEAlertView 的 enum AEAlertViewStyle
// 属性基本和 AEAlertView一样  取消了 按钮的背景色和描边的颜色 新增了 线条颜色 和线条样式
// 按钮默认的高度为40 距离按钮父控件间距 上下为2  按钮父控件距离alertView的bottom 默认为0


open class AEUIAlertView: UIView {
    
    /// 展示
    open func show() { showAlert() }
    /// 关闭
    open func close() { closeAlert() }
    /// 弹窗左右距离屏幕的最大宽度 默认左右38 如果小于150或大于屏幕宽 会自动使用默认值 如果没有特殊需求 尽可能不要修改此值
    open var maximumWidth: Int? {
        didSet {
            setMaximumWidth(width: maximumWidth ?? 0)
        }
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
    
    
    // MARK: 按钮属性  默认3中样式的按钮 具体看AEAlertActionStyle
    /// 所有按钮
    open private(set) var actions: [AEAlertAction]?
    /// Default样式下 按钮颜色 默认红色
    open var buttonTitleColor: UIColor?
    /// Default样式下 按钮Font 默认 15
    open var buttonTitleFont: UIFont?
    /// cancel样式 按钮颜色 默认 #666666
    open var cancelButtonTitleColor: UIColor?
    /// cancel样式  按钮Font 默认 15
    open var cancelButtonTitleFont: UIFont?
    /// Destructive样式 按钮颜色  默认蓝色
    open var destructiveButtonTitleColor: UIColor?
    /// Destructive样式 按钮Font 默认 15
    open var destructiveButtonTitleFont: UIFont?
    
    /// 按钮分割线颜色 默认 #F2F2F2
    open var separatorLineColor: UIColor?
    
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
        didSet {
            setMessageTopMargin(margin: messageTopMargin ?? 0)
        }
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
    /// 自定义view距离按钮底部的间距
    open var contentViewBottomMargin: Int? {
        didSet {
            setContentViewBottomMargin(margin: contentViewBottomMargin ?? 0)
        }
    }
    
    // MARK: 按钮相关的操作
    /// 按钮距离父控件的上下间距 文字默认是居中显示
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
    /// 2个按钮时排列方式  如果是竖着显示 线条和系统线条一样展示
    open var buttonArrangement: AEAlertViewButtonArrangement = .Horizontal {
        didSet {
            alertView.buttonArrangement = buttonArrangement
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
        actions = [] as? [AEAlertAction]
        buttonTitleFont = UIFont.systemFont(ofSize: 15)
        cancelButtonTitleFont = UIFont.systemFont(ofSize: 15)
        destructiveButtonTitleFont = UIFont.systemFont(ofSize: 15)
        
        if alertViewStyle == .Default {
            buttonTitleColor = UIColor.red
            cancelButtonTitleColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
            destructiveButtonTitleColor = UIColor.blue
            
        } else if alertViewStyle == .TextField {
            buttonTitleColor = UIColor.red
            cancelButtonTitleColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
            destructiveButtonTitleColor = UIColor.blue
            
            textField.font = UIFont.systemFont(ofSize: 15)
            textField.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
            textField.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
            textField.placeholder = "请输入内容"
            
            textFieldSize = CGSize(width: Int(UIScreen.main.bounds.size.width) - 68 - 40, height: 40)
            setTextFieldSize(size: textFieldSize)
            // 监听键盘弹出 收起
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
        } else {
            buttonTitleColor = UIColor.red
            cancelButtonTitleColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
            destructiveButtonTitleColor = UIColor.blue
        }
        
        alertView.titleLabel.text = title
        alertView.titleLabel.textColor = UIColor.black
        alertView.titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        alertView.messageTextView.text = message
        alertView.messageTextView.textColor = UIColor.darkGray
        alertView.messageTextView.font = UIFont.systemFont(ofSize: 14)
        
        // 设置默认值
        alertView.buttonSuperMargin = 0
        alertView.buttonBottomMargin = 0
        alertView.contentViewBottomMargin = 18
        
        addSubview(alertView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    private var alertView: AEBaseAlertView!
    private var alertViewStyle: AEAlertViewStyle!
    
    // 线条 默认初始化两条线  如果是多个按钮 或者竖排按钮 线条只取颜色
    // 横向线条
    let horizontal = UIView()
    // 竖向线条
    let vertical = UIView()
}

// MARK: Func
extension AEUIAlertView {
    
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
    
    /// 页面展示
    private func showAlert() {
        // 设置按钮
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
    
    /// 关闭页面
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
    
    /// 设置按钮
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
            button.type = .Filled
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(action.title, for: .normal)
            
            if action.style == AEAlertActionStyle.Cancel {
                if cancelButtonTitleFont == nil {
                    cancelButtonTitleFont = UIFont.systemFont(ofSize: 15)
                }
                button.titleLabel?.font = cancelButtonTitleFont
                button.setTitleColor(cancelButtonTitleColor, for: .normal)
                button.setTitleColor(cancelButtonTitleColor, for: .highlighted)
            } else if action.style == AEAlertActionStyle.Default {
                if buttonTitleFont == nil {
                    buttonTitleFont = UIFont.systemFont(ofSize: 15)
                }
                button.titleLabel?.font = buttonTitleFont
                button.setTitleColor(buttonTitleColor, for: .normal)
                button.setTitleColor(buttonTitleColor, for: .highlighted)
            } else {
                if destructiveButtonTitleFont == nil {
                    destructiveButtonTitleFont = UIFont.systemFont(ofSize: 15)
                }
                button.titleLabel?.font = destructiveButtonTitleFont
                button.setTitleColor(destructiveButtonTitleColor, for: .normal)
                button.setTitleColor(destructiveButtonTitleColor, for: .highlighted)
            }
            buttons.add(button)
            action.actionButton = button
        }
        alertView.actionButtons = buttons as? [AEAlertViewButton]
        
        // 设置线条  如果线条颜色没设置 默认#F2F2F2

        if separatorLineColor == nil {
            separatorLineColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
        }
        horizontal.backgroundColor = separatorLineColor
        vertical.backgroundColor = separatorLineColor
        if actionsCount != 2 || buttonArrangement == .Vertical {
            
            vertical.isHidden = true
            
            if actionsCount == 1 {
                alertView.actionButtonContainerView.addSubview(horizontal)
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    self.horizontal.frame = CGRect(x: 0, y: 0, width: self.alertView.actionButtonContainerView.frame.size.width, height: 1)
                }
            } else {
                // 多个按钮 从上到下添加 线条位置 推荐将buttonSuperMargin 设置为0
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    
                // 添加竖排线条  拿到父控件的高度等分设置线条 第一条线的Y 在0
                    let lineFrame = self.alertView.actionButtonContainerView.frame.size.height / CGFloat(actionsCount)
                    
                    for i in 0..<actionsCount {
                        let line = UIView()
                        line.backgroundColor = self.separatorLineColor
                        self.alertView.actionButtonContainerView.addSubview(line)
                        
                        line.frame = CGRect(x: 0, y: lineFrame * CGFloat(i), width: self.alertView.actionButtonContainerView.frame.size.width, height: 1)
                    }
                }
            }
        } else {
            // 两个按钮
            alertView.actionButtonContainerView.addSubview(horizontal)
            alertView.actionButtonContainerView.addSubview(vertical)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                self.horizontal.frame = CGRect(x: 0, y: 0, width: self.alertView.actionButtonContainerView.frame.size.width, height: 1)
                self.vertical.frame = CGRect(x: self.alertView.actionButtonContainerView.frame.size.width / 2, y: 0, width: 1, height: self.alertView.actionButtonContainerView.frame.size.height)
            }
        }
    }
    
    /// 按钮点击回调
    @objc private func actionButtonPressed(button: AEAlertViewButton) {
        
        let action = self.actions![button.tag]
        if action.handler != nil {
            action.handler!(action)
        }
    }
    
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
