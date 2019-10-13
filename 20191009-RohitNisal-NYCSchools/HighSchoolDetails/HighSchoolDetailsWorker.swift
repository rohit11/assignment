//
//  HighSchoolDetailsWorker.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/10/19.
//  Copyright (c) 2019 Rohit Nisal. All rights reserved.
//


import UIKit

class HighSchoolDetailsWorker
{
    private var service: Service!
    
    func fetchHighSchoolSATScores(dbn : String, completionHandler: @escaping (HighSchoolSATScores?, DataResponseError?) -> Void)
    {
        // 1
        let request = HighSchoolSATRequest.from(dbn: dbn)
        service = Service()
        // 2
        service.fetchHighSchoolSATDetails(with: request) { result in
            switch result {
            // 3
            case .failure(let error):
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            // 4
            case .success(let response):
                DispatchQueue.main.async {
                    completionHandler(response, nil)
                }
            }
        }
        
    }
}
