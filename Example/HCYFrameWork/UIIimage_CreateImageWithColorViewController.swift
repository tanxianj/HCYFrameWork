//
//  UIIimage_CreateImageWithColorViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 2/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class UIIimage_CreateImageWithColorViewController: TSSBaseViewController {

    @IBOutlet weak var imageup: UIImageView!
    @IBOutlet weak var imageDowm: UIImageView!
    
    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var imageRight: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageup.image = backImage()
        imageDowm.image = backImage()
        imageLeft.image = backImage()
        imageRight.image = backImage()
        // Do any additional setup after loading the view.
    }
    func backImage()->UIImage{
        let image = UIImage.CreateImageWithColor(color: .arc4Color(), size: CGSize(width: 50, height: 50))
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
