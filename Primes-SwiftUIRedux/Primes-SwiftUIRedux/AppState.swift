// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Counter
import FavoritePrimes
import PrimeModal
import SwiftUI

struct AppState {
    var count = 0
    var favoritePrimes: [Int] = []
    var activities: [Activity] = []
    var loggedInUser: User? = nil
}

extension AppState {

    var counterState: CounterViewState {
        get { .init(count: count, favoritePrimes: favoritePrimes) }
        set {
            count = newValue.count
            favoritePrimes = newValue.favoritePrimes
        }
    }
    
    var favoritePrimesState: FavoritePrimesState {
        get { .init(favoritePrimes: favoritePrimes) }
        set { favoritePrimes = newValue.favoritePrimes }
    }

    var primeModalState: PrimeModalState {
        get { .init(count: count, favoritePrimes: favoritePrimes) }
        set {
            count = newValue.count
            favoritePrimes = newValue.favoritePrimes
        }
    }
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
