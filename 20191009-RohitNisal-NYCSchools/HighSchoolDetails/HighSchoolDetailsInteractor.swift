//
//  HighSchoolDetailsInteractor.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/10/19.
//  Copyright (c) 2019 Rohit Nisal. All rights reserved.
//


import UIKit

protocol HighSchoolDetailsBusinessLogic
{
  func requestSAPScore(request: HighSchoolDetails.FetchSATScore.Request)
  func getSchoolName() -> String?
}

protocol HighSchoolDetailsDataStore
{
  var dbn: String { get set }
  var highSchoolSATScores: HighSchoolSATScores? { get set }
  var highSchool : HighSchool? { get set }
}

class HighSchoolDetailsInteractor: HighSchoolDetailsBusinessLogic, HighSchoolDetailsDataStore
{
  var presenter: HighSchoolDetailsPresentationLogic?
  var worker: HighSchoolDetailsWorker = HighSchoolDetailsWorker()
  var dbn: String = ""
  var highSchoolSATScores: HighSchoolSATScores?
  var highSchool : HighSchool?
  // MARK: Do something
  
  func requestSAPScore(request: HighSchoolDetails.FetchSATScore.Request)
  {
    worker.fetchHighSchoolSATScores(dbn: self.dbn) { [weak self] (highSchoolScores, error) -> Void in
        if let highSchoolScores = highSchoolScores{
            self?.highSchoolSATScores = highSchoolScores
            let response = HighSchoolDetails.FetchSATScore.Response(highSchoolSATScores: highSchoolScores, highSchool: self?.highSchool)
            self?.presenter?.presentSATScore(response: response)
        } else if let error = error {
            let response = HighSchoolDetails.FetchSATScoreError.Response(error: error)
            self?.presenter?.presentError(response: response)
        } else {
            let response = HighSchoolDetails.FetchSATScoreError.Response(error: DataResponseError.network)
            self?.presenter?.presentError(response: response)
        }
    }
  }
    func getSchoolName() -> String? {
        
        if let highSchool = self.highSchool {
            return highSchool.schoolName
        }
        return nil
    }
}
