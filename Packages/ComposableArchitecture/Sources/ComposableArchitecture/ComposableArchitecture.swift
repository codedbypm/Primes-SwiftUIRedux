import Combine

public final class Store<Value, Action>: ObservableObject {

    @Published
    public private(set) var state: Value

    private let reducer: (inout Value, Action) -> Void
    private var cancellables: [AnyCancellable] = []

    public init(state: Value, reducer: @escaping (inout Value, Action) -> Void) {
        self.state = state
        self.reducer = reducer
    }

    public func send(_ action: Action) {
        reducer(&state, action)
    }

    public func view<LocalValue, LocalAction>(
        toState stateTransform: @escaping (Value) -> LocalValue,
        fromAction actionTransform: @escaping (LocalAction) -> Action
    ) -> Store<LocalValue, LocalAction> {
        let localStore = Store<LocalValue, LocalAction>(
            state: stateTransform(state),
            reducer: { localState, localAction in
                self.send(actionTransform(localAction))
                localState = stateTransform(self.state)
            }
        )
        let cancellable = $state.sink { [weak localStore] globalState in
            localStore?.state = stateTransform(globalState)
        }
        localStore.cancellables.append(cancellable)
        return localStore
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

public func combine<Value, Action>(
    _ reducers: (inout Value, Action) -> Void...
) -> (inout Value, Action) -> Void {

    return { value, action in
        for reducer in reducers {
            reducer(&value, action)
        }
    }
}

public func loggingReducer<Value, Action>(
    _ reducer: @escaping (inout Value, Action) -> Void
) -> (inout Value, Action) -> Void {
    return { state, action in
        reducer(&state, action)
        print("Action: \(action)")
        print("Value:")
        dump(state)
        print("------")
    }
}
