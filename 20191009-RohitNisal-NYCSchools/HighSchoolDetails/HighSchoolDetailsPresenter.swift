//
//  HighSchoolDetailsPresenter.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/10/19.
//  Copyright (c) 2019 Rohit Nisal. All rights reserved.
//


import UIKit

protocol HighSchoolDetailsPresentationLogic
{
  func presentSATScore(response: HighSchoolDetails.FetchSATScore.Response)
  func presentError(response: HighSchoolDetails.FetchSATScoreError.Response)
}

class HighSchoolDetailsPresenter: HighSchoolDetailsPresentationLogic
{
  weak var viewController: HighSchoolDetailsDisplayLogic?
  
  /**
    It is pass high School information to viewController to display SAT Score
     - parameters :
            - HighSchoolDetails.FetchSATScore.Response which hold school information and SAT Score
  */
  func presentSATScore(response: HighSchoolDetails.FetchSATScore.Response)
  {
    let viewModel = HighSchoolDetails.FetchSATScore.ViewModel(highSchoolSATScores: response.highSchoolSATScores, highSchool: response.highSchool)
    viewController?.displaySATScore(viewModel: viewModel)
  }
    
    /**
     It is pass error to viewController to display error message
     - parameters :
     - HighSchoolDetails.FetchSATScoreError.Response which hold error
     */
    
    func presentError(response: HighSchoolDetails.FetchSATScoreError.Response) {
        let viewModel = HighSchoolDetails.FetchSATScoreError.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel)
    }
}
