//
//  HighSchoolsPresenter.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/9/19.
//  Copyright (c) 2019 Rohit Nisal. All rights reserved.
//


import UIKit

protocol HighSchoolsPresentationLogic
{
  func presentHighSchools(response: HighSchools.FetchHighSchools.Response)
  func presentError(response: HighSchools.FetchHighSchoolsError.Response)
}

class HighSchoolsPresenter: HighSchoolsPresentationLogic
{
  weak var viewController: HighSchoolsDisplayLogic?
  
  // MARK: Do something
  
  func presentHighSchools(response: HighSchools.FetchHighSchools.Response)
  {
    let viewModel = HighSchools.FetchHighSchools.ViewModel(highSchoolList: response.highSchools)
    viewController?.displayHighSchools(viewModel: viewModel)
  }
    
    func presentError(response: HighSchools.FetchHighSchoolsError.Response) {
        let viewModel = HighSchools.FetchHighSchoolsError.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel)
    }
}
