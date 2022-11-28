//
//  TSSValidateViewModel.swift
//  HCYFrameWork_Example
//
//  Created by Jupiter_TSS on 3/8/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import HCYFrameWork
import RxSwift
import RxCocoa
class TSSValidateViewModel:TSSBaseViewModelType{
    let disposeBag = DisposeBag()
    var input: Input
    var output: Output
    struct Input{
        let textfiled:AnyObserver<String>
        let type:AnyObserver<TSSValidateTest>
    }
    struct Output{
        let result:Driver<String>
        let statusColor:Driver<UIColor>
    }
    private let textObject = ReplaySubject<String>.create(bufferSize: 1)
    private let typeObject = ReplaySubject<TSSValidateTest>.create(bufferSize: 1)
    init(){
        input = Input(textfiled: textObject.asObserver(), type: typeObject.asObserver())

        
        let status = textObject.withLatestFrom(typeObject){ (text,type)->Bool in
            switch type{
            case .email:
                return TSSValidate.email(text).isRight
            case .phoneNumber:
                return TSSValidate.phoneNumber(text).isRight
            case .userName:
                return TSSValidate.userName(text).isRight
            case .password:
                return TSSValidate.password(text).isRight
            case .nickName:
                return TSSValidate.nickName(text).isRight
            case .postalCode:
                return TSSValidate.postalCode(text).isRight
            case .URL:
                return TSSValidate.URL(text).isRight
            case .IP:
                return TSSValidate.IP(text).isRight
            case .money:
                return TSSValidate.money(text).isRight
            case .onlyNumber:
                return TSSValidate.onlyNumber(text, 5).isRight
            case .numberSpace:
                return TSSValidate.numberSpace(text, 10).isRight
            }
        }
        .startWith(false)
        .asDriver(onErrorJustReturn: false)
        
        let result =  status.map { status -> String in
             return status ? "验证通过" : "验证未通过"
        }.asDriver(onErrorJustReturn: "")
        
        let statusColor = status.map { status -> UIColor in
            return status ? .green :.red
        }
    
        
        output = Output(result: result, statusColor: statusColor)
        
    }
    
}
