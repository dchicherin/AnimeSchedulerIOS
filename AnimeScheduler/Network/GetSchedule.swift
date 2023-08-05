//
//  GetSchedule.swift
//  OTUSAPI
//
//  Created by Dmitry Chicherin on 13/7/2566 BE.
//

import Foundation

class GetSchedule {
    private var networkClient: NetworkClient?
    
    init(networkClient: NetworkClient? = nil) {
        self.networkClient = networkClient
    }

    func getSchedule(completion: @escaping(ScheduleList)->Void) {
        self.networkClient?.outCompletionHandler = { result  in
            switch result {
            case .success(let data):
                //print(data)
                if let content = try?  JSONDecoder().decode(ScheduleList.self, from: data) {
                    completion(content)
                }
            default:
                print("ohoh")
                break
            }
            
        }
      
        networkClient?.request(path: Requests.schedule4.path) { (result: Result<ScheduleList,Error>) in
            switch result {
            case .success(let data) :
                var dataBuffer: ScheduleList
                //completion(data)
                dataBuffer = data
                let emptySL = ScheduleList(data: [SchedulePosition]())
                completion(emptySL)
                self.networkClient?.request(path: Requests.schedule5.path) { (result: Result<ScheduleList,Error>) in
                    switch result {
                    case .success(let data) :
                        var finalArray = data.data
                        finalArray.append(contentsOf: dataBuffer.data)
                        let finalSchedule = ScheduleList(data: finalArray)
                        completion(finalSchedule)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
