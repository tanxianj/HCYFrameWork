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
    @IBOutlet weak var tableView: UITableView!
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .default
    }
    override func hcy_hiddenNavigationBarHidden() -> Bool {
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.delegate = self
        /*
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
         image.image = UIImage.svgImgWith(name: "SVG", size: CGSize(width: 20, height: 20), color: .red,orientation: .up)
         //        image.image = SVGKImage.init(named: "eye_off").uiImage
         self.view.addSubview(image)
         image.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.height.width.equalTo(22.5)
         make.top.equalToSuperview().offset(28.5)
         }
         */
        let name = "将要进入后台"
        HCYNotiFicationCenter.shared.addObserver(name: name, object: self) { notiFication in
//            notiFication.info()
            DebugLog("\(notiFication.name)  \(notiFication.data) A")
        }
        
       
        
        
    }
    
    override func willResignActiveNotification() {
        DebugLog("将要进入后台 A")
    }
    
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HometableViewCell.Identifier(), for: indexPath) as! HometableViewCell
        cell.titleLab.text = "index row \(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // Editing
       
    //头部滑动事件按钮（右滑按钮）
      func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt
          indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          //创建“更多”事件按钮
          let unread = UIContextualAction(style: .normal, title: "未读") {
              (action, view, completionHandler) in
              DebugLog("点击了“未读”按钮")
              completionHandler(true)
          }
          unread.backgroundColor = UIColor(red: 52/255, green: 120/255, blue: 246/255,
                                           alpha: 1)
          
          let read = UIContextualAction(style: .normal, title: "已读") { action, view, completionHandler in
              DebugLog("点击了“已读读”按钮")
              completionHandler(true)
          }
          read.image = UIImage(named: "首页")
          //返回所有的事件按钮
          let configuration = UISwipeActionsConfiguration(actions: [unread,read])
          return configuration
      }
       
      //尾部滑动事件按钮（左滑按钮）
      func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
          indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          //创建“更多”事件按钮
          let more = UIContextualAction(style: .normal, title: "更多") {
              (action, view, completionHandler) in
              DebugLog("点击了“更多”按钮")
              completionHandler(true)
          }
          more.backgroundColor = .lightGray
           
          //创建“旗标”事件按钮
          let favorite = UIContextualAction(style: .normal, title: "旗标") {
              (action, view, completionHandler) in
              DebugLog("点击了“旗标”按钮")
              completionHandler(true)
          }
          favorite.backgroundColor = .orange
           
           
          //创建“删除”事件按钮
          let delete = UIContextualAction(style: .destructive, title: "删除") {
              (action, view, completionHandler) in
              //将对应条目的数据删除
//              self.items.remove(at: indexPath.row)
              DebugLog("点击了删除")
              completionHandler(true)
          }
          delete.backgroundColor = .blue
          //返回所有的事件按钮
          let configuration = UISwipeActionsConfiguration(actions: [delete, favorite, more])
          return configuration
      }
       
}
class HometableViewCell:UITableViewCell{
    @IBOutlet weak var titleLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
