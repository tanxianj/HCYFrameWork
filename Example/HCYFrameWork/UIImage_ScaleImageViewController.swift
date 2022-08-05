//
//  UIImage_ScaleImageViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 2/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class UIImage_ScaleImageViewController: TSSBaseViewController {
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: "MyNotes_Landing")!.ScaleImage(newSize: CGSize(width: 50, height: 50))
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
