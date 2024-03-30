//
//  ServiceRepository.swift
//  Services
//
//  Created by Alexandr Onischenko on 30.03.2024.
//

import Foundation

class ServiceRepository {
    static var shared = ServiceRepository()

    private var path = "https://publicstorage.hb.bizmrg.com/sirius/result.json"

    private init() {}

    enum ErrorResponse: Error {
        case failedToGetData
        case failedToDecode
    }

    func getServices(completion: @escaping ((Result<[Service], Error>) -> ())) {
        guard let url = URL(string: path) else {
            completion(.failure(ErrorResponse.failedToGetData))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(ErrorResponse.failedToGetData))
                return
            }
            let decoder = JSONDecoder()
            guard let message = try? decoder.decode(ServiceMessage.self, from: data) else {
                completion(.failure(ErrorResponse.failedToDecode))
                return
            }
            completion(.success(message.body.services))
        }.resume()
    }
}
