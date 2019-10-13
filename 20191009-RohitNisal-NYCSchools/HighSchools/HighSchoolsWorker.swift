//
//  HighSchoolsWorker.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/9/19.
//  Copyright (c) 2019 Rohit Nisal. All rights reserved.
//


import UIKit

class HighSchoolsWorker
{
    private var service: Service!
    private let limit = 22
    private var offset = 0

/**
     fetchHighSchoolList fetch School Detail information
     
     - HighSchoolList: Which hold HighSchool Data Model
     - DataResponseError: DataResponse error while either hold network or decode error
     - Returns: completionHandler highSchoolList which holds HighSchool or DataResponse error while either hold network or decode error
     // TODO : Continous infinte scroll can be implement with $limit and $offset query parameter
 */
  func fetchHighSchoolList(completionHandler: @escaping (HighSchoolList?, DataResponseError?) -> Void)
  {
    let request = HighSchoolsRequest.from(limit: "\(limit)", offset: "\(offset)")
    service = Service()
    service.fetchHighSchools(with: request) { [weak self] result in
        
        guard let self = self else { return }
        switch result {
        // 3
        case .failure(let error):
            DispatchQueue.main.async {
                completionHandler(nil, error)
            }
        // 4
        case .success(let response):
            DispatchQueue.main.async {
                self.offset = self.offset + self.limit
                completionHandler(response, nil)
            }
        }
    }

    }
}

