//
//  UIImgae_svgImgWithViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 2/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import HCYFrameWork
class UIImgae_svgImgWithViewController: TSSBaseViewController {

    @IBOutlet weak var imageup: UIImageView!
    @IBOutlet weak var imageDowm: UIImageView!
    
    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var imageRight: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageup.image = backImage(orientation: .up)
        imageDowm.image = backImage(orientation: .down)
        imageLeft.image = backImage(orientation: .left)
        imageRight.image = backImage(orientation: .right)
        
    }

    func backImage(orientation: UIImage.Orientation)->UIImage{
        let image = UIImage.svgImgWith(name: "eye_off.svg", size: CGSize(width: 50, height: 50), color: .arc4Color(), orientation: orientation)
        return image
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
