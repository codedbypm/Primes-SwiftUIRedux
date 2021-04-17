// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Foundation

enum CounterAction {
    case plusTapped
    case minusTapped
}

func counterReducer(_ state: inout AppState, action: CounterAction) -> Void {
    switch action {
    case .minusTapped:
        state.count -= 1
    case .plusTapped:
        state.count += 1
    }
}
