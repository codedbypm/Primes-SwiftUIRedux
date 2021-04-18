// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import ComposableArchitecture
import Foundation
import PrimeModal

public struct CounterState {
    public var count: Int
    public var favoritePrimes: [Int]

    public init(count: Int, favoritePrimes: [Int]) {
        self.count = count
        self.favoritePrimes = favoritePrimes
    }
}

public enum CounterViewAction {
    case counter(CounterAction)
    case primeModal(PrimeModalAction)
}

public enum CounterAction {
    case plusTapped
    case minusTapped
}

public func counterReducer(_ state: inout CounterState, action: CounterAction) -> Void {
    switch action {
    case .minusTapped:
        state.count -= 1

    case .plusTapped:
        state.count += 1
    }
}

public func counterViewReducer(_ state: inout CounterState, action: CounterViewAction) -> Void {
    combine(
        pullback(counterReducer, alongValue: \.self, alongAction: \.counter),
        pullback(primeModalReducer, alongValue: \.primeModalState, alongAction: \.primeModal)
    )(&state, action)
}

extension CounterViewAction {

    var counter: CounterAction? {
        get {
            guard case .counter(let action) = self else { return nil }
            return action
        }
        set {
            guard let newValue = newValue else { return }
            self = .counter(newValue)
        }
    }

    var primeModal: PrimeModalAction? {
        get {
            guard case .primeModal(let action) = self else { return nil }
            return action
        }
        set {
            guard let newValue = newValue else { return }
            self = .primeModal(newValue)
        }
    }
}

extension CounterState {

    var counterState: CounterState {
        get { .init(count: count, favoritePrimes: favoritePrimes) }
        set {
            count = newValue.count
            favoritePrimes = newValue.favoritePrimes
        }
    }

    var primeModalState: PrimeModalState {
        get { .init(count: count, favoritePrimes: favoritePrimes) }
        set {
            count = newValue.count
            favoritePrimes = newValue.favoritePrimes
        }
    }
}
