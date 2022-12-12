
import UIKit
import HCYFrameWork
import RxSwift
import Alamofire
class MeViewController: TSSBaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    public typealias success<T:Decodable> = (_ statusCode:Int,_ model:T,_ responseData:Any)->Void
    @IBOutlet weak var tableView: UITableView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.tabBarController?.tabBar.hideBadgeOnItem(index: 2)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        print("KScreenW is \(TSSScreenW) KScreenH is  \(TSSScreenH)")
        print("KisIphoneX is \(TSSisIphoneX)")
        
        let url = "http://testapi.techstudio.mobi/api/NudgesApi/GetNudgesByCategory"
        let parameter = ["catID":"2","subCatId":"6"]
        TSSNetworkingManager.sharedInstance().getRequestWith(url: url, parameters: parameter,dataModel: [HomeTest].self) { statusCode, model, responseData in
            print("model is \(model[0].lastmodifiedDate)")
        } failure: { error in
            
        }
//
//        self.getTest(url: url, parameter: parameter, model: [HomeTest].self) { statusCode, model, responseData in
//            print("model is \(model[0].lastmodifiedDate)")
//        }
//        AF.request(URL(string: url)!,method:.get,parameters:parameter)
        
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
            ["title":"TSSBaseTab","vc":"TestBaseTableViewController"],
            ["title":"TSSBaseCollection","vc":"TeseBaseCollectionViewController"],
            ["title":"CollectionAutoSize","vc":"CollectionViewAutoSize"],
            ["title":"Banner","vc":"TesrBannerViewController"],
            ["title":"testHeader","vc":"CollectionHeaderAutoLayoutViewController"],
            
            
        ])
        items.bind(to: tableView.rx.items){ (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = "\(element["title"]!)"
            cell.textLabel?.font = .systemFont(ofSize: 17.scale())
            return cell
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected([String:Any].self).subscribe(onNext: { data in
            guard let vcName = data["vc"] as? String,
                  let cls = NSClassFromString("\(TSSWorkName!).\(vcName)") as? UIViewController.Type,
                    let title = data["title"] as? String else { return  }
            let vc = cls.init()
            vc.title =  title
            self.tss_currentVCpushTo(vc)
            
        }).disposed(by: disposeBag)
        
    }
    func getTest<T:Decodable>(url:String,
                              parameter:[String:Any],
                              model:T.Type,
                              complet:@escaping success<T>){
        AF.request(url, method: .get, parameters: parameter)
            .responseDecodable(of: T.self) { response in
                    guard let statusCode = response.response?.statusCode else{return}
                    guard let value = response.value else{return}
                    guard let data = response.data else{return}
                complet(statusCode,value,data)
            }
    }
}

