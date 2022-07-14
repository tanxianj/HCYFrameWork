//
//  SMPLoadingCircle.swift
//  Smart1Pay.sit
//
//  Created by Jupiter_TSS on 2022/4/24.
//

import UIKit

class HCYLoadingCircle: UIView {
    /// Current status of animation, read-only.
    @available(*, deprecated)
    public var animating: Bool { return isAnimating }
    private(set) public var isAnimating: Bool = false
    lazy var colorImage: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "circle_bg"))
        imageView.frame = self.bounds
        return imageView
    }()
    override var bounds: CGRect{
        didSet {
            // setup the animation again for the new bounds
            if oldValue != bounds && isAnimating {
                setUpAnimation()
            }
        }
    }
    lazy var grayLayer : CAShapeLayer = {
        let grayLayer = CAShapeLayer()
        let grayPath = UIBezierPath.init(arcCenter:CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5), radius: self.bounds.size.width * 0.5 - 10.0.scale(), startAngle: 0, endAngle: Double.pi * 2.0, clockwise: true)
        grayLayer.bounds = self.bounds
        grayLayer.position = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        grayLayer.path = grayPath.cgPath
        grayLayer.fillColor = UIColor.clear.cgColor
        grayLayer.strokeColor = UIColor.gray.cgColor
        grayLayer.strokeStart = 0
        grayLayer.strokeEnd = 1
//        grayLayer.lineWidth = 6.0 / 53.0 * self.bounds.height
        grayLayer.lineWidth = 10.0.scale()
        grayLayer.opacity = 0.3
        return grayLayer
    }()
    
    lazy var shapeLayer : CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        let shapePath = UIBezierPath.init(arcCenter:CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5), radius: self.bounds.size.width * 0.5 - 10.0.scale(), startAngle: -.pi * 0.5, endAngle: Double.pi * 1.5, clockwise: true)
        shapeLayer.bounds = self.bounds
        shapeLayer.position = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        shapeLayer.lineCap = .round
        shapeLayer.path = shapePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
//        grayLayer.lineWidth = 6.0 / 53.0 * self.bounds.height
        shapeLayer.lineWidth = 10.0.scale()
        return shapeLayer
    }()
    
    var percent :CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     Start animating.
     */
    public final func startAnimating() {
        
        guard !isAnimating else {return}
        self.layoutIfNeeded()
        isHidden = false
        isAnimating = true
        layer.speed = 1
        setUpAnimation()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
//        self.layer.addSublayer(grayLayer)
//        self.addSubview(self.colorImage)
//        colorImage.layer.mask = shapeLayer//关键步骤
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(self.colorImage)
        colorImage.layer.mask = shapeLayer//关键步骤
        
    }
    /**
     Stop animating.
     */
    public final func stopAnimating() {
        guard isAnimating else {
            return
        }
        isHidden = true
        isAnimating = false
        shapeLayer.removeAnimation(forKey: "groupAnimation")
    }
    
    func setUpAnimation() {
        shapeLayer.removeAnimation(forKey: "groupAnimation")
        let beginTime: Double = 0.5
        let strokeEndDuration: Double = 0.7
        let strokeStartDuration: Double = 1.2

        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.byValue = Float.pi * 2
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = strokeEndDuration
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1

        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.duration = strokeStartDuration
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.beginTime = beginTime

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
        groupAnimation.duration = strokeStartDuration + beginTime
        groupAnimation.repeatCount = .infinity
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = .forwards

        shapeLayer.add(groupAnimation, forKey: "groupAnimation")

      
    }
}

/*
 
 //
//  SMPLoadingCircle.swift
//  Smart1Pay.sit
//
//  Created by 冷禹彤 on 2022/2/8.
//

import UIKit

class SMPLoadingCircle: UIView {
    
    lazy var colorImage: UIImageView = {
        let imageView = UIImageView(image: UIImage.init(named: "circle_bg"))
        imageView.frame = self.bounds
        return imageView
    }()
    
    lazy var grayLayer : CAShapeLayer = {
        let grayLayer = CAShapeLayer()
        let grayPath = UIBezierPath.init(arcCenter:CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5), radius: self.bounds.size.width * 0.5 - 5, startAngle: 0, endAngle: Double.pi * 2.0, clockwise: true)
        grayLayer.bounds = self.bounds
        grayLayer.position = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        grayLayer.path = grayPath.cgPath
        grayLayer.fillColor = UIColor.clear.cgColor
        grayLayer.strokeColor = UIColor.gray.cgColor
        grayLayer.strokeStart = 0
        grayLayer.strokeEnd = 1
        grayLayer.lineWidth = 6.0 / 53.0 * self.bounds.height
        grayLayer.opacity = 0.3
        return grayLayer
    }()
    
    lazy var shapeLayer : CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        let shapePath = UIBezierPath.init(arcCenter:CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5), radius: self.bounds.size.width * 0.5 - 5, startAngle: CGFloat.pi * 0.5, endAngle: CGFloat.pi * 2.5, clockwise: true)
        shapeLayer.bounds = self.bounds
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.position = CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.5)
        shapeLayer.path = shapePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0.25
        shapeLayer.lineWidth = 6.0 / 53.0 * self.bounds.height
        return shapeLayer
    }()
    
    var percent :CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.addSublayer(grayLayer)
        self.addSubview(self.colorImage)
        colorImage.layer.mask = shapeLayer//关键步骤
    }
    
    func startAni(){
        /**
         circle animation
         */
        let rotationAni1 = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAni1.duration = 1
        rotationAni1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        rotationAni1.fromValue = -(.pi / 2.0)
        rotationAni1.toValue = 0
        rotationAni1.fillMode = .forwards
        rotationAni1.isRemovedOnCompletion = false
        
        let rotationAni2 = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAni2.beginTime = 1
        rotationAni2.duration = 1
        rotationAni2.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        rotationAni2.fromValue = 0
        rotationAni2.toValue = -(.pi / 2.0)
        rotationAni2.fillMode = .forwards
        rotationAni2.isRemovedOnCompletion = false
        
        let rotationAni3 = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAni3.beginTime = 2
        rotationAni3.duration = 2
        rotationAni3.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        rotationAni3.fromValue = -(.pi / 2.0)
        rotationAni3.toValue = Double.pi * 4.0 - (.pi / 2.0)
        rotationAni3.fillMode = .forwards
        rotationAni3.isRemovedOnCompletion = false
        
        let endAni1 = CABasicAnimation(keyPath: "strokeEnd")
        endAni1.beginTime = 2.5
        endAni1.duration = 1
        endAni1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        endAni1.fromValue = 0.25
        endAni1.toValue = 0.75
        endAni1.fillMode = .forwards
        endAni1.isRemovedOnCompletion = false

        let startAni1 = CABasicAnimation(keyPath: "strokeEnd")
        startAni1.beginTime = 3.5
        startAni1.duration = 0.5
        startAni1.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        startAni1.fromValue = 0.75
        startAni1.toValue = 0.25
        startAni1.fillMode = .forwards
        startAni1.isRemovedOnCompletion = false
        
        let aniGroup = CAAnimationGroup()
        aniGroup.isRemovedOnCompletion = false
        aniGroup.duration = 4
        aniGroup.repeatCount = .infinity
        aniGroup.fillMode = .forwards
        aniGroup.animations = [rotationAni1,rotationAni2,rotationAni3,endAni1,startAni1]
        shapeLayer.add(aniGroup, forKey: nil)
    }
}
 */
