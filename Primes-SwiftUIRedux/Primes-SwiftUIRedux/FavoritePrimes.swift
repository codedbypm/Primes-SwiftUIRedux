// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

struct FavoritePrimes: View {
    @ObservedObject
    var store: Store<AppState, CounterAction>

    var body: some View {
        List {
            ForEach(store.state.favoritePrimes, id: \.self) {
                Text("\($0)")
            }
            .onDelete { indexSet in
                indexSet.forEach {
                    store.state.favoritePrimes.remove(at: $0)
                    store.state.activity.append(.init(date: .init(), type: .remove))
                }
            }
        }
        .navigationTitle("Favorite Primes")
    }
}

