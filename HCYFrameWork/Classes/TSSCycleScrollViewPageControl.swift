import UIKit
public class TSSCycleScrollViewPageControl: UIControl {
    public var pageControlCornerRadius:CGFloat = 0.0
    public var dotViewClass: UIView? {
        didSet {
            resetDotViews()
        }
    }
    public var normalPageImage: UIImage? {
        didSet {
            resetDotViews()
        }
    }
    public var currentPageImage: UIImage? {
        didSet {
            resetDotViews()
        }
    }
    public var currentDotColor: UIColor = .white
    public var dotColor: UIColor = .clear
    public var dotSize: CGSize {
        if let image = normalPageImage {
            return image.size
        }
        return CGSize(width: 8, height: 8)
    }
    public var spacingBetweenDots: CGFloat = 8 {
        didSet {
            resetDotViews()
        }
    }
    public weak var delegate: TSSXPageControlDelegate?
    public var numberOfPages: Int = 0 {
        didSet {
            resetDotViews()
        }
    }
    public var currentPage: Int = 0 {
        willSet {
            changeActivity(activity: false, at: currentPage)
        }
        didSet {
            changeActivity(activity: true, at: currentPage)
        }
    }
    public var hidesForSinglePage: Bool = false
    public var shouldResizeFromCenter: Bool = true
    
    func sizeForNumber(of pages: Int) -> CGSize {
        return CGSize(width: (dotSize.width + spacingBetweenDots) * CGFloat(pages) - spacingBetweenDots, height: dotSize.height)
    }
    
    private var dots: [UIView] = [UIView]()
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view != self {
            
        }
    }
    
    public override func sizeToFit() {
        updateFrame(true)
    }
    
    private func updateFrame(_ overrideExistingFrame: Bool) {
        let size = sizeForNumber(of: numberOfPages)
        if overrideExistingFrame || frame.width < size.width || frame.height < size.height && !overrideExistingFrame {
            frame = CGRect(x: frame.minX, y: frame.minY, width: size.width, height: size.height)
            if shouldResizeFromCenter {
                center = center
            }
        }
        resetDotViews()
    }
    
    private func resetDotViews() {
        dots.forEach { $0.removeFromSuperview() }
        dots.removeAll()
        updateDots()
    }
    
    private func updateDots() {
        guard numberOfPages > 0 else {
            return
        }
        (0 ..< numberOfPages).forEach { (i) in
            var dot: UIView?
            if i < dots.count {
                dot = dots[i]
            } else {
                dot = generateDotView()
            }
            updateDotFrame(dot: dot!, at: i)
            changeActivity(activity: true, at: currentPage)
            hideForSinglePage()
        }
    }
    
    private func generateDotView() -> UIView {
        var dotView: UIView?
        if let dotImage = normalPageImage {
            dotView = UIImageView(image: dotImage)
            dotView?.frame = CGRect(x: 0, y: 0, width: dotSize.width, height: dotSize.height)
            dotView?.layer.cornerRadius = pageControlCornerRadius
            dotView?.layer.masksToBounds = true
        } else {
            dotView = TSSAnimateDotView(frame: CGRect(x: 0, y: 0, width: dotSize.width, height: dotSize.height))
            if let d = dotView as? TSSAnimateDotView {
                d.currentDotColor = currentDotColor
                d.dotColor = dotColor
            }
        }
        if let dotView = dotView {
            addSubview(dotView)
            dots.append(dotView)
        }
        dotView?.isUserInteractionEnabled = true
        return dotView!
    }
    
    private func updateDotFrame(dot: UIView, at index: Int) {
        let x = (dotSize.width + spacingBetweenDots) * CGFloat(index) + (frame.width - sizeForNumber(of: numberOfPages).width) / 2
        dot.frame = CGRect(x: x, y: 0, width: dotSize.width, height: dotSize.height)
    }
    
    public  func changeActivity(activity: Bool, at index: Int) {
        guard dots.count > 0 && index < dots.count else{return}
        if let d = dots[index] as? TSSAnimateDotView {
            d.changeActivityState(active: activity)
        } else if let dotView = dots[index] as? UIImageView {
            dotView.image = activity ? currentPageImage : normalPageImage
        }
    }
    
    public  func hideForSinglePage() {
        isHidden = (dots.count == 1 && hidesForSinglePage)
    }
}

