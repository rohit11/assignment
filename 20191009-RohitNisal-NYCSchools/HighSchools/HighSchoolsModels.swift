//
//  HighSchoolsModels.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/9/19.
//  Copyright (c) 2019 Rohit Nisal. All rights reserved.
//


import UIKit

enum HighSchools
{
  // MARK: Use cases
  
  enum FetchHighSchools
  {
    struct Request
    {
    }
    struct Response
    {
        var highSchools : [HighSchool]
    }
    struct ViewModel
    {
        var highSchoolList : [HighSchool]
    }
  }
    
    enum FetchHighSchoolsError
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
