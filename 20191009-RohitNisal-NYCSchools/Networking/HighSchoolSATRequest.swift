//
//  HighSchoolSATRequest.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/11/19.
//  Copyright © 2019 Rohit Nisal. All rights reserved.
//

import Foundation

struct HighSchoolSATRequest {
    var path: String {
        return "resource/f9bf-2cp4.json"
    }
    
    let parameters: QueryParameters
    private init(parameters: QueryParameters) {
        self.parameters = parameters
    }
}

extension HighSchoolSATRequest {
    static func from(dbn: String) -> HighSchoolSATRequest {
        let parameters = ["dbn": "\(dbn)"]
        return HighSchoolSATRequest(parameters: parameters)
    }
}
