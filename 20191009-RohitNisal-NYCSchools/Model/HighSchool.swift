//
//  HighSchool.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/10/19.
//  Copyright © 2019 Rohit Nisal. All rights reserved.
//

import Foundation

// MARK: - HighSchool
struct HighSchool: Codable {
    let dbn, schoolName, boro, overviewParagraph: String?
    let school10ThSeats, academicopportunities1, academicopportunities2, academicopportunities3: String?
    let ellPrograms, languageClasses, neighborhood, buildingCode: String?
    let location, phoneNumber, faxNumber, schoolEmail: String?
    let website, subway, bus, totalStudents: String?
    let extracurricularActivities, schoolSports, attendanceRate, interest1: String?
    let method1, seats101, eligibility1, primaryAddressLine1: String?
    let city, zip, stateCode, latitude: String?
    let longitude, communityBoard, councilDistrict, censusTract: String?
    let bin, bbl, nta, borough: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case boro
        case overviewParagraph = "overview_paragraph"
        case school10ThSeats = "school_10th_seats"
        case academicopportunities1, academicopportunities2, academicopportunities3
        case ellPrograms = "ell_programs"
        case languageClasses = "language_classes"
        case neighborhood
        case buildingCode = "building_code"
        case location
        case phoneNumber = "phone_number"
        case faxNumber = "fax_number"
        case schoolEmail = "school_email"
        case website, subway, bus
        case totalStudents = "total_students"
        case extracurricularActivities = "extracurricular_activities"
        case schoolSports = "school_sports"
        case attendanceRate = "attendance_rate"
        case interest1, method1, seats101, eligibility1
        case primaryAddressLine1 = "primary_address_line_1"
        case city, zip
        case stateCode = "state_code"
        case latitude, longitude
        case communityBoard = "community_board"
        case councilDistrict = "council_district"
        case censusTract = "census_tract"
        case bin, bbl, nta, borough
    }
}

// MARK: HighSchool convenience initializers and mutators

extension HighSchool {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HighSchool.self, from: data)
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
        boro: String?? = nil,
        overviewParagraph: String?? = nil,
        school10ThSeats: String?? = nil,
        academicopportunities1: String?? = nil,
        academicopportunities2: String?? = nil,
        academicopportunities3: String?? = nil,
        ellPrograms: String?? = nil,
        languageClasses: String?? = nil,
        neighborhood: String?? = nil,
        buildingCode: String?? = nil,
        location: String?? = nil,
        phoneNumber: String?? = nil,
        faxNumber: String?? = nil,
        schoolEmail: String?? = nil,
        website: String?? = nil,
        subway: String?? = nil,
        bus: String?? = nil,
        totalStudents: String?? = nil,
        extracurricularActivities: String?? = nil,
        schoolSports: String?? = nil,
        attendanceRate: String?? = nil,
        interest1: String?? = nil,
        method1: String?? = nil,
        seats101: String?? = nil,
        eligibility1: String?? = nil,
        primaryAddressLine1: String?? = nil,
        city: String?? = nil,
        zip: String?? = nil,
        stateCode: String?? = nil,
        latitude: String?? = nil,
        longitude: String?? = nil,
        communityBoard: String?? = nil,
        councilDistrict: String?? = nil,
        censusTract: String?? = nil,
        bin: String?? = nil,
        bbl: String?? = nil,
        nta: String?? = nil,
        borough: String?? = nil
        ) -> HighSchool {
        return HighSchool(
            dbn: dbn ?? self.dbn,
            schoolName: schoolName ?? self.schoolName,
            boro: boro ?? self.boro,
            overviewParagraph: overviewParagraph ?? self.overviewParagraph,
            school10ThSeats: school10ThSeats ?? self.school10ThSeats,
            academicopportunities1: academicopportunities1 ?? self.academicopportunities1,
            academicopportunities2: academicopportunities2 ?? self.academicopportunities2,
            academicopportunities3: academicopportunities3 ?? self.academicopportunities3,
            ellPrograms: ellPrograms ?? self.ellPrograms,
            languageClasses: languageClasses ?? self.languageClasses,
            neighborhood: neighborhood ?? self.neighborhood,
            buildingCode: buildingCode ?? self.buildingCode,
            location: location ?? self.location,
            phoneNumber: phoneNumber ?? self.phoneNumber,
            faxNumber: faxNumber ?? self.faxNumber,
            schoolEmail: schoolEmail ?? self.schoolEmail,
            website: website ?? self.website,
            subway: subway ?? self.subway,
            bus: bus ?? self.bus,
            totalStudents: totalStudents ?? self.totalStudents,
            extracurricularActivities: extracurricularActivities ?? self.extracurricularActivities,
            schoolSports: schoolSports ?? self.schoolSports,
            attendanceRate: attendanceRate ?? self.attendanceRate,
            interest1: interest1 ?? self.interest1,
            method1: method1 ?? self.method1,
            seats101: seats101 ?? self.seats101,
            eligibility1: eligibility1 ?? self.eligibility1,
            primaryAddressLine1: primaryAddressLine1 ?? self.primaryAddressLine1,
            city: city ?? self.city,
            zip: zip ?? self.zip,
            stateCode: stateCode ?? self.stateCode,
            latitude: latitude ?? self.latitude,
            longitude: longitude ?? self.longitude,
            communityBoard: communityBoard ?? self.communityBoard,
            councilDistrict: councilDistrict ?? self.councilDistrict,
            censusTract: censusTract ?? self.censusTract,
            bin: bin ?? self.bin,
            bbl: bbl ?? self.bbl,
            nta: nta ?? self.nta,
            borough: borough ?? self.borough
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    
    func finalAddress() -> String? {
        
        var finalAddress : String?
        if var address = self.primaryAddressLine1 {
            
            if let city = self.city {
                address = address + ", " + city
            }
            
            if let zip = self.zip {
                address = address + ", " + zip
            }
            
            finalAddress = address
        }
        
        return finalAddress
    }
}


typealias HighSchoolList = [HighSchool]

extension Array where Element == HighSchoolList.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(HighSchoolList.self, from: data)
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

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

