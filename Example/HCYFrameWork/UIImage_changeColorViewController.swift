//
//  UIImage_changeColorViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 2/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class UIImage_changeColorViewController: TSSBaseViewController {
    @IBOutlet weak var icon_one: UIImageView!
    @IBOutlet weak var icon_Two: UIImageView!
    @IBOutlet weak var icon_Three: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        icon_one.image = icon_one.image!.changeColor(color: .red)
        icon_Two.image = icon_Two.image!.changeColor(color: .blue)
        icon_Three.image = icon_Three.image!.changeColor(color: .purple)
        
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
