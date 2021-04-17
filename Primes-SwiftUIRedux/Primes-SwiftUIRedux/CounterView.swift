//
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Combine
import SwiftUI

struct CounterView: View {

    @EnvironmentObject
    var primesAPI: PrimesAPI

    @ObservedObject
    var appState: AppState

    @State
    private var isPrimeModalShown = false

    @State
    private var didReceiveNthPrime: Bool = false

    @State
    private var requestNthPrime = false

    @State
    private var nthPrime = Int.min

    @State
    private var nthPrimeCancellable: AnyCancellable?

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
            Button(
                action: { isPrimeModalShown.toggle() },
                label: { Text("Is this prime?") }
            )
            Button(
                action: { requestNthPrime.toggle() },
                label: { Text("What is the \(formatCount()) prime?") }
            )
        }
        .font(.title)
        .navigationTitle("Counter Demo")
        .sheet(isPresented: $isPrimeModalShown) {
            PrimeModalView(appState: appState)
        }
        .alert(isPresented: $didReceiveNthPrime) {
            Alert(
                title: Text("What is the \(formatCount()) prime?"),
                message: Text("It is \(nthPrime)"),
                dismissButton: nil
            )
        }
        .onChange(of: requestNthPrime) { _ in
            nthPrimeCancellable?.cancel()
            nthPrimeCancellable = nthPrime(appState.count)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: {
                        nthPrime = $0
                        didReceiveNthPrime = true
                    }
                )
        }
    }

    private let formatter = NumberFormatter()

    func formatCount() -> String {
        formatter.numberStyle = .ordinal
        return formatter.string(for: appState.count) ?? ""
    }

    func nthPrime(_ value: Int) -> AnyPublisher<Int, Error> {
        return primesAPI
            .nthPrime(value)
            .eraseToAnyPublisher()
    }
}
