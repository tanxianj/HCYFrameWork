//
//  UIimageViewController.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 2/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import HCYFrameWork

class UIimageViewController: TSSBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        
        
        let items = Observable.just([
            ["title":"UIImgae_svgImgWith","vc":UIImgae_svgImgWithViewController()],
            ["title":"UIIimage_CreateImageWithColor","vc":UIIimage_CreateImageWithColorViewController()],
            ["title":"UIimage_CreateImageWithGrad","vc":UIimage_CreateImageWithGradViewController()],
            ["title":"UIImage_convenienceInit","vc":UIImage_convenienceInitViewController()],
            ["title":"UIImage_ScaleImage","vc":UIImage_ScaleImageViewController()],
            ["title":"UIImage_ChageColor","vc":UIImage_changeColorViewController()],
            
            
            
        ])
        items.bind(to: tableView.rx.items){ (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            cell.textLabel?.text = "\(element["title"]!)"
            cell.textLabel?.font = .systemFont(ofSize: 17.scale())
            return cell
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected([String:Any].self).subscribe(onNext: { data in
            guard let vc = data["vc"] as? UIViewController ,let title = data["title"] as? String else { return  }
            vc.title =  title
            self.tss_currentVCpushTo(vc)
            
        }).disposed(by: disposeBag)
        
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
