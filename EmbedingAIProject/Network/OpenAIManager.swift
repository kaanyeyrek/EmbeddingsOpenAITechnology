
import Foundation
// third party library openai
import OpenAISwift

final class APICaller {
// instance manager
    static let shared = APICaller()
    
    @frozen enum Constants {
// this is secretKey
        static let apiKey = "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"
    }
    private var client: OpenAISwift?
// setup token
    public func setup() {
        self.client = OpenAISwift(authToken: Constants.apiKey)
    }
// request client
    public func getResponse(input: String, completion: @escaping (Result<[String], Error>) -> Void) {
        client?.sendCompletion(with: input, completionHandler: { result in
            switch result {
            case .success(let results):
                if let embedResults = results.data?.compactMap({ $0.text }) {
                completion(.success(embedResults))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
