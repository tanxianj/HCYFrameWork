//
//  HCYSegmentedViewDemo.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 18/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class HCYSegmentedViewDemo: HCYBaseViewController {
    let titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
//    let titles = ["1", "2", "3"]
    lazy var segmentedDataSource: HCYSegmentedBaseDataSource = {
        let dataSource = HCYSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = titles
        dataSource.titleNormalColor = .blue
        return dataSource
    }()
    lazy var segmentedView:HCYSegmentedView = {
        let segmentedView = HCYSegmentedView()
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self

        
        //配置指示器
        let indicator = HCYSegmentedIndicatorLineView()
//        indicator.indicatorWidth = 20
        indicator.lineStyle = .lengthenOffset
        indicator.indicatorColor = .blue
        

        segmentedView.indicators = [indicator]

        return segmentedView
    }()
    lazy var listContainerView: HCYSegmentedListContainerView = {
        return HCYSegmentedListContainerView(dataSource: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        
        view.addSubview(segmentedView)

        segmentedView.listContainer = listContainerView
        segmentedView.defaultSelectedIndex = 8
        
        view.addSubview(listContainerView)
        
        segmentedView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        listContainerView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(segmentedView.snp.bottom)
        }
        for indicaotr in segmentedView.indicators {
            if (indicaotr as? HCYSegmentedIndicatorLineView) != nil {
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "指示器位置切换", style: UIBarButtonItem.Style.plain, target: self, action: #selector(didIndicatorPositionChanged))
                break
            }
        }

     
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //处于第一个item的时候，才允许屏幕边缘手势返回
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50)
//        listContainerView.frame = CGRect(x: 0, y: 50, width: view.bounds.size.width, height: view.bounds.size.height - 50)
//    }

    

    @objc func didIndicatorPositionChanged() {
        for indicaotr in (segmentedView.indicators as! [HCYSegmentedIndicatorBaseView]) {
            if indicaotr.indicatorPosition == .bottom {
                indicaotr.indicatorPosition = .top
            }else {
                indicaotr.indicatorPosition = .bottom
            }
        }
        segmentedView.reloadDataWithoutListContainer()
    }
    

}


extension HCYSegmentedViewDemo: HCYSegmentedViewDelegate {
    func segmentedView(_ segmentedView: HCYSegmentedView, didSelectedItemAt index: Int) {

        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}

extension HCYSegmentedViewDemo: HCYSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: HCYSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? HCYSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: HCYSegmentedListContainerView, initListAt index: Int) -> HCYSegmentedListContainerViewListDelegate {
        return ListBaseViewController()
    }
}
