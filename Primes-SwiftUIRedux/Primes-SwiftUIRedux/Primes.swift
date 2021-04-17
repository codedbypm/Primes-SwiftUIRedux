// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

@main
struct Primes: App {
    @ObservedObject
    var appState: AppState

    init() {
        self.appState = .init()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    NavigationLink(destination: CounterView(appState: appState)) {
                        Text("Counter Demo")
                    }
                    NavigationLink(destination: EmptyView()) {
                        Text("Favorite Primes")
                    }
                }
                .navigationTitle("State management")
            }
        }
    }
}
