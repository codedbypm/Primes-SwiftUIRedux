import Combine

public final class Store<State, Action>: ObservableObject {

    @Published
    public private(set) var state: State

    private let reducer: (inout State, Action) -> Void

    public init(state: State, reducer: @escaping (inout State, Action) -> Void) {
        self.state = state
        self.reducer = reducer
    }

    public func send(_ action: Action) {
        reducer(&state, action)
    }
}

public func pullback<LocalValue, GlobalValue, LocalAction, GlobalAction>(
    _ reducer: @escaping (inout LocalValue, LocalAction) -> Void,
    alongValue: WritableKeyPath<GlobalValue, LocalValue>,
    alongAction: WritableKeyPath<GlobalAction, LocalAction?>
) -> (inout GlobalValue, GlobalAction) -> Void {
    return { globalValue, globalAction in
        guard let localAction = globalAction[keyPath: alongAction] else { return }
        reducer(&globalValue[keyPath: alongValue], localAction)
    }
}

public func combine<State, Action>(
    _ reducers: (inout State, Action) -> Void...
) -> (inout State, Action) -> Void {

    return { value, action in
        for reducer in reducers {
            reducer(&value, action)
        }
    }
}
