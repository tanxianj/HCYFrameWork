//
//  TSSLoadingCircle.swift
//  
//
//  Created by Jupiter_TSS on 2022/4/24.
//

import UIKit

class TSSLoadingCircle: UIView {
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
