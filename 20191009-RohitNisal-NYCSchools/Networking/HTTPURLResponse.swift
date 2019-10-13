//
//  HTTPURLResponse.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/10/19.
//  Copyright © 2019 Rohit Nisal. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
