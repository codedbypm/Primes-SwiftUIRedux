// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Foundation

enum CounterAction {
    case plusTapped
    case minusTapped
}

enum PrimeModal {
    case addFavorite
    case removeFavorite
}

enum FavoritePrimes {
    case deleteFavoritePrimes(at: IndexSet)
}

enum AppAction {

    case counter(CounterAction)
    case primeModal(PrimeModal)
    case favoritePrimes(FavoritePrimes)
}

func pullback<LocalValue, GlobalValue, Action>(
    _ reducer: @escaping (inout LocalValue, Action) -> Void,
    keyPath: WritableKeyPath<GlobalValue, LocalValue>
) -> (inout GlobalValue, Action) -> Void {
    return { globalValue, action in
        reducer(&globalValue[keyPath: keyPath], action)
    }
}

func counterReducer(_ state: inout Int, action: CounterAction) -> Void {
    switch action {
    case .minusTapped:
        state -= 1

    case .plusTapped:
        state += 1
    }
}

func primeModalReducer(_ state: inout AppState, action: AppAction) -> Void {
    switch action {
    case .primeModal(.addFavorite):
        state.favoritePrimes.append(state.count)
        state.activity.append(.init(date: .init(), type: .add(state.count)))

    case .primeModal(.removeFavorite):
        state.favoritePrimes.removeAll(where: { $0 == state.count })
        state.activity.append(.init(date: .init(), type: .remove(state.count)))

    default:
        break
    }
}

func favoritePrimesReducer(_ state: inout FavoritePrimeState, action: AppAction) -> Void {
    switch action {
    case .favoritePrimes(.deleteFavoritePrimes(at: let set)):
        set.forEach {
            let value = state.favoritePrimes[$0]
            state.favoritePrimes.remove(at: $0)
            state.activity.append(.init(date: .init(), type: .remove(value)))
        }

    default:
        break
    }
}

func combine<State, Action>(
    _ reducers: (inout State, Action) -> Void...
) -> (inout State, Action) -> Void {

    return { value, action in
        for reducer in reducers {
            reducer(&value, action)
        }
    }
}
