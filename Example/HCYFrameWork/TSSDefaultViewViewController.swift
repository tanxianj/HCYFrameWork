//
//  TSSDefaultViewViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 1/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class TSSDefaultViewViewController: TSSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tss_loadingView = TSSDefaultView.loadingViewWithDefaultRefreshingBlock(mainAction: {[weak self]  in
            guard let weakSelf = self else {return}
            weakSelf.loadData()
            
        })
        loadData()
        
        
        // Do any additional setup after loading the view.
    }
    func loadData(){
        self.view.tss_loadingView.beginRefreshing()
        TSSGCDTools.delay(5) {[weak self]  in
            guard let weakSelf = self else {return}
            weakSelf.view.tss_loadingView.endRefreshingWithNoDataString()
        }
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
