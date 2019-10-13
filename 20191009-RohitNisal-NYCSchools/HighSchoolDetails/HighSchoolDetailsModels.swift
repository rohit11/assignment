//
//  HighSchoolDetailsModels.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/10/19.
//  Copyright (c) 2019 Rohit Nisal. All rights reserved.
//


import UIKit


let NotAvailable = "Not Found"
enum HighSchoolDetails
{
  // MARK: Use cases
  
  enum FetchSATScore
  {
    struct Request
    {
    }
    struct Response
    {
        var highSchoolSATScores : HighSchoolSATScores
        var highSchool : HighSchool?
    }
    struct ViewModel
    {
        var highSchoolSATScores : HighSchoolSATScores
        var highSchool : HighSchool?
    }
  }
    
    enum FetchSATScoreError
    {
        struct Request
        {
        }
        struct Response
        {
            var error : DataResponseError
        }
        struct ViewModel
        {
            var error : DataResponseError
        }
    }
}
