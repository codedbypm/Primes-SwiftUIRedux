// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct FavoritePrimesView: View {
    @ObservedObject
    var store: Store<FavoritePrimesState, FavoritePrimesAction>

    public init(store: Store<FavoritePrimesState, FavoritePrimesAction>) {
        self.store = store
    }

    public var body: some View {
        List {
            ForEach(store.state.favoritePrimes, id: \.self) {
                Text("\($0)")
            }
            .onDelete {
                store.send(.deleteFavoritePrimes(at: $0))
            }
        }
        .navigationTitle("Favorite Primes")
    }
}

