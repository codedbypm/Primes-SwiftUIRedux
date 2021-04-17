// 
// Project: Primes-SwiftUIRedux 
// Copyright © 2021 codedby.pm. All rights reserved.
//

import Combine
import Foundation

struct WolframAlphaResult: Decodable {
    let queryresult: QueryResult

    struct QueryResult: Decodable {
        let pods: [Pod]

        struct Pod: Decodable {
            let scanner: String
            let primary: Bool?
            let subpods: [SubPod]

            struct SubPod: Decodable {
                let plaintext: String
            }
        }
    }
}

class PrimesAPI: ObservableObject {

    func nthPrime(_ n: Int) -> AnyPublisher<Int, Error> {
        return wolframAlpha(query: "prime \(n)")
            .compactMap { $0.queryresult.pods.first { $0.scanner == "Identity" && $0.primary == .some(true) } }
            .compactMap { $0.subpods.first }
            .compactMap { Int($0.plaintext) }
            .eraseToAnyPublisher()
    }

    private func wolframAlpha(query: String) -> AnyPublisher<WolframAlphaResult, Error> {
        var components = URLComponents(string: "https://api.wolframalpha.com/v2/query")!
        components.queryItems = [
            URLQueryItem(name: "input", value: query),
            URLQueryItem(name: "format", value: "plaintext"),
            URLQueryItem(name: "output", value: "JSON"),
            URLQueryItem(name: "appid", value: "6H69Q3-828TKQJ4EP"),
        ]

        return URLSession.shared
            .dataTaskPublisher(for: components.url(relativeTo: nil)!)
            .tryCompactMap {
                try JSONDecoder().decode(WolframAlphaResult.self, from: $0.data)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
