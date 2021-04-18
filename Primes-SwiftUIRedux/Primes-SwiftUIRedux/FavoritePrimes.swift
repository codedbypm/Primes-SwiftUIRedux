// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

struct FavoritePrimesView: View {
    @ObservedObject
    var store: Store<AppState, AppAction>

    var body: some View {
        List {
            ForEach(store.state.favoritePrimes, id: \.self) {
                Text("\($0)")
            }
            .onDelete {
                store.send(.favoritePrimes(.deleteFavoritePrimes(at: $0)))
            }
        }
        .navigationTitle("Favorite Primes")
    }
}

