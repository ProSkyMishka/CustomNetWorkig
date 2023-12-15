//
//  Networking.swift
//  customNetworking
//
//  Created by Aleksa Khruleva on 01.12.2023.
//

import Foundation

protocol NetworkingProtocol {
    typealias NetworkingResult = (
        (_ result: Result<NetworkingCommandModels.NetworkingResult, Error>) -> Void
    )
    
    func executeRequest(with request: Request, completion: @escaping NetworkingResult)
}

final class Networking: NetworkingProtocol {
    var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func executeRequest(with request: Request, completion: @escaping NetworkingResult) {
        guard let urlRequest = convert(request) else {
            NSLog("wrong url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            completion(.success(NetworkingCommandModels.NetworkingResult(data: data, response: response)))
        }
        
        task.resume()
    }
    
    private func convert(_ request: Request) -> URLRequest? {
        guard let url = generateDestinationURL(for: request) else { return nil }
        var urlRequest = URLRequest(url: url)
        
        return urlRequest
    }
    
    private func generateDestinationURL(for request: Request) -> URL? {
        return URL(string: baseUrl + request.endpoint.compositePath)
    }
}
