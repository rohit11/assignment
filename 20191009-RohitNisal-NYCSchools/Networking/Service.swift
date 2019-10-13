//
//  Service.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/10/19.
//  Copyright © 2019 Rohit Nisal. All rights reserved.
//

import Foundation

class Service {
    private lazy var baseURL: URL = {
        return URL(string: "https://data.cityofnewyork.us/")!
    }()
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchHighSchools(with request: HighSchoolsRequest, completion: @escaping (Result<HighSchoolList, DataResponseError>) -> Void) {
        // 1
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        // 2
        let parameters = request.parameters
        // 3
        let encodedURLRequest = urlRequest.encode(with: parameters)
        
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            // 4
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            
            // 5
            guard let decodedResponse = try? JSONDecoder().decode(HighSchoolList.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            // 6
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
    func fetchHighSchoolSATDetails(with request: HighSchoolSATRequest, completion: @escaping (Result<HighSchoolSATScores, DataResponseError>) -> Void) {
        // 1
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path))
        // 2
        let parameters = request.parameters
        // 3
        let encodedURLRequest = urlRequest.encode(with: parameters)
        
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            // 4
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            
            // 5
            guard let decodedResponse = try? JSONDecoder().decode(HighSchoolSATScores.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            // 6
            completion(Result.success(decodedResponse))
        }).resume()
    }
}

