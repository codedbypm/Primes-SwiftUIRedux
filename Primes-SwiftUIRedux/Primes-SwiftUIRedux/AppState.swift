// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

class AppState: ObservableObject {

    @Published
    var count = 0

    @Published
    var favoritePrimes: [Int] = []

    var activity: [Activity] = []
}

struct Activity {
    let date: Date
    let type: FavoriteAction
}

enum FavoriteAction {
    case add
    case remove
}
