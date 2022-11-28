//
//  TeseBaseCollectionViewModel.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 28/11/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import HCYFrameWork
class TeseBaseCollectionViewModel:ScrollViewRefreshProtocol{
    
    let disposeBag = DisposeBag()
    var scroller:UICollectionView? = nil
    var refreshStatus = BehaviorRelay<ScrollViewRefreshStatus>(value: .beingHeaderRefresh)
    init(){
        
    }
    func bind(_ scroller:UICollectionView){
        self.scroller = scroller
        let header = scroller.initRefreshHeader {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self]  in
                guard let weakSelf = self else{return}
                weakSelf.refreshStatus.accept(.endHeaderRefresh)
            }
       }
       let footer =  scroller.initRefreshFooter {
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self]  in
               guard let weakSelf = self else{return}
               weakSelf.refreshStatus.accept(.endFooterRefresh)
           }
       }
       _ = autoSetRefreshHeaderStatus(header: header, footer: footer).disposed(by: disposeBag)
    }
    
    
}
