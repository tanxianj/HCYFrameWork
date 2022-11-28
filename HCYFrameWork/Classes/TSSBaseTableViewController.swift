//
//  TSSBaseTableViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 9/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
open class TSSBaseTableViewController: TSSBaseViewController {
    
    /// tableView top View
    public lazy var topView:UIView = {
        let topView = UIView()
        
        return topView
    }()
    
    /// TableView
    public lazy var tableView:UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    /// init
    open override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: 自定义TableView属性
        setUpTableView()
        
        //MARK: add topView for self.view
        self.view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
            make.height.lessThanOrEqualTo(0).priority(.low)
        }
        
        //MARK: add tableView for self.view
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view)
        }
        
        
    }
    open func setUpTableView(){
        self.tableView.backgroundColor = .white
        self.tableView.separatorColor = .clear
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 0.01)))
        self.tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 0.01)))
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
            
        } else {
            // Fallback on earlier versions
        }
    }
}

