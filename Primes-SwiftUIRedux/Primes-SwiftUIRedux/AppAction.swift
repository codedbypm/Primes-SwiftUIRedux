// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Foundation

enum AppAction {
    enum CounterAction {
        case plusTapped
        case minusTapped
    }

    enum FavoriteAction {
        case addFavorite
        case removeFavorite
        case deleteFavoritePrimes(at: IndexSet)
    }

    case counter(CounterAction)
    case favorite(FavoriteAction)
}


func appReducer(_ state: inout AppState, action: AppAction) -> Void {
    switch action {
    case .counter(.minusTapped):
        state.count -= 1
    case .counter(.plusTapped):
        state.count += 1
    case .favorite(.addFavorite):
        state.favoritePrimes.append(state.count)
        state.activity.append(.init(date: .init(), type: .add(state.count)))
    case .favorite(.removeFavorite):
        state.favoritePrimes.removeAll(where: { $0 == state.count })
        state.activity.append(.init(date: .init(), type: .remove(state.count)))
    case .favorite(.deleteFavoritePrimes(at: let set)):
        set.forEach {
            let value = state.favoritePrimes[$0]
            state.favoritePrimes.remove(at: $0)
            state.activity.append(.init(date: .init(), type: .remove(value)))
        }
    }
}
