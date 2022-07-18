//
//  ListBaseViewController.swift
//  HCYSegmentedView
//
//  Created by Jupiter_TSS on 15/7/22.
//

import UIKit
import HCYFrameWork
class ListBaseViewController: HCYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .arc4Color()
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
extension ListBaseViewController:HCYSegmentedListContainerViewListDelegate{
    func listView() -> UIView {
        return view
    }
}
extension UIColor{
    class func arc4Color()->UIColor {
        
        return UIColor.init(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
    }
}
