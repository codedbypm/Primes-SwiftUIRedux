import Foundation

public struct FavoritePrimesState {
    public var favoritePrimes: [Int]

    public init(favoritePrimes: [Int]) {
        self.favoritePrimes = favoritePrimes
    }
}

public enum FavoritePrimesAction {
    case deleteFavoritePrimes(at: IndexSet)
}

public func favoritePrimesReducer(_ state: inout FavoritePrimesState, action: FavoritePrimesAction) -> Void {
    switch action {
    case .deleteFavoritePrimes(at: let set):
        set.forEach {
            state.favoritePrimes.remove(at: $0)
        }
    }
}
