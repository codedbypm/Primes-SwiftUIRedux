// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Foundation

enum CounterAction {
    case plusTapped
    case minusTapped
}

enum PrimeModalAction {
    case addFavorite
    case removeFavorite
}

enum FavoritePrimesAction {
    case deleteFavoritePrimes(at: IndexSet)
}

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

func pullback<LocalValue, GlobalValue, LocalAction, GlobalAction>(
    _ reducer: @escaping (inout LocalValue, LocalAction) -> Void,
    alongValue: WritableKeyPath<GlobalValue, LocalValue>,
    alongAction: WritableKeyPath<GlobalAction, LocalAction?>
) -> (inout GlobalValue, GlobalAction) -> Void {
    return { globalValue, globalAction in
        guard let localAction = globalAction[keyPath: alongAction] else { return }
        reducer(&globalValue[keyPath: alongValue], localAction)
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

func primeModalReducer(_ state: inout AppState, action: PrimeModalAction) -> Void {
    switch action {
    case .addFavorite:
        state.favoritePrimes.append(state.count)
        state.activity.append(.init(date: .init(), type: .add(state.count)))

    case .removeFavorite:
        state.favoritePrimes.removeAll(where: { $0 == state.count })
        state.activity.append(.init(date: .init(), type: .remove(state.count)))

    default:
        break
    }
}

func favoritePrimesReducer(_ state: inout FavoritePrimeState, action: FavoritePrimesAction) -> Void {
    switch action {
    case .deleteFavoritePrimes(at: let set):
        set.forEach {
            let value = state.favoritePrimes[$0]
            state.favoritePrimes.remove(at: $0)
            state.activity.append(.init(date: .init(), type: .remove(value)))
        }
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
