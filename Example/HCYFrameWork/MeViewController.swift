
import UIKit
import HCYFrameWork
class MeViewController: HCYBaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = "将要进入后台"
        HCYNotiFicationCenter.shared.addObserver(name: name, object: self) { notiFication in
//            notiFication.info()
            DebugLog("\(notiFication.name) \(notiFication.data) B")
        }
    }
    override func setupNavigationItems() {
        title = "我的"
        hcy_addRightButton(title:"haha") {
            
        }
    }
}

extension MeViewController{
//    override func willResignActiveNotification() {
//        DebugLog("将要进入后台 B")
//    }
}
