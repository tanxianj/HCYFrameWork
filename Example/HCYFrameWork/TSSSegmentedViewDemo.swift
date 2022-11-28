//
//  TSSSegmentedViewDemo.swift
//  TSSFrameWork_Example
//
//  Created by Jupiter_TSS on 18/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class TSSSegmentedViewDemo: UITableViewController {

    let dataSource = ["LineView固定长度","LineView与Cell同宽","LineView延长style","LineView延长+偏移style","指示器宽度跟随内容而不是cell宽度"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.rowHeight = 44
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.navigationItem.leftBarButtonItem = self.tss_createNavigationItem(type: .left, imageName: "return",itemAction: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        var itemTitle: String?
        for subview in cell!.contentView.subviews {
            if let label = subview as? UILabel {
                itemTitle = label.text
                break
            }
        }

        let titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
        let vc = ContentBaseViewController()
        vc.title = itemTitle

        switch itemTitle! {
        case "LineView固定长度":
            //配置数据源
            let dataSource = TSSSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            vc.segmentedDataSource = dataSource
            //配置指示器
            let indicator = TSSSegmentedIndicatorLineView()
            indicator.indicatorWidth = 20
            vc.segmentedView.indicators = [indicator]
        case "LineView与Cell同宽":
            //配置数据源
            let dataSource = TSSSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            vc.segmentedDataSource = dataSource
            //配置指示器
            let indicator = TSSSegmentedIndicatorLineView()
            indicator.indicatorWidth = TSSSegmentedViewAutomaticDimension
            vc.segmentedView.indicators = [indicator]
        case "LineView延长style":
            //配置数据源
            let dataSource = TSSSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            vc.segmentedDataSource = dataSource
            //配置指示器
            let indicator = TSSSegmentedIndicatorLineView()
            indicator.indicatorWidth = TSSSegmentedViewAutomaticDimension
            indicator.lineStyle = .lengthen
            vc.segmentedView.indicators = [indicator]
        case "LineView延长+偏移style":
            //配置数据源
            let dataSource = TSSSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = titles
            vc.segmentedDataSource = dataSource
            //配置指示器
            let indicator = TSSSegmentedIndicatorLineView()
            indicator.indicatorWidth = TSSSegmentedViewAutomaticDimension
            indicator.lineStyle = .lengthenOffset
            vc.segmentedView.indicators = [indicator]
        case "指示器宽度跟随内容而不是cell宽度":
            //配置数据源
            let dataSource = TSSSegmentedTitleDataSource()
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = ["很长的第一名", "第二", "普通第三"]
            dataSource.itemWidth = view.bounds.size.width/3
            dataSource.itemSpacing = 0
            dataSource.isTitleZoomEnabled = true
            vc.segmentedDataSource = dataSource
            //配置指示器
            let indicator = TSSSegmentedIndicatorLineView()
            indicator.indicatorWidth = TSSSegmentedViewAutomaticDimension
            indicator.isIndicatorWidthSameAsItemContent = true
            vc.segmentedView.indicators = [indicator]
        default:
            break
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}




