// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Foundation

enum CounterAction {
    case plusTapped
    case minusTapped
}

func counterReducer(state: AppState, action: CounterAction) -> AppState {
    switch action {
    case .minusTapped:
        return AppState(
            count: state.count - 1,
            favoritePrimes: state.favoritePrimes,
            activity: state.activity,
            loggedInUser: state.loggedInUser
        )
    case .plusTapped:
        return AppState(
            count: state.count + 1,
            favoritePrimes: state.favoritePrimes,
            activity: state.activity,
            loggedInUser: state.loggedInUser
        )
    }
}
