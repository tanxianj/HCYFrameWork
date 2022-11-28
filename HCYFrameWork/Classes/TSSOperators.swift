//
//  Operators.swift
//
//
//  Created by Jupiter_TSS on 6/4/22.
//

import Foundation
import RxSwift
import RxCocoa
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
import MJRefresh
#endif

infix operator <=> : DefaultPrecedence
infix operator => : DefaultPrecedence
public func nonMarkedText(_ textInput: UITextInput) -> String? {
    let start = textInput.beginningOfDocument
    let end = textInput.endOfDocument

    guard let rangeAll = textInput.textRange(from: start, to: end),
        let text = textInput.text(in: rangeAll) else {
            return nil
    }

    guard let markedTextRange = textInput.markedTextRange else {
        return text
    }

    guard let startRange = textInput.textRange(from: start, to: markedTextRange.start),
          let endRange = textInput.textRange(from: markedTextRange.end, to: end) else {
        return text
    }

    return (textInput.text(in: startRange) ?? "") + (textInput.text(in: endRange) ?? "")
}
// <==> 双向绑定
@discardableResult
public func <=> <Base>(textInput: TextInput<Base>, relay: BehaviorRelay<String>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: textInput.text)

    let bindToRelay = textInput.text
        .subscribe(onNext: { [weak base = textInput.base] n in
            guard let base = base else {
                return
            }

            let nonMarkedTextValue = nonMarkedText(base)

            /**
             In some cases `textInput.textRangeFromPosition(start, toPosition: end)` will return nil even though the underlying
             value is not nil. This appears to be an Apple bug. If it's not, and we are doing something wrong, please let us know.
             The can be reproduced easily if replace bottom code with
             
             if nonMarkedTextValue != relay.value {
                relay.accept(nonMarkedTextValue ?? "")
             }
             and you hit "Done" button on keyboard.
             */
            if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != relay.value {
                relay.accept(nonMarkedTextValue)
            }
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}
@discardableResult
public func <=> <Base>(relay: BehaviorRelay<String>,textInput: TextInput<Base>) -> Disposable {
    let bindToUIDisposable = relay.bind(to: textInput.text)

    let bindToRelay = textInput.text
        .subscribe(onNext: { [weak base = textInput.base] n in
            guard let base = base else {
                return
            }

            let nonMarkedTextValue = nonMarkedText(base)

            /**
             In some cases `textInput.textRangeFromPosition(start, toPosition: end)` will return nil even though the underlying
             value is not nil. This appears to be an Apple bug. If it's not, and we are doing something wrong, please let us know.
             The can be reproduced easily if replace bottom code with
             
             if nonMarkedTextValue != relay.value {
                relay.accept(nonMarkedTextValue ?? "")
             }
             and you hit "Done" button on keyboard.
             */
            if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != relay.value {
                relay.accept(nonMarkedTextValue)
            }
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}
// <==> 双向绑定
@discardableResult
public func <=> <T>(property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
    if T.self == String.self {
#if DEBUG && !os(macOS)
        fatalError("It is ok to delete this message, but this is here to warn that you are maybe trying to bind to some `rx.text` property directly to relay.\n" +
            "That will usually work ok, but for some languages that use IME, that simplistic method could cause unexpected issues because it will return intermediate results while text is being inputed.\n" +
            "REMEDY: Just use `textField <-> relay` instead of `textField.rx.text <-> relay`.\n" +
            "Find out more here: https://github.com/ReactiveX/RxSwift/issues/649\n"
            )
#endif
    }

    let bindToUIDisposable = relay.bind(to: property)
    let bindToRelay = property
        .subscribe(onNext: { n in
            relay.accept(n)
        }, onCompleted:  {
            bindToUIDisposable.dispose()
        })

    return Disposables.create(bindToUIDisposable, bindToRelay)
}
// =>

@discardableResult
public func => <Base>(Input: PublishSubject<Base>, relay: PublishSubject<Base>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
@discardableResult
public func => <Base>(Input: Observable<Base>, relay: PublishSubject<Base>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(textInput: TextInput<Base>, relay: BehaviorRelay<String>) -> Disposable {
    let bindToUIDisposable = textInput.text.orEmpty.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(textInput: TextInput<Base>, relay: Binder<String?>) -> Disposable {
    let bindToUIDisposable = textInput.text.orEmpty.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(textInput: TextInput<Base>, relay: AnyObserver<String>) -> Disposable {
    let bindToUIDisposable = textInput.text.orEmpty.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(Input: ControlEvent<Base>, relay: AnyObserver<Base>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(Input: Observable<Base>, relay: AnyObserver<Base>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(Input: Driver<Base>, relay: Binder<Base>) -> Disposable {
    let bindToUIDisposable = Input.drive(relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(Input: Driver<Base>, relay: Binder<Base?>) -> Disposable {
    let bindToUIDisposable = Input.drive(relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(Input: ControlProperty<Base>, relay: Binder<Base?>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(Input: ControlProperty<Base>, relay: AnyObserver<Base>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(Input: Observable<Base>, relay: Binder<Base>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(Input: Observable<Base>, relay: Binder<Base?>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <T>(property: ControlProperty<T>, relay: BehaviorRelay<T>) -> Disposable {
    if T.self == String.self {
#if DEBUG && !os(macOS)
        fatalError("It is ok to delete this message, but this is here to warn that you are maybe trying to bind to some `rx.text` property directly to relay.\n" +
            "That will usually work ok, but for some languages that use IME, that simplistic method could cause unexpected issues because it will return intermediate results while text is being inputed.\n" +
            "REMEDY: Just use `textField <-> relay` instead of `textField.rx.text <-> relay`.\n" +
            "Find out more here: https://github.com/ReactiveX/RxSwift/issues/649\n"
            )
#endif
    }

    let bindToUIDisposable = relay.bind(to: property)

    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(Input: BehaviorRelay<Base>, relay: Binder<Base?>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
//=> 单向绑定
@discardableResult
public func => <Base>(Input: BehaviorRelay<Base>, relay: Binder<Base>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}

//=> 单向绑定
@discardableResult
public func => <Base>(Input: Observable<Base>, relay: BehaviorRelay<Base>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}

//=> 单向绑定
@discardableResult
public func => <Base>(Input: ControlEvent<Base>, relay: PublishSubject<Base>) -> Disposable {
    let bindToUIDisposable = Input.bind(to: relay)
    return Disposables.create([bindToUIDisposable])
}
