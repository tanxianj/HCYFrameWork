//
//  TSSSegmentedViewDemo.swift
//  TSSFrameWork_Example
//
//  Created by Jupiter_TSS on 18/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class TSSSegmentedViewDemo: TSSBaseViewController {
    let titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
//    let titles = ["1", "2", "3"]
    lazy var segmentedDataSource: TSSSegmentedBaseDataSource = {
        let dataSource = TSSSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = titles
        dataSource.titleNormalColor = .blue
        return dataSource
    }()
    lazy var segmentedView:TSSSegmentedView = {
        let segmentedView = TSSSegmentedView()
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self

        
        //配置指示器
        let indicator = TSSSegmentedIndicatorLineView()
//        indicator.indicatorWidth = 20
        indicator.lineStyle = .lengthenOffset
        indicator.indicatorColor = .blue
        

        segmentedView.indicators = [indicator]

        return segmentedView
    }()
    lazy var listContainerView: TSSSegmentedListContainerView = {
        return TSSSegmentedListContainerView(dataSource: self)
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
            if (indicaotr as? TSSSegmentedIndicatorLineView) != nil {
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
        for indicaotr in (segmentedView.indicators as! [TSSSegmentedIndicatorBaseView]) {
            if indicaotr.indicatorPosition == .bottom {
                indicaotr.indicatorPosition = .top
            }else {
                indicaotr.indicatorPosition = .bottom
            }
        }
        segmentedView.reloadDataWithoutListContainer()
    }
    

}


extension TSSSegmentedViewDemo: TSSSegmentedViewDelegate {
    func segmentedView(_ segmentedView: TSSSegmentedView, didSelectedItemAt index: Int) {

        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}

extension TSSSegmentedViewDemo: TSSSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: TSSSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? TSSSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: TSSSegmentedListContainerView, initListAt index: Int) -> TSSSegmentedListContainerViewListDelegate {
        return ListBaseViewController()
    }
}
