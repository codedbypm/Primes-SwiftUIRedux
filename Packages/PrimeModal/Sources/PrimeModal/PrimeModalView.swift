// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Combine
import ComposableArchitecture
import SwiftUI

public struct PrimeModalView: View {
    @ObservedObject
    var store: Store<PrimeModalState, PrimeModalAction>

    public var body: some View {
        VStack(spacing: 20.0) {
            if isPrime(store.state.count) {
                Text("\(store.state.count) is prime 🎉")
                if store.state.favoritePrimes.contains(store.state.count) {
                    Button(action: {
                        store.send(.removeFavorite)
                    }) {
                        Text("Remove from favorite primes")
                    }
                } else {
                    Button(action: {
                        store.send(.addFavorite)
                    }) {
                        Text("Save to favorite primes")
                    }
                }
            } else {
                Text("\(store.state.count) is not prime :(")
            }
        }
    }

    public init(store: Store<PrimeModalState, PrimeModalAction>) {
        self.store = store
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
