// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import ComposableArchitecture
import Counter
import FavoritePrimes
import PrimeModal
import SwiftUI

@main
struct Primes: App {
    
    @ObservedObject
    var store: Store<AppState, AppAction>

    private var state = AppState()

    private let appReducer: (inout AppState, AppAction) -> Void = combine(
        pullback(counterReducer, alongValue: \.counterState, alongAction: \.counter),
        pullback(primeModalReducer, alongValue: \.primeModalState, alongAction: \.primeModal),
        pullback(favoritePrimesReducer, alongValue: \.favoritePrimesState, alongAction: \.favoritePrimes)
    )

    init() {
        self.store = Store(state: .init(), reducer: loggingReducer(activityFeedReducer(appReducer)))
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    NavigationLink(
                        destination: CounterView(
                            store: store.view(
                                toState: \.counterState,
                                fromAction: { counterAction -> AppAction in
                                    switch counterAction {
                                    case .counter(let action):
                                        return .counter(action)
                                    case .primeModal(let action):
                                        return .primeModal(action)
                                    }
                                }
                            )
                        )
                    ) {
                        Text("Counter Demo")
                    }
                    NavigationLink(
                        destination: FavoritePrimesView(
                            store: store.view(
                                toState: \.favoritePrimesState,
                                fromAction: { (favoritePrimeAction) -> AppAction in
                                    .favoritePrimes(favoritePrimeAction)
                                }
                            )
                        )
                    ) {
                        Text("Favorite Primes")
                    }
                }
                .navigationTitle("State management")
            }
            .environmentObject(PrimesAPI())
        }
    }
}
