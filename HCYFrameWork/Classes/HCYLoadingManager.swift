//
//  HCYLoading.swift
//
//
//  Created by Jupiter_TSS on 22/4/22.
//

import Foundation
import UIKit
fileprivate let keyWindow = UIApplication.shared.keyWindow!
class HCYLoadingManager:UIView{
    private var loader:HCYLoadingCircle!
    private lazy var tipsLab:UILabel = {
        let lab = UILabel()
        lab.textColor = .red
        return lab
    }()
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    private init(){
        super.init(frame: .zero)
    }
    private func addSubViews() {
        self.loader = HCYLoadingCircle()
        addSubview(loader)
        loader.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 70.scale(), height: 70.scale()))
        }
    }
    class func show(){
        DispatchQueue.main.async {
            let loadmanager = HCYLoadingManager(frame: keyWindow.bounds)
            keyWindow.addSubview(loadmanager)
            keyWindow.bringSubviewToFront(loadmanager)
            loadmanager.backgroundColor = .clear
            loadmanager.loader.alpha = 0.0
            UIView.animate(withDuration: 0.2) {
                loadmanager.backgroundColor = UIColor.colorWithHexString("000000", alpha: 0.3)
                loadmanager.loader.alpha = 1.0
                loadmanager.loader.startAnimating()
            }
        }
    }
    class func hidden(){
        let subViews = keyWindow.subviews
        if let view = subViews.first(where: {$0.isKind(of: HCYLoadingManager.self)}) as? HCYLoadingManager {
            view.loader.removeFromSuperview()
            view.removeFromSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
