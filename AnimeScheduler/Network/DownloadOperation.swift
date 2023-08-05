//
//  DownloadOperation.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 16/7/2566 BE.
//

import Foundation

class DownloadOperation : AsyncOperation {
    private var urlPath: String? = nil
    var outputImage: Data? = nil
    
    
    private var urlConfiguration = URLSessionConfiguration.default
    
    private lazy var urlSession: URLSession = {
       return URLSession(configuration: urlConfiguration)
    }()
    
    private var urlDataTask: URLSessionDataTask? = nil
    
    convenience init(url: String) {
        self.init()
        self.urlPath = url
    }
    
    override func start() {
      super.start()
        guard let path = urlPath, let url = URL(string: path) else {
            return
        }
        let urlRequest = URLRequest(url: url)
    
        self.urlDataTask = urlSession.dataTask(with: urlRequest, completionHandler: {[weak self]
            data, response, error in
            guard let self = self else {return}
            self.outputImage = data
            self.state = .finished
            
        })
        self.urlDataTask?.resume()
    }
}
