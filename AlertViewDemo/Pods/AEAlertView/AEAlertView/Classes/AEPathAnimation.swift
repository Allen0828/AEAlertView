//
//  AEBaseAlertView.swift
//  AEAlertView
//
//  代码地址: https://github.com/Allen0828/AEAlertView
//  Copyright © 2018年 Allen. All rights reserved.
//

import UIKit

// MARK: 路径动画 旋转
public class AEBeginLineAnimation: UIView {
                            
    /// 初始化一个线条加载动画 并且返回AEBeginLineAnimation
    /// - Parameter frame: 动画frame
    /// - Parameter lineWidth: 线条宽度 默认 4
    /// - Parameter lineColor: 线条颜色 默认 blue
    /// - Parameter layerSize: 动画框大小 必须为正方形 只需传一边
    public class func initShow(in frame: CGRect, lineWidth: CGFloat = 4, lineColor: UIColor? = UIColor.blue, layerSize: CGSize = CGSize.zero) -> AEBeginLineAnimation {
        let begin = AEBeginLineAnimation(frame: frame)
        begin.lineWidth = lineWidth
        begin.lineColor = lineColor
        begin.layerSize = layerSize
        begin.paused()
        begin.start()
        return begin
    }
    
    /// 开始动画
    public func start() {
        link.isPaused = false
    }
    /// 暂停
    public func paused() {
        link.isPaused = true
        progress = 0
    }
    
    /// 线条的宽度 默认 4
    public var lineWidth: CGFloat = 4 {
        didSet { animationLayer.lineWidth = lineWidth }
    }
    /// 线条颜色 默认 blue
    public var lineColor: UIColor? {
        didSet {
            animationLayer.strokeColor = lineColor?.cgColor ?? UIColor.blue.cgColor
        }
    }
    /// layerSize 默认 self.bounds.size
    public var layerSize: CGSize = CGSize.zero {
        didSet {
            if layerSize != CGSize.zero {
                animationLayer.bounds = CGRect(x: 0, y: 0, width: layerSize.width, height: layerSize.height)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var link: CADisplayLink!
    private var animationLayer: CAShapeLayer!
    private var startAngle: CGFloat = 0
    private var endAngle: CGFloat = 0
    private var progress: CGFloat = 0
    private var speed: CGFloat {
        get {
            if endAngle > CGFloat(Double.pi) {
                return 0.3 / 60
            }
            return 2 / 60
        }
    }
}
extension AEBeginLineAnimation {
    private func config() {
           animationLayer = CAShapeLayer()
           animationLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
           animationLayer.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
           animationLayer.fillColor = UIColor.clear.cgColor
           animationLayer.strokeColor = UIColor.blue.cgColor
           animationLayer.lineWidth = 4
           animationLayer.lineCap = .round
           layer.addSublayer(animationLayer)
           
           link = CADisplayLink(target: self, selector: #selector(displayAction))
           link.add(to: RunLoop.main, forMode: .default)
           link.isPaused = true
       }
       
       @objc private func displayAction() {
           progress += speed
           if progress >= 1 {
               progress = 0
           }
           updateAnimation()
       }
       private func updateAnimation() {
           let pi_2 = CGFloat(Double.pi / 2)
           startAngle = -pi_2
           endAngle = -pi_2 + progress * CGFloat(Double.pi) * 2
           if endAngle > CGFloat(Double.pi) {
               let prog = 1 - (1 - progress) / 0.25
               startAngle = -pi_2 + prog * CGFloat(Double.pi) * 2
           }
           let radius = animationLayer.bounds.size.width / 2 - lineWidth / 2
           let centerX = animationLayer.bounds.size.width / 2
           let centerY = animationLayer.bounds.size.height / 2
           let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
           path.lineCapStyle = .round
           animationLayer.path = path.cgPath
       }
}

// MARK: - 成功动画 ✔️
/// 成功动画 ✔️
public class AELineSuccessAnimation: UIView {
    
    /// 成功✅ 动画
    /// - Parameter view: 承载的view
    /// - Parameter lineWidth: 线条宽度 默认4
    /// - Parameter lineColor: 线条颜色
    /// - Parameter layerSize: 动画区域 默认 60
    public class func initShow(in frame: CGRect, lineWidth: CGFloat = 4, lineColor: UIColor? = UIColor.blue, layerSize: CGSize = CGSize.zero) -> AELineSuccessAnimation {
        let success = AELineSuccessAnimation(frame: frame)
        success.lineWidth = lineWidth
        success.lineColor = lineColor
        success.signWidth = lineWidth
        success.signColor = lineColor
        success.layerSize = layerSize
        success.start()
        return success
    }
    
    /// 配置 ✅ 和 ⭕️ 不同的样式
    /// - Parameter frame: 动画的位置
    /// - Parameter lineWidth: 圆圈的宽度
    /// - Parameter lineColor: 圆圈的颜色
    /// - Parameter layerSize: 动画的大小
    /// - Parameter signWidth: ✅的宽度
    /// - Parameter signColor: ✅的颜色
    public class func initConfig(in frame: CGRect, lineWidth: CGFloat = 4, lineColor: UIColor? = UIColor.blue, layerSize: CGSize = CGSize.zero, signWidth: CGFloat = 4, signColor: UIColor? = UIColor.blue) -> AELineSuccessAnimation {
        let success = AELineSuccessAnimation(frame: frame)
        success.lineWidth = lineWidth
        success.lineColor = lineColor
        success.signWidth = signWidth
        success.signColor = signColor
        success.layerSize = layerSize
        success.start()
        return success
    }
    
    public func start() {
        circleAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.checkAnimation()
        }
    }
    
    /// 动画时间 默认0.5
    public var duration = 0.5
    /// 动画区域 默认 self.bounds.size
    public var layerSize: CGSize = CGSize.zero {
        didSet {
            if layerSize != CGSize.zero {
                animationLayer.bounds = CGRect(x: 0, y: 0, width: layerSize.width, height: layerSize.height)
            }
        }
    }
    /// 外围圆线的宽度
    public var lineWidth: CGFloat = 4
    /// 外围圆线 颜色 默认 blue
    public var lineColor: UIColor?
    /// ✅ 线的宽度 默认 lineWidth
    public var signWidth: CGFloat?
    /// ✅ 线的宽度 默认 lineColor
    public var signColor: UIColor?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var animationLayer: CALayer = CALayer()
}

extension AELineSuccessAnimation: CAAnimationDelegate {
    private func config() {
        animationLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        animationLayer.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        layer.addSublayer(animationLayer)
    }
    
    private func circleAnimation() {
        let circle = CAShapeLayer()
        circle.frame = animationLayer.bounds
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = lineColor?.cgColor ?? UIColor.blue.cgColor
        circle.lineWidth = lineWidth
        
        animationLayer.addSublayer(circle)
        
        let lineW: CGFloat = lineWidth + 1
        let radius = animationLayer.bounds.size.width / 2 - lineW / 2
        let path = UIBezierPath(arcCenter: circle.position, radius: radius, startAngle: -CGFloat(Double.pi) / 2, endAngle: CGFloat(Double.pi * 3) / 2, clockwise: true)
        circle.path = path.cgPath
        
        let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circleAnimation.duration = duration
        circleAnimation.fromValue = 0
        circleAnimation.toValue = 1
        circleAnimation.delegate = self
        circleAnimation.setValue("circleAnimation", forKey: "animationName")
        circle.add(circleAnimation, forKey: nil)
    }
    
    private func checkAnimation() {
        let width = animationLayer.bounds.size.width
        let path = UIBezierPath()
        path.move(to: CGPoint(x: width * 2.7 / 10, y: width * 5.4 / 10))
        path.addLine(to: CGPoint(x: width * 4.5 / 10, y: width * 7 / 10))
        path.addLine(to: CGPoint(x: width * 7.8 / 10, y: width * 3.8 / 10))
        
        let checkLayer = CAShapeLayer()
        checkLayer.path = path.cgPath
        checkLayer.fillColor = UIColor.clear.cgColor
        var color = signColor
        if signColor == nil {
            if lineColor == nil {
                color = UIColor.blue
            } else {
                color = lineColor
            }
        }
        checkLayer.strokeColor = color?.cgColor
        checkLayer.lineWidth = signWidth ?? lineWidth
        checkLayer.lineCap = .round
        checkLayer.lineJoin = .round
        animationLayer.addSublayer(checkLayer)
        
        let checkAnimation = CABasicAnimation(keyPath: "strokeEnd")
        checkAnimation.duration = duration
        checkAnimation.fromValue = 0
        checkAnimation.toValue = 1
        checkAnimation.delegate = self
        checkAnimation.setValue("checkAnimation", forKey: "animationName")
        checkLayer.add(checkAnimation, forKey: nil)
    }
}


// MARK: - 线条动画 失败 ❌
/// 动画 失败 ❌
public class AELineFailAnimation: UIView {
    
    /// 失败❌ 动画
    /// - Parameter view: 承载的view
    /// - Parameter lineWidth: 线条宽度 默认4
    /// - Parameter lineColor: 线条颜色
    /// - Parameter layerSize: 动画区域 默认 60
    public class func initShow(in frame: CGRect, lineWidth: CGFloat = 4, lineColor: UIColor? = UIColor.blue, layerSize: CGSize = CGSize.zero) -> AELineFailAnimation {
        let success = AELineFailAnimation(frame: frame)
        success.lineWidth = lineWidth
        success.lineColor = lineColor
        success.signWidth = lineWidth
        success.signColor = lineColor
        success.layerSize = layerSize
        success.start()
        return success
    }
    
    /// 配置 ❌ 和 ⭕️ 不同的样式
    /// - Parameter frame: 动画的位置
    /// - Parameter lineWidth: 圆圈的宽度
    /// - Parameter lineColor: 圆圈的颜色
    /// - Parameter layerSize: 动画的大小
    /// - Parameter signWidth: ❌的宽度
    /// - Parameter signColor: ❌的颜色
    public class func initConfig(in frame: CGRect, lineWidth: CGFloat = 4, lineColor: UIColor? = UIColor.blue, layerSize: CGSize = CGSize.zero, signWidth: CGFloat = 4, signColor: UIColor? = UIColor.blue) -> AELineFailAnimation {
        let success = AELineFailAnimation(frame: frame)
        success.lineWidth = lineWidth
        success.lineColor = lineColor
        success.signWidth = signWidth
        success.signColor = signColor
        success.layerSize = layerSize
        success.start()
        return success
    }
    
    public func start() {
        circleAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.failAnimation()
        }
    }
    
    /// 动画时间 默认0.5
    public var duration = 0.5
    /// 动画区域 默认 self.bounds.size
    public var layerSize: CGSize = CGSize.zero {
        didSet {
            if layerSize != CGSize.zero {
                animationLayer.bounds = CGRect(x: 0, y: 0, width: layerSize.width, height: layerSize.height)
            }
        }
    }
    /// 外围圆线的宽度
    public var lineWidth: CGFloat = 4
    /// 外围圆线 颜色 默认 blue
    public var lineColor: UIColor?
    /// ❌ 线的宽度 默认 lineWidth
    public var signWidth: CGFloat?
    /// ❌ 线的宽度 默认 lineColor
    public var signColor: UIColor?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var animationLayer: CALayer = CALayer()
}
extension AELineFailAnimation: CAAnimationDelegate {
    private func config() {
        animationLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        animationLayer.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        layer.addSublayer(animationLayer)
    }
    private func circleAnimation() {
        let circle = CAShapeLayer()
        circle.frame = animationLayer.bounds
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = lineColor?.cgColor ?? UIColor.blue.cgColor
        circle.lineWidth = lineWidth
        
        animationLayer.addSublayer(circle)
        
        let lineW: CGFloat = lineWidth + 1
        let radius = animationLayer.bounds.size.width / 2 - lineW / 2
        let path = UIBezierPath(arcCenter: circle.position, radius: radius, startAngle: -CGFloat(Double.pi) / 2, endAngle: CGFloat(Double.pi * 3) / 2, clockwise: true)
        circle.path = path.cgPath
        
        let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circleAnimation.duration = duration
        circleAnimation.fromValue = 0
        circleAnimation.toValue = 1
        circleAnimation.delegate = self
        circleAnimation.setValue("circleAnimation", forKey: "animationName")
        circle.add(circleAnimation, forKey: nil)
    }
    private func failAnimation() {
        
        let width = animationLayer.bounds.size.width
        let path = UIBezierPath()
        path.move(to: CGPoint(x: width / 4, y: width / 4))
        path.addLine(to: CGPoint(x: width / 4 * 3, y: width / 4 * 3))
        path.move(to: CGPoint(x: width / 4 * 3, y: width / 4))
        path.addLine(to: CGPoint(x: width / 4, y: width / 4 * 3))
        
        let failLayer = CAShapeLayer()
        failLayer.path = path.cgPath
        failLayer.fillColor = UIColor.clear.cgColor
        var color = signColor
        if signColor == nil {
            if lineColor == nil {
                color = UIColor.blue
            } else {
                color = lineColor
            }
        }
        failLayer.strokeColor = color?.cgColor
        failLayer.lineWidth = signWidth ?? lineWidth
        failLayer.lineCap = .round
        failLayer.lineJoin = .round
        animationLayer.addSublayer(failLayer)
        
        let failAnimation = CABasicAnimation(keyPath: "strokeEnd")
        failAnimation.duration = duration
        failAnimation.fromValue = 0
        failAnimation.toValue = 1
        failAnimation.delegate = self
        failAnimation.setValue("checkAnimation", forKey: "animationName")
        failLayer.add(failAnimation, forKey: nil)
    }
}
