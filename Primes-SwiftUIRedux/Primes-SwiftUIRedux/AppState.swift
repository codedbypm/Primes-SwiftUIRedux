// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

typealias Reducer<State, Action> = (State, Action) -> State

final class Store<State, Action>: ObservableObject {

    @Published
    var state: State

    let reducer: Reducer<State, Action>

    init(state: State, reducer: @escaping Reducer<State, Action>) {
        self.state = state
        self.reducer = reducer
    }

    func send(_ action: Action) {
        self.state = reducer(state, action)
    }
}

struct AppState {
    var count = 0
    var favoritePrimes: [Int] = []
    var activity: [Activity] = []
    var loggedInUser: User? = nil
}

struct Activity {
    let date: Date
    let type: FavoriteAction
}

enum FavoriteAction {
    case add
    case remove
}

struct User {
    let id: Int
    let name: String
    let bio: String
}
