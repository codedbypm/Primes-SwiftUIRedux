// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import SwiftUI

struct CounterView: View {

    @ObservedObject
    var appState: AppState

    var body: some View {
        VStack(spacing: 20.0) {
            HStack(spacing: 20.0) {
                Button(
                    action: { appState.count -= 1 },
                    label: { Text("-") }
                )
                Text("\(appState.count)")
                Button(
                    action: { appState.count += 1 },
                    label: { Text("+") }
                )
            }
            Button(action: {}, label: {
                Text("Is this prime?")
            })
            Button(action: {}, label: {
                Text("What is the \(formatCount()) prime?")
            })
        }
        .font(.title)
        .navigationTitle("Counter Demo")
    }

    private let formatter = NumberFormatter()

    func formatCount() -> String {
        formatter.numberStyle = .ordinal
        return formatter.string(for: appState.count) ?? ""
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(appState: .init())
    }
}
