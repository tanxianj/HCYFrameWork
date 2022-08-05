//
//  codeAutoLayoutViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 1/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
class codeAutoLayoutViewController: TSSBaseViewController {
    lazy var testLab:UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 17.scale())
        lab.text = "UILabel:文字原始size 17 当前size \(17.scale())"
        lab.numberOfLines = 0
        return lab
    }()
    lazy var testButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("This is UIButton", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17.scale())
        btn.backgroundColor = .gray
        btn.setTitleColor(UIColor.white, for: .normal)
        return btn
    }()
    lazy var testView:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(testLab)
        testLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20.scale())
            make.left.equalToSuperview().offset(20.scale())
        }
        
        
        view.addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(testLab.snp.bottom).offset(20.scale())
//            make.width.equalTo(btnW)
            make.height.equalTo(50.scale())
        }
        
        view.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(testButton.snp.bottom).offset(20.scale())
            make.width.height.equalTo(100.scale())
        }
        // Do any additional setup after loading the view.
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
