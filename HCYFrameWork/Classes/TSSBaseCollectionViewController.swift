//
//  TSSBaseCollectionViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 10/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
open class TSSBaseCollectionViewController: TSSBaseViewController {
    /// collectionView top View
    public lazy var topView:UIView = {
        let topView = UIView()
        
        return topView
    }()
    
    /// collectionView Layout
    public lazy var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    private var horizontalLayout:UICollectionViewLayout?
    private var verticalLayout:UICollectionViewLayout?
    /// collectionView
    public lazy var collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    /// init
    open override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: 自定义TableView属性
        setUpCollectionView()
        
        //MARK: add topView for self.view
        self.view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
            make.height.lessThanOrEqualTo(0).priority(.low)
        }
        
        //MARK: add tableView for self.view
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view)
        }
        
        
    }

    
    /// set Up CollectionView
    open func setUpCollectionView(){
        self.collectionView.backgroundColor = .white
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
    }
    
}
extension TSSBaseCollectionViewController{
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        let duration:TimeInterval = coordinator.transitionDuration
        
        if UIDevice.tss_isLandscape(){
            collectionView.collectionViewLayout = horizontalLayout ?? layout
        }else{
            collectionView.collectionViewLayout = verticalLayout ?? layout
        }
        
    }
    
    /// Fit horizontal Layout vertical Layout
    /// - Parameters:
    ///   - horizontalLayout: horizontal Layout
    ///   - verticalLayout: vertical Layout
    public final func tss_FitLayoutWith(horizontalLayout:UICollectionViewLayout,
                                       verticalLayout:UICollectionViewLayout){
        self.horizontalLayout = horizontalLayout
        self.verticalLayout = verticalLayout
    }
    
}
