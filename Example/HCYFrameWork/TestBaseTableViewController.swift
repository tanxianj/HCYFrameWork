//
//  TestBaseTableViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 9/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork

class TestBaseTableViewController: TSSBaseTableViewController {
    var viewModel = TestBaseTableViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tssCell")
        
        let testView = UIView()
        testView.backgroundColor = .purple
        self.topView.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(100.scale())
        }
        self.viewModel.bind(self.tableView)
        
        
        
    }
    
    

}
extension TestBaseTableViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tssCell", for: indexPath)
        cell.contentView.backgroundColor = .arc4Color().alpha(0.2)
        return cell
    }
}
