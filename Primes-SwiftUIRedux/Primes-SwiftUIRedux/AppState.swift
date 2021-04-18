// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

struct AppState {
    var count = 0
    var favoritePrimes: [Int] = []
    var activities: [Activity] = []
    var loggedInUser: User? = nil
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
