//
//  TSSGCDTools.swift
//  TSSFrameWork
//
//  Created by Jupiter_TSS on 14/7/22.
//
public typealias Task = (_ cancel: Bool) -> Void
public class TSSGCDTools{
    @discardableResult
    
    /// delay perform
    /// - Parameters:
    ///   - time: delay time seconds
    ///   - task: task
    /// - Returns: -
    public class func delay(_ time: TimeInterval, task: @escaping () -> ()) -> Task? {
        
        func dispatch_later(block: @escaping () -> ()) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        
        var closure: (() -> Void)? = task
        var result: Task?
        
        let delayedClosure: Task = { cancel in
            
            if let internalClosure = closure {
                if !cancel {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        
        result = delayedClosure
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        
        return result
    }
    
    /// GCD定时器倒计时
    /// - Parameters:
    ///   - timeInterval:间隔时间
    ///   - count: 重复次数
    ///   - handler: 事件
    public class func repeatAction(_ timeInterval: Double, _ count: Int, handler: @escaping () -> Void){
        let vc = UIViewController.getCurrentVC()
        if count <= 0 {
            return
        }
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        var count = count
        timer.schedule(deadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            guard  vc == UIViewController.getCurrentVC() else {
                timer.cancel()
                return
            }
            count -= 1
            
            DispatchQueue.main.async {
                handler()
            }
            
            if count == 0 {
                timer.cancel()
            }
        }
        timer.resume()
        
    }
    
    /// GCD定时器倒计时
    ///
    /// - Parameters:
    ///   - timeInterval: 间隔时间
    ///   - repeatCount: 重复次数
    ///   - handler: 循环事件,闭包参数: 1.timer 2.剩余执行次数
    public class func repeatAction(_ timeInterval: Double, _ count: Int, handler: @escaping (DispatchSourceTimer?, Int) -> Void){
        let vc = UIViewController.getCurrentVC()
        if count <= 0 {
            return
        }
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        var count = count
        timer.schedule(deadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            guard  vc == UIViewController.getCurrentVC() else {
                timer.cancel()
                return
            }
            count -= 1
            
            DispatchQueue.main.async {
                handler(timer, count)
            }
           
            if count == 0 {
                timer.cancel()
            }
        }
        timer.resume()
        
    }
    
    /// GCD 重复事件
    /// - Parameters:
    ///   - timeInterval: 间隔时间
    ///   - handler: 重复事件
    ///   - needRepeat: 是否需要一直重复
    public class func repeatAction(_ timeInterval: Double, handler: @escaping () -> Void, needRepeat: Bool){
        let vc = UIViewController.getCurrentVC()
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.schedule(deadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            DispatchQueue.main.async {
                if needRepeat {
                    guard  vc == UIViewController.getCurrentVC() else {
                        timer.cancel()
                        return
                    }
                    handler()
                } else {
                    timer.cancel()
                    handler()
                }
            }
        }
        timer.resume()
        
        
    }
    
    public class func cancel(_ task: Task?) {
        task?(true)
    }
    
}
