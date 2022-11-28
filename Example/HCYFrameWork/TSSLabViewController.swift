//
//  TSSLabViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 1/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork

class TSSLabViewController: TSSBaseViewController {
    lazy var tssLabel:[TSSLabel] = {
        let tssLabel:[TSSLabel] = []
        return tssLabel
    }()
    let alignment:[TSSLabelAlignment] = [.topleft,.topMiddle,.topright,
                                         .MiddleLeft,.center,.Middleright,
                                         .bottomLeft,.bottomMiddle,.bottomright]
    override func viewDidLoad() {
        super.viewDidLoad()
        alignment.forEach { alignment in
            tssLabel.append(backTSSLabel(alignment))
        }
        tssLabel.forEach { lab in
            view.addSubview(lab)
        }
        
        let topleft = tssLabel[0]
        let topMiddle = tssLabel[1]
        let topright = tssLabel[2]
        
        
        let MiddleLeft = tssLabel[3]
        let center = tssLabel[4]
        let Middleright = tssLabel[5]
        
        
        center.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100.scale())
        }
        MiddleLeft.snp.makeConstraints { make in
            make.centerY.equalTo(center)
            make.width.height.equalTo(100.scale())
            make.right.equalTo(center.snp.left).offset(-20.scale())
        }
        
        Middleright.snp.makeConstraints { make in
            make.centerY.equalTo(center)
            make.width.height.equalTo(100.scale())
            make.left.equalTo(center.snp.right).offset(20.scale())
        }
        
        
        
        
        topMiddle.snp.makeConstraints { make in
            make.centerX.equalTo(center)
            make.width.height.equalTo(100.scale())
            make.bottom.equalTo(center.snp.top).offset(-20.scale())
        }
        
        topleft.snp.makeConstraints { make in
            make.centerY.equalTo(topMiddle)
            make.width.height.equalTo(100.scale())
            make.left.equalTo(MiddleLeft)
        }
        
        topright.snp.makeConstraints { make in
            make.centerY.equalTo(topMiddle)
            make.width.height.equalTo(100.scale())
            make.right.equalTo(Middleright)
        }
        
        
        
        
        
        
        
        let bottomLeft = tssLabel[6]
        let bottomMiddle = tssLabel[7]
        let bottomright = tssLabel[8]
        bottomLeft.snp.makeConstraints { make in
            make.left.equalTo(MiddleLeft)
            make.width.height.equalTo(100.scale())
            make.top.equalTo(MiddleLeft.snp.bottom).offset(20.scale())
        }
        bottomMiddle.snp.makeConstraints { make in
            make.centerX.equalTo(center)
            make.centerY.equalTo(bottomLeft)
            make.width.height.equalTo(100.scale())
        }
        
        bottomright.snp.makeConstraints { make in
            make.right.equalTo(Middleright)
            make.centerY.equalTo(bottomLeft)
            make.width.height.equalTo(100.scale())
        }
        
       
        // Do any additional setup after loading the view.
    }

    func backTSSLabel(_ alignment:TSSLabelAlignment)->TSSLabel{
        let attributedText = NSAttributedString(string: "attributedText")
        let tsslab = TSSLabel(frame: .zero,
                              alignment: alignment,
                              text: "TestText",
                              textColor: .blue,
                              font: .systemFont(ofSize: 20.scale()),
                              numberOfLines: 0,
                              attributedText: attributedText)
        tsslab.backgroundColor = .gray
        return tsslab
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
