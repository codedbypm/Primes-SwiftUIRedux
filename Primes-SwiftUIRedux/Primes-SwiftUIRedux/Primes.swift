// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

@main
struct Primes: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {
                    NavigationLink(destination: EmptyView()) {
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
