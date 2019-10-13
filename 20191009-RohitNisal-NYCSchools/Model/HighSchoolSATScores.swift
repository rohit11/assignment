//
//  HighSchoolSATScores.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/11/19.
//  Copyright © 2019 Rohit Nisal. All rights reserved.
//

import Foundation

// MARK: - HighSchoolSATScores
// MARK: - HighSchoolSATScore
struct HighSchoolSATScore: Codable {
    let dbn, schoolName, numOfSatTestTakers, satCriticalReadingAvgScore: String?
    let satMathAvgScore, satWritingAvgScore: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}

// MARK: HighSchoolSATScore convenience initializers and mutators

extension HighSchoolSATScore {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HighSchoolSATScore.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        dbn: String?? = nil,
        schoolName: String?? = nil,
        numOfSatTestTakers: String?? = nil,
        satCriticalReadingAvgScore: String?? = nil,
        satMathAvgScore: String?? = nil,
        satWritingAvgScore: String?? = nil
        ) -> HighSchoolSATScore {
        return HighSchoolSATScore(
            dbn: dbn ?? self.dbn,
            schoolName: schoolName ?? self.schoolName,
            numOfSatTestTakers: numOfSatTestTakers ?? self.numOfSatTestTakers,
            satCriticalReadingAvgScore: satCriticalReadingAvgScore ?? self.satCriticalReadingAvgScore,
            satMathAvgScore: satMathAvgScore ?? self.satMathAvgScore,
            satWritingAvgScore: satWritingAvgScore ?? self.satWritingAvgScore
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias HighSchoolSATScores = [HighSchoolSATScore]

extension Array where Element == HighSchoolSATScores.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HighSchoolSATScores.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

