// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

class Store: ObservableObject {

    @Published
    var state: AppState

    init() {
        self.state = .init()
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
