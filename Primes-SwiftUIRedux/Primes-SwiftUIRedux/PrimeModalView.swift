// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Combine
import SwiftUI

struct PrimeModalView: View {
    @ObservedObject
    var store: Store<AppState>

    var body: some View {
        VStack {
            if isPrime(store.state.count) {
                Text("\(store.state.count) is prime 🎉")
                if store.state.favoritePrimes.contains(store.state.count) {
                    Button(action: {
                        store.state.favoritePrimes.removeAll(where: { $0 == store.state.count })
                        store.state.activity.append(.init(date: .init(), type: .remove))
                    }) {
                        Text("Remove from favorite primes")
                    }
                } else {
                    Button(action: {
                        store.state.favoritePrimes.append(store.state.count)
                        store.state.activity.append(.init(date: .init(), type: .add))
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
