// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

@main
struct Primes: App {
    
    @ObservedObject
    var store: Store<AppState>

    init() {
        self.store = .init(state: .init())
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    NavigationLink(destination: CounterView(store: store)) {
                        Text("Counter Demo")
                    }
                    NavigationLink(destination: FavoritePrimes(store: store)) {
                        Text("Favorite Primes")
                    }
                }
                .navigationTitle("State management")
            }
            .environmentObject(PrimesAPI())
        }
    }
}
