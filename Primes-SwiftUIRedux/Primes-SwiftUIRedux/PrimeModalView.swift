// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Combine
import SwiftUI

struct PrimeModalView: View {
    @ObservedObject
    var appState: AppState

    var body: some View {
        VStack {
            if isPrime(appState.count) {
                Text("\(appState.count) is prime 🎉")
                if appState.favoritePrimes.contains(appState.count) {
                    Button(action: {
                        appState.favoritePrimes.removeAll(where: { $0 == appState.count })
                    }) {
                        Text("Remove from favorite primes")
                    }
                } else {
                    Button(action: {
                        appState.favoritePrimes.append(appState.count)
                    }) {
                        Text("Save to favorite primes")
                    }
                }
            } else {
                Text("\(appState.count) is not prime :(")
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

struct PrimeModalView_Previews: PreviewProvider {
    static var previews: some View {
        PrimeModalView(appState: .init())
    }
}
