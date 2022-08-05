//
//  ContentBaseViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 2/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class ContentBaseViewController: TSSBaseViewController {
    var segmentedDataSource: TSSSegmentedBaseDataSource?
    let segmentedView = TSSSegmentedView()
    lazy var listContainerView: TSSSegmentedListContainerView! = {
        return TSSSegmentedListContainerView(dataSource: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        view.addSubview(segmentedView)

        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)

        

        
     
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50)
        listContainerView.frame = CGRect(x: 0, y: 50, width: view.bounds.size.width, height: view.bounds.size.height - 50)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ContentBaseViewController: TSSSegmentedViewDelegate {
    func segmentedView(_ segmentedView: TSSSegmentedView, didSelectedItemAt index: Int) {
       

        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}

extension ContentBaseViewController: TSSSegmentedListContainerViewDataSource {
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
