//
//  UIDeviceModel.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 2/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import HCYFrameWork
import RxSwift
import RxCocoa
class UIDeviceModel:TSSBaseViewModelType{
    let disposeBag = DisposeBag()
    var input: Input
    var output: Output
    struct Input{
        let inputmm:AnyObserver<String>
    }
    struct Output{
        let deviceName:Driver<String>
        let actualWidth:Driver<CGFloat>

    }
    private let inputcmObject = PublishSubject<String>()
    init(){

        let dic = "{\"a\":\"a\",\"b\":\"b\",\"c\":\"c\"}"
        print("dic is \(dic)")
        print("dic to Dictionary \(dic.toDictionary())")


        input = Input(inputmm: inputcmObject.asObserver())
        let deviceName:Observable<String> = Observable.create { ob in
            ob.onNext(UIDevice.modelName())
            return Disposables.create()
        }

        let actualWidth = inputcmObject.asObserver().map({ (input) ->CGFloat in
            guard input.count <= 2 else{return UIDevice.current.mmToPixels(mm: 10)}
            return UIDevice.current.mmToPixels(mm: input.doubleValue)
        }).asDriver(onErrorJustReturn:0.0)

        output = Output(deviceName: deviceName.asDriver(onErrorJustReturn: ""),
                        actualWidth: actualWidth)
    }
}
