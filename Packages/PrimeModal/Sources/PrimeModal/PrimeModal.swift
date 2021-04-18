import Foundation

public enum PrimeModalAction {
    case addFavorite
    case removeFavorite
}

public struct PrimeModalState {
    public var count: Int
    public var favoritePrimes: [Int] = []

    public init(count: Int, favoritePrimes: [Int]) {
        self.count = count
        self.favoritePrimes = favoritePrimes
    }
}

public func primeModalReducer(_ state: inout PrimeModalState, action: PrimeModalAction) -> Void {
    switch action {
    case .addFavorite:
        state.favoritePrimes.append(state.count)

    case .removeFavorite:
        state.favoritePrimes.removeAll(where: { $0 == state.count })
    }
}
