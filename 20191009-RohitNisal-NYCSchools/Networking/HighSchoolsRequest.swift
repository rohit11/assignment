//
//  HighSchoolsRequest.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/10/19.
//  Copyright © 2019 Rohit Nisal. All rights reserved.
//

import Foundation

struct HighSchoolsRequest {
    var path: String {
        return "resource/s3k6-pzi2.json"
    }
    
    let parameters: QueryParameters
    private init(parameters: QueryParameters) {
        self.parameters = parameters
    }
}

extension HighSchoolsRequest {
    static func from(limit : String, offset : String) -> HighSchoolsRequest {
        let parameters = ["$limit": "\(limit)", "$offset": "\(offset)"]
        return HighSchoolsRequest(parameters: parameters)
    }
}



