//
//  ToDoWorker.swift
//  customNetworking
//
//  Created by Михаил Прозорский on 01.12.2023.
//

import Foundation

enum ToDoEndpoint: Endpoint {
    case toDo(Int)

    var compositePath: String {
        switch self {
            
        case .toDo(let number):
            "/toDos/\(number)"
        }
    }
    
    var headers: HeaderModel { [:] }
}

struct ToDo: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

final class ToDoWorker {
    private let networking: Networking = Networking(
        baseUrl: "https://jsonplaceholder.typicode.com"
    )
    
    typealias ToDoResult = (Result<ToDo, Error>) -> Void
    
    func fetchToDos(completion: @escaping ToDoResult) {
        let endpoint = ToDoEndpoint.toDo(1)
        let request = Request(endpoint: endpoint, method: .get)
        networking.executeRequest(with: request) { result in
            switch result {
                
            case .success(let model):
                if let data = model.data {
                    print(String(data: data, encoding: .utf8))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
