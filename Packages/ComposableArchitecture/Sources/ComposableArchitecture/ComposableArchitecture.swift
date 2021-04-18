import Combine

public final class Store<State, Action>: ObservableObject {

    @Published
    public private(set) var state: State

    private let reducer: (inout State, Action) -> Void
    private var cancellables: [AnyCancellable] = []

    public init(state: State, reducer: @escaping (inout State, Action) -> Void) {
        self.state = state
        self.reducer = reducer
    }

    public func send(_ action: Action) {
        reducer(&state, action)
    }

    public func view<LocalValue>(
        on valueKeypath: WritableKeyPath<State, LocalValue>
    ) -> Store<LocalValue, Action> {
        let localStore = Store<LocalValue, Action>(
            state: state[keyPath: valueKeypath],
            reducer: { localState, action in
                self.send(action)
                localState = self.state[keyPath: valueKeypath]
            }
        )
        let cancellable = $state.sink { [weak localStore] globalState in
            localStore?.state = globalState[keyPath: valueKeypath]
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

public func combine<State, Action>(
    _ reducers: (inout State, Action) -> Void...
) -> (inout State, Action) -> Void {

    return { value, action in
        for reducer in reducers {
            reducer(&value, action)
        }
    }
}

public func loggingReducer<State, Action>(
    _ reducer: @escaping (inout State, Action) -> Void
) -> (inout State, Action) -> Void {
    return { state, action in
        reducer(&state, action)
        print("Action: \(action)")
        print("Value:")
        dump(state)
        print("------")
    }
}
