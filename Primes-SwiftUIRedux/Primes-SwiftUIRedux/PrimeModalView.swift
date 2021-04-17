// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Combine
import SwiftUI

struct PrimeModalView: View {
    @ObservedObject
    var store: Store<AppState, AppAction>

    var body: some View {
        VStack {
            if isPrime(store.state.count) {
                Text("\(store.state.count) is prime 🎉")
                if store.state.favoritePrimes.contains(store.state.count) {
                    Button(action: {
                        store.send(.favorite(.removeFavorite))
                    }) {
                        Text("Remove from favorite primes")
                    }
                } else {
                    Button(action: {
                        store.send(.favorite(.addFavorite))
                    }) {
                        Text("Save to favorite primes")
                    }
                }
            } else {
                Text("\(store.state.count) is not prime :(")
            }
        }
    }

    func isPrime(_ value: Int) -> Bool {
        if value <= 1 { return false }
        if value <= 3 { return true }
        for i in 2...Int(sqrtf(Float(value))) {
            if value % i == 0 { return false }
        }
        return true
    }
}
