//
//  GetLabelWidthHeightViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 25/7/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class GetLabelWidthHeightViewController: TSSBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let word = "This Test word for get Label Width"
        let label = createLabel(word)
        
        label.frame = CGRect(origin: .zero, size: CGSize(width: word.getLabelWidth(font: .systemFont(ofSize: 17.0), height: 30), height: 30))
        self.view.addSubview(label)
        
        
        let word2 = "This Test word for get Label height"
        let label2 = createLabel(word2)
        
    
        label2.frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 100, height: word2.getLabelHeight(font: .systemFont(ofSize: 17.0), width: 100)))
        self.view.addSubview(label2)
        let str = "12345"
        let md5str = str.md5
        
        let md5lab = UILabel()
        md5lab.numberOfLines = 0
        md5lab.text = "\(str) 的Md5 is\n \(md5str)"
        md5lab.font = .systemFont(ofSize: 17.scale())
        view.addSubview(md5lab)
        md5lab.snp.makeConstraints { make in
            make.left.equalTo(label2)
            make.top.equalTo(label2.snp.bottom).offset(20.scale())
            make.centerX.equalToSuperview()
        }
        let dic = ["a":"a","b":"b"]
        let dicString = dic.toJsonString()
        print("\(dic) toJsonString is \(dicString)  ")
        
        
        // Do any additional setup after loading the view.
    }
    func createLabel(_ text:String)->UILabel{
        let label = UILabel()
        let word = text
        label.text = word
        label.textColor = .red
        label.font = .systemFont(ofSize: 17.0)
        label.backgroundColor = .gray
        label.numberOfLines = 0
        return label
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
