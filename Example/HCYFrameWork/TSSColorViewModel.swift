//
//  TSSColorViewModel.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 1/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import HCYFrameWork
import RxSwift
import RxCocoa
import RxRelay
class TSSColorViewModel:TSSBaseViewModelType{
    var input: Input
    var output: Output
    let disposeBag = DisposeBag()
    struct Input{
        var r:AnyObserver<String>
        let g:AnyObserver<String>
        let b:AnyObserver<String>
        let hex:AnyObserver<String>
        
        
        let rgbbtn:AnyObserver<Void>
        let hexBtn:AnyObserver<Void>
    }
    struct Output{
        let rgb:Driver<UIColor>
        let rgbBtn:Observable<Bool>
        let hexColor:Driver<UIColor>
        let hexBtn:Observable<Bool>
        
    }
    private let r_object = PublishSubject<String>()
    private let g_object = PublishSubject<String>()
    private let b_object = PublishSubject<String>()
    private let hex_object = PublishSubject<String>()
    
    private let rgbBtn_object = PublishSubject<Void>()
    private let hexBtn_object = PublishSubject<Void>()
    
    init(){
        input = Input(r: r_object.asObserver(),
                      g: g_object.asObserver(),
                      b: b_object.asObserver(),
                      
                      hex: hex_object.asObserver(),
                      
                      rgbbtn: rgbBtn_object.asObserver(),
                      hexBtn: hexBtn_object.asObserver())
        
        

//
//        let tmprgb =  Observable.zip(r_object.asObserver(),
//                                     g_object.asObserver(),
//                                     b_object.asObserver())
//            .observeOn(MainScheduler.instance)
//            .map({ (r,g,b)->UIColor in
//            print("r,g,b is \(r) \(g) \(b)")
//            return UIColor.colorWith(r: r.doubleValue, g: g.doubleValue, b: b.doubleValue)
//            }).asDriver(onErrorJustReturn: .red)
        
        
        let zip = Observable.combineLatest(r_object.asObserver(),
                                          g_object.asObservable(),
                                          b_object.asObservable()).share(replay: 1)
        
        let tmprgb = zip.asObservable()
            .map { (r,g, b) -> UIColor in
                let rgbcolor = UIColor.colorWith(r: r.doubleValue, g: g.doubleValue, b: b.doubleValue)
            return rgbcolor
        }.asDriver(onErrorJustReturn: .red)
        
    
        let outrgbcolor = rgbBtn_object
            .withLatestFrom(tmprgb)//.share(replay: 1)
            .asDriver(onErrorJustReturn: .red)
        
        
        let r = r_object.asObserver().map({$0.count >= 1 && $0.count <= 3}).share(replay: 1)
        let g = g_object.asObserver().map({$0.count >= 1 && $0.count <= 3}).share(replay: 1)
        let b = b_object.asObserver().map({$0.count >= 1 && $0.count <= 3}).share(replay: 1)
        
        let outrgbbtn = Observable
            .combineLatest(r, g, b){$0 && $1 && $2}
            .startWith(false)
            .share(replay: 1)
        
        let outhexbtn = hex_object
            .asObserver()
            .map({$0.count == 6})
            .startWith(false)
            .share(replay: 1)
        
        
        let hex =  hexBtn_object
            .withLatestFrom(hex_object).map { (hex) -> UIColor in
            let hexcolor = UIColor.colorWithHexString(hex)
            return hexcolor
        }.asDriver(onErrorJustReturn: .red)
        
        
        output = Output(rgb: outrgbcolor,
                        rgbBtn: outrgbbtn,
                        hexColor:hex,
                        hexBtn: outhexbtn)
        
    }
}
