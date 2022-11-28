//
//  TesrBannerViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 11/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
fileprivate let pageControloffset:CGFloat = 13.scale()
fileprivate let pageControlheight:CGFloat = 5.0.scale()
class TesrBannerViewController: TSSBaseViewController {
    fileprivate lazy var bannerView:TSSCycleScrollView = {
        let bannerView = TSSCycleScrollView(frame: .zero, delegate: self)
        bannerView.backgroundColor = .gray
        bannerView.pageControlAlignment = /*.right(rightOfset: 0, bottomOfset: 0)*/.left(leftOfset: 0, bottomOfset: 10)//.center(offset: pageControloffset)
        
        bannerView.currentPageImage = UIImage(colors: [.colorWithHexString("#4FB4B7")], size: CGSize(width: 15.0.scale(), height: pageControlheight))
        bannerView.normalPageImage = UIImage(colors: [.colorWithHexString("#DEDEDE")], size: CGSize(width: 15.0.scale(), height: pageControlheight))
        
        bannerView.pageControlCornerRadius = 2.5.scale()
        bannerView.placeholderImage.image = UIImage(named: "smpbanner")
        bannerView.placeholderImage.contentMode = .scaleAspectFit
        bannerView.placeholderImage.layoutIfNeeded()

        return bannerView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        bannerView.dataSource = [1,2,3,4,5]
        bannerView.dataSource = ["https://img1.baidu.com/it/u=1966616150,2146512490&fm=253&fmt=auto&app=138&f=JPEG?w=751&h=500",
                                 "https://img2.baidu.com/it/u=1572613686,938558453&fm=253&fmt=auto&app=120&f=JPEG?w=640&h=400",
                                 "https://img2.baidu.com/it/u=436635185,1433075744&fm=253&fmt=auto&app=138&f=JPEG?w=666&h=500",
                                 "https://img0.baidu.com/it/u=1880899726,3824907986&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500"]
    }
    override func addSubViews() {
        self.view.addSubview(bannerView)
    }
    override func setupSubViewMargins() {
        bannerView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(TSSScreenW / 16.0 * 9.0)
        }
    }
    

}
extension TesrBannerViewController:TSSCycleScrollViewDelegate{
    
    
    func setupCustomCell(cell: UICollectionViewCell, index: Int, view: TSSCycleScrollView) {
        guard let cell = cell as? TSSCycleScrollViewDefaultCell else{return}
//        cell.titleLab.text = "第\(index)页"
//        cell.imageView.backgroundColor = .arc4Color()
        cell.imageView.kf.setImage(with: URL(string: view.dataSource[index] as! String))
    }
    func cycleScrollView(_ scrollView: TSSCycleScrollView, didSelectItemAt index: Int) {
        TSSLog("点击\(index)")
    }
    func cycleScrollView(_ scrollView: TSSCycleScrollView, didScrollTo index: Int) {
        TSSLog("滚动到\(index)")
    }
//    func customCollectionViewCellNib() -> String? {
//        return "TestBannerCollectionViewCell"
//    }
    
}
