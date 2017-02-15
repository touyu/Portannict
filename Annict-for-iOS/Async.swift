//
//  Async.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2017/02/15.
//  Copyright © 2017年 Yuto Akiba. All rights reserved.
//

import Foundation

struct Async {
    
    typealias Process = (_ workID: Int, @escaping (AnimeStatus?) -> ()) -> ()
    
    static func getStatus(workID: Int, completion: @escaping (_ status: AnimeStatus) -> Void) {
        Async.parallel(workID, [
            process0, process1, process2, process3, process4
            ], completion: { statuses in
                let status = statuses.flatMap { $0 }
                if status.isEmpty {
                    completion(.noSelect)
                } else {
                    completion(status.first!)
                }
        })
    }
    
    fileprivate static func parallel(_ workID: Int, _ processes: [Process], completion: @escaping ([AnimeStatus?]) -> ()) {
        var successObjects = [AnimeStatus?](repeating: nil, count: processes.count)
        
        let group = DispatchGroup()
        for (index, process) in processes.enumerated() {
            group.enter()
            process(workID) { result in
                successObjects[index] = result
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(successObjects)
        }
    }
    
    fileprivate static func checkWorks(id: Int, filterStatus: AnimeStatus, completion: @escaping ((_ status: AnimeStatus?) -> ())) {
        let request = AnnictAPI.GetMeWorks(id: id, filterStatus: filterStatus)
        AnnictAPIClient.send(request) { response in
            switch response {
            case .success(let value):
                if value.works.count != 0 {
                    completion(filterStatus)
                } else {
                    completion(nil)
                }
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    fileprivate static let process0: Async.Process = { workID, completion in
        Async.checkWorks(id: workID, filterStatus: .watching, completion: { status in
            completion(status)
        })
    }
    
    fileprivate static let process1: Async.Process = { workID, completion in
        Async.checkWorks(id: workID, filterStatus: .wannaWatch, completion: { status in
            completion(status)
        })
    }
    
    fileprivate static let process2: Async.Process = { workID, completion in
        Async.checkWorks(id: workID, filterStatus: .watched, completion: { status in
            completion(status)
        })
    }
    
    fileprivate static let process3: Async.Process = { workID, completion in
        Async.checkWorks(id: workID, filterStatus: .onHold, completion: { status in
            completion(status)
        })
    }
    
    fileprivate static let process4: Async.Process = { workID, completion in
        Async.checkWorks(id: workID, filterStatus: .stopWatching, completion: { status in
            completion(status)
        })
    }
    

    
    
//    let process0: AsyncKit<AnimeStatus?, Error>.Process = { workID, statuses, completion in
//        let request = AnnictAPI.GetMeWorks(id: workID, filterStatus: statuses[0])
//        AnnictAPIClient.send(request) { response in
//            switch response {
//            case .success(let value):
//                if value.works.count != 0 {
//                    completion(.success(statuses[0]))
//                } else {
//                    completion(.success(nil))
//                }
//            case .failure(let error):
//                completion(.success(nil))
//            }
//        }
//    }
}
