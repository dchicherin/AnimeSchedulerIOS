//
//  GetStatistics.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 16/7/2566 BE.
//

import Foundation

class GetStatistics {
    private var networkClient: NetworkClient?
    
    init(networkClient: NetworkClient? = nil) {
        self.networkClient = networkClient
    }

    func getStatistics(query: String, completion: @escaping(Statistics)->Void) {
        self.networkClient?.outCompletionHandler = { result  in
            switch result {
            case .success(let data):
                //print(data)
                if let content = try?  JSONDecoder().decode(Statistics.self, from: data) {
                    completion(content)
                    //print(content)
                }
            default:
                print("Network erroe")
                break
            }
            
        }
        networkClient?.request(path: Requests.statistics(query: query).path) { (result: Result<Statistics,Error>) in
            switch result {
            case .success(let data) :
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
