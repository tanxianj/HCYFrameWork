//
//  HomeViewController.swift
//  ProjectMould
//
//  Created by Jupiter_TSS on 1/6/22.
//

import UIKit
import SVGKit
import HCYFrameWork
class HomeViewController: HCYBaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    override func hcy_hiddenNavigationBarHidden() -> Bool {
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .arc4Color()
        let image = UIImageView()
//        let image = UIView(SVGNamed: "fistBump"){ svgLayer in
//            svgLayer.fillColor = UIColor.red.cgColor
//               svgLayer.resizeToFit(self.view.bounds)
//        }
//        image.backgroundColor = .blue
//        image.layer.sublayers?.forEach({ layer in
//            (layer as? CAShapeLayer)?.fillColor = UIColor.red.cgColor
//        })
//        image.image = UIImage(named: "Icon")
//        image.image = UIImage(named: "Icon")?.changeColor(color: .blue)
        image.image = UIImage.svgImgWith(name: "SVG", size: CGSize(width: 20, height: 20), color: .red,orientation: .right)
//        image.image = SVGKImage.init(named: "eye_off").uiImage
        self.view.addSubview(image)
        image.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(22.5)
            make.top.equalToSuperview().offset(28.5)
        }
        
    }
   

}
import SVGKit
//extension UIImage{
//    public class func svgImgWith(name:String, size:CGSize, color:UIColor) -> UIImage{
//        let svgImg = SVGKImage.init(named: name)
//        svgImg?.size = size
//        svgImg?.caLayerTree.sublayers?.forEach({ layer in
//            (layer as? CAShapeLayer)?.fillColor = color.cgColor
//        })
//        if let cgimage = svgImg?.uiImage.ciImage {
//            let a = UIImage(ciImage: cgimage, scale: 1.0, orientation: .down)
//            return a
//        }
//        return svgImg?.uiImage ?? UIImage()
//    }
//    
//}
