// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

struct FavoritePrimes: View {
    @ObservedObject
    var appState: AppState

    var body: some View {
        List {
            ForEach(appState.favoritePrimes, id: \.self) {
                Text("\($0)")
            }
            .onDelete { indexSet in
                indexSet.forEach {
                    appState.favoritePrimes.remove(at: $0)
                }
            }
        }
        .navigationTitle("Favorite Primes")
    }
}

