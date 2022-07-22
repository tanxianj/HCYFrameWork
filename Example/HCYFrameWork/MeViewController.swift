
import UIKit
import HCYFrameWork
import RxSwift
class MeViewController: TSSBaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        let name = "将要进入后台"
//        HCYNotiFicationCenter.shared.addObserver(name: name, object: self) { notiFication in
////            notiFication.info()
//            DebugLog("\(notiFication.name) \(notiFication.data) B")
//        }
//        image.hcySetImageWith(url: "https://img1.baidu.com/it/u=1966616150,2146512490&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1657904400&t=a5420d6110e949d35855acdd28b6f6e4", placeholder: "网络错误")
        let items = Observable.just([
            ["title":"HCYSegmentedView","vc":TSSSegmentedViewDemo()],
            ["title":"HCYPopUp","vc":PopUpDemoViewController()],
            
        ])
        items.bind(to: tableView.rx.items){ (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = "\(element["title"]!)"
            return cell
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected([String:Any].self).subscribe(onNext: { data in
            guard let vc = data["vc"] as? UIViewController ,let title = data["title"] as? String else { return  }
            vc.title =  title
            self.tss_currentVCpushTo(vc)
            
        }).disposed(by: disposeBag)
    }
    override func setupNavigationItems() {
        title = "我的"
        tss_addRightButton(title:"haha") {
            
        }
    }
}

extension MeViewController{
//    override func willResignActiveNotification() {
//        DebugLog("将要进入后台 B")
//    }
}

