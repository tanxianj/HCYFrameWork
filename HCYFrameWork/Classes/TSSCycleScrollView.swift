import UIKit

open class TSSCycleScrollView: UIView {
    
    ///  当没有数据时的图片 距离左侧位置
    public var placeholderleftAnchor:CGFloat = 0{
        didSet{
            placeholderImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: placeholderleftAnchor).isActive = true
        }
    }
    
    /// 当没有数据时的图片
    public var placeholderImage:UIImageView = UIImageView()
    
    /// 任意数组形式的数据源
    public var dataSource: [Any]! = [] {
        didSet {
            collectionView.isScrollEnabled = !isSingleImage
            placeholderImage.isHidden = !isSingleImage
            (isAutoScroll && !isSingleImage) ? setupTimer() : invalidateTimer()
            setupPageControl()
            collectionView.reloadData()
        }
    }
    
    /// 自动滚动时长 default 3
    public var timeInterval: TimeInterval = 3 {
        didSet {
            setupTimer()
        }
    }
    
    /// 是否自动滚动 default true
    public var isAutoScroll: Bool = true {
        didSet {
            setupTimer()
        }
    }
    
    /// 滚动方向 default horizontal
    public var scrollDirection: UICollectionView.ScrollDirection = .horizontal {
        didSet {
            flowLayout.scrollDirection = scrollDirection
        }
    }
    
    /// banner 滚动 点击 自定义cell 和 设置cell显示内容 代理
    weak var delegate: TSSCycleScrollViewDelegate?
    /// 待注册的cell Identifier
    private var _Identifier:String?
    /// 待注册的cell Identifier
    private var Identifier: String{
        get {return _Identifier ?? ""}
        set {_Identifier = newValue}
    }
    
    /// 是否无限滚动 default
    public var infiniteLoop: Bool = true
    
    /// 是否显示 PageControl default true
    public var showPageControl: Bool = true {
        didSet {
            pageControl?.isHidden = !showPageControl
        }
    }
    /// 只有一条数据时是否隐藏 PageControl default true
    public var hidesForSinglePage: Bool = true
    
    /// pageControlStyle default default
    public var pageControlStyle: TSSCycleScrollViewPageControlStyle = .default {
        didSet {
            setupPageControl()
        }
    }
    
    /// pageControlDotSize default 10 10
    public var pageControlDotSize: CGSize = CGSize(width: 10, height: 10) {
        didSet {
            setupPageControl()
        }
    }
    public var pageControlAlignment: TSSCycleScrollViewPageControlAlignment = .center(offset: 0)
    /// 自定义的 pageControl 圆角 pageControl 是颜色是无效
    public var pageControlCornerRadius:CGFloat = 0.0
    
    public var currentPageColor: UIColor = .white {
        didSet {
            if let p = pageControl as? UIPageControl {
                p.currentPageIndicatorTintColor = currentPageColor
            } else if let p = pageControl as? TSSCycleScrollViewPageControl {
                p.currentDotColor = currentPageColor
            }
        }
    }
    public var normalPageColor: UIColor = .lightGray {
        didSet {
            if let p = pageControl as? UIPageControl {
                p.pageIndicatorTintColor = normalPageColor
            } else if let p = pageControl as? TSSCycleScrollViewPageControl {
                p.dotColor = normalPageColor
            }
        }
    }
    public var currentPageImage: UIImage? {
        didSet {
            if pageControlStyle != .animated {
                pageControlStyle = .animated
            }
            if let image = currentPageImage {
                setCustomPageControlDotImage(image: image, isCurrent: true)
            }
        }
    }
    public var normalPageImage: UIImage? {
        didSet {
            if pageControlStyle != .animated {
                pageControlStyle = .animated
            }
            if let image = normalPageImage {
                setCustomPageControlDotImage(image: image, isCurrent: false)
            }
        }
    }
    
    
    // block 的方式回调，暂时不实现
//    var clickCallback: ((Int) -> Void)?
//    var scrollCallback: ((Int) -> Void)?
    
    private var timer: Timer?
    private var pageControl: UIControl?
    
    private var isSingleImage: Bool {
        return dataSource.count <= 1
    }
    private var totalItemsCount: Int {
        return infiniteLoop ? dataSource.count * 100 : dataSource.count
    }
    
    private func setupPageControl() {
        if let pageControl = pageControl {
            pageControl.removeFromSuperview()
        }
        if dataSource.count == 0  || (dataSource.count == 1 && hidesForSinglePage) {
            return
        }
        switch pageControlStyle {
        case .animated:
            pageControl = TSSCycleScrollViewPageControl()
            if let p = pageControl as? TSSCycleScrollViewPageControl {
                p.numberOfPages = dataSource.count
                p.currentDotColor = currentPageColor
                p.dotColor = normalPageColor
                p.isUserInteractionEnabled = false
                p.currentPage = currentPageControlIndex
                addSubview(p)
                bringSubviewToFront(p)
            }
        case .default:
            pageControl = UIPageControl()
            if let p = pageControl as? UIPageControl {
                p.numberOfPages = dataSource.count
                p.isUserInteractionEnabled = false
                p.currentPage = currentPageControlIndex
                p.currentPageIndicatorTintColor = currentPageColor
                p.pageIndicatorTintColor = normalPageColor
                addSubview(p)
                bringSubviewToFront(p)
            }
        }
        if let image = currentPageImage {
            currentPageImage = image
        }
        
        if let image = normalPageImage {
            normalPageImage = image
        }
    }
    
    private func setCustomPageControlDotImage(image: UIImage, isCurrent: Bool) {
        if let p = pageControl as? TSSCycleScrollViewPageControl {
            if isCurrent {
                p.currentPageImage = image
                p.pageControlCornerRadius = self.pageControlCornerRadius
            } else {
                p.normalPageImage = image
                p.pageControlCornerRadius = self.pageControlCornerRadius
            }
        }
    }
    
    private var currentIndex: Int {
        guard collectionView.bounds.size != .zero else {
            return 0
        }
        /*
         var index = 0
         if flowLayout.scrollDirection == .horizontal {
             index = Int((collectionView.contentOffset.x + flowLayout.itemSize.width * 0.5) / flowLayout.itemSize.width)
         } else {
             index = Int((collectionView.contentOffset.y + flowLayout.itemSize.height * 0.5) / flowLayout.itemSize.height)
         }
         return max(0, index)
         */
        
        var index:CGFloat = 0
        if flowLayout.scrollDirection == .horizontal {
            index = collectionView.contentOffset.x / flowLayout.itemSize.width
        } else {
            index = collectionView.contentOffset.y / flowLayout.itemSize.height
        }
        return Int(ceil(index))
    }
    
    private var currentPageControlIndex: Int {
        return currentIndex % dataSource.count
    }
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = scrollDirection
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollsToTop = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
   
    public convenience init(frame: CGRect, delegate:TSSCycleScrollViewDelegate) {
        self.init(frame: frame)
        self.delegate = delegate
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(placeholderImage)
        addSubview(collectionView)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        backgroundColor = .white
        addSubview(placeholderImage)
        addSubview(collectionView)
    }
    //MARK: layoutSubviews=============>
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        flowLayout.itemSize = frame.size
        collectionView.frame = bounds
        if collectionView.contentOffset.x == 0 && totalItemsCount > 0 {
            collectionView.scrollToItem(at: IndexPath(item: infiniteLoop ? totalItemsCount / 2 + 1 : 0, section: 0), at: .left, animated: false)
        }
        var size: CGSize = .zero
        if let p = pageControl as? TSSCycleScrollViewPageControl {
            size = p.sizeForNumber(of: dataSource.count)
        } else {
            guard let p = pageControl as? UIPageControl else { return }
        
//            size = CGSize(width: CGFloat(dataSource.count) * pageControlDotSize.width * 2, height: pageControlDotSize.height)
            size = p.size(forNumberOfPages: dataSource.count)
        }
        var x = (bounds.width - size.width ) / 2
        var y = bounds.height - size.height
        if case let TSSCycleScrollViewPageControlAlignment.right(right, bottom) = pageControlAlignment {
            x = collectionView.bounds.width - size.width + right
            y = bounds.height - size.height
            var bounds = bounds
            bounds.size.height = bounds.height - bottom
            
            flowLayout.itemSize = bounds.size
            collectionView.frame = bounds
        }
        if case let TSSCycleScrollViewPageControlAlignment.left(left,bottom) = pageControlAlignment {
            x =  left
            y = bounds.height - size.height
            var bounds = bounds
            bounds.size.height = bounds.height - bottom
            
            flowLayout.itemSize = bounds.size
            collectionView.frame = bounds
        }
        if case let TSSCycleScrollViewPageControlAlignment.center(offset) = pageControlAlignment {
            y = bounds.height - size.height
            var bounds = bounds
            bounds.size.height = bounds.height - offset
            
            flowLayout.itemSize = bounds.size
            collectionView.frame = bounds
        }
        
        if let p = pageControl as? TSSCycleScrollViewPageControl {
            p.sizeToFit()
        }
        pageControl?.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
        pageControl?.isHidden = !showPageControl
        
//        placeholderImage.frame = collectionView.bounds
        placeholderImage.widthAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        placeholderImage.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, constant: 0).isActive = true
        placeholderImage.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        placeholderImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        placeholderImage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    // 禁用滑动手势
    public func disableScrollGesture() {
        collectionView.canCancelContentTouches = false
        collectionView.gestureRecognizers?.forEach({ (gesture) in
            if gesture.isKind(of: UIPanGestureRecognizer.self) {
                collectionView.removeGestureRecognizer(gesture)
            }
        })
    }
    
    //MARK: timer
    private func setupTimer() {
        invalidateTimer()
        guard isAutoScroll else { return }
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] (timer) in
            guard let self = self else { return }
            self.autoScroll()
        })
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    @objc private func autoScroll() {
        guard totalItemsCount > 0 else { return }
        scroll(to: currentIndex + 1)
    }
    
    private func scroll(to targetIndex: Int) {
        if targetIndex >= totalItemsCount && infiniteLoop {
            collectionView.scrollToItem(at: IndexPath(item: totalItemsCount / 2, section: 0), at: [.left, .top], animated: false)
        } else {
            collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: [.left, .top], animated: true)
        }
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: clearCache
    public static func clearCache() {
        //MARK: need pod 'Kingfisher'
        //ImageCache.default.clearDiskCache()
    }
    
    deinit {
        TSSLog("TSSCycleScrollView deinit")
    }
}

extension TSSCycleScrollView: UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: register Cell for Default Cell
    private func rgisterDefaultCell(collectionView:UICollectionView){
        Identifier = "TSSCycleScrollViewDefaultCell"
        collectionView.register(TSSCycleScrollViewDefaultCell.self, forCellWithReuseIdentifier: "TSSCycleScrollViewDefaultCell")
    }
    //MARK: register Cell for Class
    private  func registerClass(collectionView:UICollectionView){
        guard let string = self.delegate?.customCollectionViewCellClass() else{return}
        let name = String(cString: object_getClassName(string)).components(separatedBy: ".").last!
        Identifier = name
        collectionView.register(string, forCellWithReuseIdentifier: name)
    }
    //MARK: register Cell for Nib
    private  func registerNib(collectionView:UICollectionView){
        guard let string = self.delegate?.customCollectionViewCellNib() else{ return}
        Identifier = string
        collectionView.register(UINib(nibName: string, bundle: nil), forCellWithReuseIdentifier: string)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemsCount
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if Identifier == ""{
            rgisterDefaultCell(collectionView: collectionView)
            registerClass(collectionView: collectionView)
            registerNib(collectionView: collectionView)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath)
        let itemIndex = self.currentPageControlIndex
        delegate?.setupCustomCell(cell: cell, index: itemIndex, view: self)
        return cell
        
    }
    //MARK: UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cycleScrollView(self, didSelectItemAt: currentPageControlIndex)
    }
}

extension TSSCycleScrollView: UIScrollViewDelegate {
    //MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch pageControl {
        case let pageControl as UIPageControl:
            pageControl.currentPage = currentPageControlIndex
        case let pageControl as TSSCycleScrollViewPageControl:
            pageControl.currentPage = currentPageControlIndex
        default: break
        }
    }
    //MARK: UIScrollViewDelegate
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invalidateTimer()
    }
    //MARK: UIScrollViewDelegate
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setupTimer()
    }
    //MARK: UIScrollViewDelegate
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegate?.cycleScrollView(self, didScrollTo: currentPageControlIndex)
    }
}
