// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Foundation
import PrimeModal

public struct CounterViewState {
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

public func counterReducer(_ state: inout CounterViewState, action: CounterAction) -> Void {
    switch action {
    case .minusTapped:
        state.count -= 1

    case .plusTapped:
        state.count += 1
    }
}
