
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
        print("KScreenW is \(KScreenW) KScreenH is  \(KScreenH)")
        print("KisIphoneX is \(KisIphoneX)")
//        let name = "将要进入后台"
//        HCYNotiFicationCenter.shared.addObserver(name: name, object: self) { notiFication in
////            notiFication.info()
//            DebugLog("\(notiFication.name) \(notiFication.data) B")
//        }
//        image.hcySetImageWith(url: "https://img1.baidu.com/it/u=1966616150,2146512490&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1657904400&t=a5420d6110e949d35855acdd28b6f6e4", placeholder: "网络错误")
        /*
         let workName = Bundle.main.infoDictionary?["CFBundleExecutable"]
         if let cls = NSClassFromString("\(workName!).TSSSegmentedViewDemo") as? UIViewController.Type{
             let vc = cls.init()
             self.tss_currentVCpushTo(vc)
         }
         */
        
        
        let items = Observable.just([
            ["title":"HCYSegmentedView","vc":"TSSSegmentedViewDemo"],
            ["title":"HCYPopUp","vc":"PopUpDemoViewController"],
            ["title":"TimeHelper","vc":"TimeHelperViewController"],
            ["title":"TSSString","vc":"GetLabelWidthHeightViewController"],
            ["title":"TSSActionSheet(未导入FrameWork)","vc":"ActionSheetViewController"],
            ["title":"TSSNetwork","vc":"NetWorkViewController"],
            ["title":"AutoLayout","vc":"AutoLayoutViewController"],
            ["title":"TSSLabel","vc":"TSSLabViewController"],
            ["title":"TSSDefaultView","vc":"TSSDefaultViewViewController"],
            ["title":"TSSColor","vc":"TSSColorViewController"],
            ["title":"TSSUIDevice","vc":"UIDeviceViewController"],
            ["title":"TSSUIImage","vc":"UIimageViewController"],
            ["title":"ChangeTextFieldColor","vc":"ChangeTextFieldColorViewController"],
            ["title":"TSSValidate","vc":"TSSValidateViewController"],
            ["title":"TSSNotiFication","vc":"TSSNotiFicationViewController"],
            
            
        ])
        items.bind(to: tableView.rx.items){ (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = "\(element["title"]!)"
            cell.textLabel?.font = .systemFont(ofSize: 17.scale())
            return cell
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected([String:Any].self).subscribe(onNext: { data in
            guard let vcName = data["vc"] as? String,
                  let cls = NSClassFromString("\(KWorkName!).\(vcName)") as? UIViewController.Type,
                    let title = data["title"] as? String else { return  }
            let vc = cls.init()
            vc.title =  title
            self.tss_currentVCpushTo(vc)
            
        }).disposed(by: disposeBag)
    }
//    override func setupNavigationItems() {
//        title = "Me"
//        tss_addRightButton(title:"right btn") {
//            
//        }
//    }
}

extension MeViewController{
//    override func willResignActiveNotification() {
//        DebugLog("将要进入后台 B")
//    }
}

