// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Foundation

public enum CounterAction {
    case plusTapped
    case minusTapped
}

public func counterReducer(_ state: inout Int, action: CounterAction) -> Void {
    switch action {
    case .minusTapped:
        state -= 1

    case .plusTapped:
        state += 1
    }
}
