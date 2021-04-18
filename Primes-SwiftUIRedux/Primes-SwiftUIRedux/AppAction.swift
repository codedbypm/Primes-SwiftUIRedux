// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Counter
import FavoritePrimes
import Foundation
import PrimeModal

enum AppAction {
    case counter(CounterAction)
    case primeModal(PrimeModalAction)
    case favoritePrimes(FavoritePrimesAction)
}

extension AppAction {

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
        case .counter:
            break

        case .primeModal(.addFavorite):
            state.activities.append(.init(date: .init(), type: .add(state.count)))

        case .primeModal(.removeFavorite):
            state.activities.append(.init(date: .init(), type: .remove(state.count)))

        case let .favoritePrimes(.deleteFavoritePrimes(at: indexSet)):
            indexSet.forEach {
                let value = state.favoritePrimes[$0]
                state.activities.append(.init(date: .init(), type: .remove(value)))
            }
        }
        reducer(&state, action)
    }
}
