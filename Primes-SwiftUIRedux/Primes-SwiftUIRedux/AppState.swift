// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

final class Store<State, Action>: ObservableObject {

    @Published
    var state: State

    let reducer: (inout State, Action) -> Void

    init(state: State, reducer: @escaping (inout State, Action) -> Void) {
        self.state = state
        self.reducer = reducer
    }

    func send(_ action: Action) {
        reducer(&state, action)
    }
}

struct AppState {
    var count = 0
    var favoritePrimes: [Int] = []
    var activities: [Activity] = []
    var loggedInUser: User? = nil
}

extension AppState {
    var favoritePrimesState: FavoritePrimeState {
        get {
            .init(favoritePrimes: favoritePrimes, activities: activities)
        }
        set {
            favoritePrimes = newValue.favoritePrimes
            activities = newValue.activities
        }
    }
}

struct FavoritePrimeState {
    var favoritePrimes: [Int] = []
    var activities: [Activity] = []
}

struct Activity {
    let date: Date
    let type: FavoriteAction
}

enum FavoriteAction {
    case add(Int)
    case remove(Int)
}

struct User {
    let id: Int
    let name: String
    let bio: String
}
