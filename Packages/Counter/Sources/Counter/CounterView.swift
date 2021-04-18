import Combine
import ComposableArchitecture
import PrimeModal
import SwiftUI

public struct CounterView: View {

    @EnvironmentObject
    var primesAPI: PrimesAPI

    @ObservedObject
    var store: Store<CounterViewState, CounterViewAction>

    @State
    private var isPrimeModalShown = false

    @State
    private var didReceiveNthPrime: Bool = false

    @State
    private var requestNthPrime = false

    @State
    private var nthPrime = Int.min

    @State
    private var nthPrimeButtonDisabled = false

    @State
    private var nthPrimeCancellable: AnyCancellable?

    public init(store: Store<CounterViewState, CounterViewAction>) {
        self.store = store
    }

    public var body: some View {
        VStack(spacing: 20.0) {
            HStack(spacing: 20.0) {
                Button(
                    action: { store.send(.counter(.minusTapped)) },
                    label: { Text("-") }
                )
                Text("\(store.state.count)")
                Button(
                    action: { store.send(.counter(.plusTapped)) },
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
            .disabled(nthPrimeButtonDisabled)
        }
        .font(.title)
        .navigationTitle("Counter Demo")
        .sheet(isPresented: $isPrimeModalShown) {
            PrimeModalView(
                store: store.view(
                    toState: { PrimeModalState(count: $0.count, favoritePrimes: $0.favoritePrimes) },
                    fromAction: { primeModalAction in
                        .primeModal(primeModalAction)
                    }
                )
            )
        }
        .alert(isPresented: $didReceiveNthPrime) {
            Alert(
                title: Text("What is the \(formatCount()) prime?"),
                message: Text("It is \(nthPrime)"),
                dismissButton: nil
            )
        }
        .onChange(of: requestNthPrime) { _ in
            nthPrimeButtonDisabled = true
            nthPrimeCancellable?.cancel()
            nthPrimeCancellable = nthPrime(store.state.count)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: {
                        nthPrime = $0
                        didReceiveNthPrime = true
                        nthPrimeButtonDisabled = false
                    }
                )
        }
    }

    private let formatter = NumberFormatter()

    func formatCount() -> String {
        formatter.numberStyle = .ordinal
        return formatter.string(for: store.state.count) ?? ""
    }

    func nthPrime(_ value: Int) -> AnyPublisher<Int, Error> {
        return primesAPI
            .nthPrime(value)
            .eraseToAnyPublisher()
    }
}
