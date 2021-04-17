// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

class AppState: ObservableObject {

    @Published
    var count = 0

    var favoritePrimes: [Int] = []
}
