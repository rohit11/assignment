//
//  HighSchoolDetailsViewController.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/10/19.
//  Copyright (c) 2019 Rohit Nisal. All rights reserved.
//


import UIKit

protocol HighSchoolDetailsDisplayLogic: class
{
  func displaySATScore(viewModel: HighSchoolDetails.FetchSATScore.ViewModel)
  func displayError(viewModel: HighSchoolDetails.FetchSATScoreError.ViewModel)
}

class HighSchoolDetailsViewController: UIViewController, HighSchoolDetailsDisplayLogic
{
  var interactor: HighSchoolDetailsBusinessLogic?
  var router: (NSObjectProtocol & HighSchoolDetailsRoutingLogic & HighSchoolDetailsDataPassing)?

    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var mathScore: UILabel!
    @IBOutlet weak var readingScore: UILabel!
    @IBOutlet weak var writingScore: UILabel!
    @IBOutlet weak var overView: UITextView!
    // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = HighSchoolDetailsInteractor()
    let presenter = HighSchoolDetailsPresenter()
    let router = HighSchoolDetailsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    initView()
    requestSAPScore()
  }
  
  // MARK: Do something
  
    private func initView(_ initalValue : String = "") {
        self.schoolName.text = interactor?.getSchoolName()
        self.mathScore.text = initalValue
        self.readingScore.text = initalValue
        self.writingScore.text = initalValue
        self.overView.text = initalValue
    }
    
  func requestSAPScore()
  {
    self.displayActivityIndicator(shouldDisplay: true)
    let request = HighSchoolDetails.FetchSATScore.Request()
    interactor?.requestSAPScore(request: request)
  }
  
    
    func getDetail(viewModel: HighSchoolDetails.FetchSATScore.ViewModel) -> (schoolName : String, mathScore : String, readingScore : String, writingScore : String, overView : String) {
        
        var details : (schoolName : String, mathScore : String, readingScore : String, writingScore : String, overView : String)
        if let schoolName = viewModel.highSchoolSATScores.first?.schoolName {
            details.schoolName = schoolName
        } else  if let viewModelschoolName = viewModel.highSchool?.schoolName {
            details.schoolName = viewModelschoolName
        } else {
            details.schoolName = ""
        }
        
        if let mathScore = viewModel.highSchoolSATScores.first?.satMathAvgScore {
            details.mathScore = mathScore
        } else {
            details.mathScore = NotAvailable
        }
        
        if let readingScore = viewModel.highSchoolSATScores.first?.satCriticalReadingAvgScore {
            details.readingScore = readingScore
        } else {
            details.readingScore = NotAvailable
        }
        
        if let writingScore = viewModel.highSchoolSATScores.first?.satWritingAvgScore {
            details.writingScore = writingScore
        } else {
            details.writingScore = NotAvailable
        }
        
        if let overView = viewModel.highSchool?.overviewParagraph {
            details.overView = overView
        } else {
            details.overView = NotAvailable
        }
        
        return details
    }
    
  func displaySATScore(viewModel: HighSchoolDetails.FetchSATScore.ViewModel)
  {
    self.displayActivityIndicator(shouldDisplay: false)
    let details = getDetail(viewModel: viewModel)
    self.schoolName.text = details.schoolName
    self.mathScore.text = details.mathScore
    self.readingScore.text = details.readingScore
    self.writingScore.text = details.writingScore
    self.overView.text = details.overView
  }
    
    func displayError(viewModel: HighSchoolDetails.FetchSATScoreError.ViewModel) {
        self.displayActivityIndicator(shouldDisplay: false)
        initView(NotAvailable)
        //print(viewModel.error.reason)
        self.presentAlertWithTitleAndMessage(title: "Try Again", message: "Failed to load SAT Score", options: "OK") { (option) in
            
        }
    }
    
}
