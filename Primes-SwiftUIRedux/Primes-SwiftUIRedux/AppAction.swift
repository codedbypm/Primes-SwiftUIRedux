// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Counter
import FavoritePrimes
import Foundation
import PrimeModal

enum AppAction {
    case counter(CounterViewAction)
    case favoritePrimes(FavoritePrimesAction)
}

extension AppAction {

    var counter: CounterViewAction? {
        get {
            guard case .counter(let action) = self else { return nil }
            return action
        }
        set {
            guard let newValue = newValue else { return }
            self = .counter(newValue)
        }
    }

    var favoritePrimes: FavoritePrimesAction? {
        get {
            guard case .favoritePrimes(let action) = self else { return nil }
            return action
        }
        set {
            guard let newValue = newValue else { return }
            self = .favoritePrimes(newValue)
        }
    }
}

func activityFeedReducer(
    _ reducer: @escaping (inout AppState, AppAction) -> Void
) -> (inout AppState, AppAction) -> Void {
    return { state, action in
        switch action {
        
        case .counter(.primeModal(.addFavorite)):
            state.activities.append(.init(date: .init(), type: .add(state.count)))

        case .counter(.primeModal(.removeFavorite)):
            state.activities.append(.init(date: .init(), type: .remove(state.count)))

        case let .favoritePrimes(.deleteFavoritePrimes(at: indexSet)):
            indexSet.forEach {
                let value = state.favoritePrimes[$0]
                state.activities.append(.init(date: .init(), type: .remove(value)))
            }

        case .counter:
            break
        }
        reducer(&state, action)
    }
}
