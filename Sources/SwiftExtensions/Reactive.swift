import Foundation
import ReactiveSwift
import Result

public extension Signal {
    func mapToVoid() -> Signal<Void, Error> {
        return self.map { _ -> Void in
            return ()
        }
    }
    
    func ignoreErrors() -> Signal<Value, NoError> {
        return flatMapError { _ in .empty }
    }
}

public extension SignalProducer {
    
    func mapToVoid() -> SignalProducer<Void, Error> {
        return self.map { _ -> Void in
            return ()
        }
    }
    
    func ignoreErrors() -> SignalProducer<Value, NoError> {
        return flatMapError { _ in .empty }
    }
    
    static func error(_ value: Error) -> SignalProducer<Value, Error> {
        return SignalProducer(error: value)
    }
    
    static func just(_ value: Value) -> SignalProducer<Value, Error> {
        return SignalProducer(value: value)
    }
}

public extension Action {
    
    static var empty: Action<Input, Output, Error> {
        return Action { _ in
            return SignalProducer.empty
        }
    }
}

public extension Property {
    
    func mapToVoid() -> Property<Void> {
        return map { _ in }
    }
}

public extension CompositeDisposable {
    
    static func scoped() -> ScopedDisposable<CompositeDisposable> {
        return ScopedDisposable(CompositeDisposable())
    }
}
