//
//  GetNews.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 16/7/2566 BE.
//

import Foundation


class GetNews {
    private var networkClient: NetworkClient?
    
    init(networkClient: NetworkClient? = nil) {
        self.networkClient = networkClient
    }

    func getNews(query: String, completion: @escaping(NewsList)->Void) {
        self.networkClient?.outCompletionHandler = { result  in
            switch result {
            case .success(let data):
                //print(data)
                if let content = try?  JSONDecoder().decode(NewsList.self, from: data) {
                    completion(content)
                    //print(content)
                }
            default:
                print("Network erroe")
                break
            }
            
        }
        networkClient?.request(path: Requests.newsList(query: query).path) { (result: Result<NewsList,Error>) in
            switch result {
            case .success(let data) :
                completion(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
