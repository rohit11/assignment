//
//  HighSchoolsInteractor.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/9/19.
//  Copyright (c) 2019 Rohit Nisal. All rights reserved.
//


import UIKit

protocol HighSchoolsBusinessLogic
{
  func fetchHighSchools(request: HighSchools.FetchHighSchools.Request)
}

protocol HighSchoolsDataStore
{
  // hold all high school list
  var highSchoolList: [HighSchool] { get set }
}

class HighSchoolsInteractor: HighSchoolsBusinessLogic, HighSchoolsDataStore
{
  var presenter: HighSchoolsPresentationLogic?
  var worker: HighSchoolsWorker = HighSchoolsWorker()
  var highSchoolList: [HighSchool] = [HighSchool]()
  
  // fetchHighSchools fetch all school list using worker
  
  func fetchHighSchools(request: HighSchools.FetchHighSchools.Request)
  {
    
    // Request to fetch High List information and return pass information to presenter
    worker.fetchHighSchoolList { [weak self] (list, error) -> Void in
        
        if let list = list{
            self?.highSchoolList.append(contentsOf: list)
            let response = HighSchools.FetchHighSchools.Response(highSchools: list)
            self?.presenter?.presentHighSchools(response: response)
        } else if let error = error {
                let response = HighSchools.FetchHighSchoolsError.Response(error: error)
                self?.presenter?.presentError(response: response)
            } else {
                let response = HighSchools.FetchHighSchoolsError.Response(error: DataResponseError.network)
                self?.presenter?.presentError(response: response)
            }
        
    }
    
  }
}
