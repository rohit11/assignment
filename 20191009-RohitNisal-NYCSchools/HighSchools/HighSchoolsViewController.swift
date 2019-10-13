//
//  HighSchoolsViewController.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/9/19.
//  Copyright (c) 2019 Rohit Nisal. All rights reserved.
//


import UIKit

protocol HighSchoolsDisplayLogic: class
{
    func displayHighSchools(viewModel: HighSchools.FetchHighSchools.ViewModel)
    func displayError(viewModel: HighSchools.FetchHighSchoolsError.ViewModel)
}

class HighSchoolsViewController: UIViewController, HighSchoolsDisplayLogic
{
    
    private enum CellIdentifiers {
        static let list = "SchoolList"
    }
    var interactor: HighSchoolsBusinessLogic?
    var router: (NSObjectProtocol & HighSchoolsRoutingLogic & HighSchoolsDataPassing)?
    var viewModel  = HighSchools.FetchHighSchools.ViewModel(highSchoolList: [])
    private var shouldShowLoadingCell = false
    
    @IBOutlet weak var schoolTableView: UITableView!
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
        let interactor = HighSchoolsInteractor()
        let presenter = HighSchoolsPresenter()
        let router = HighSchoolsRouter()
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
        schoolTableView.rowHeight = UITableView.automaticDimension
        schoolTableView.estimatedRowHeight = 300
        fetchHighSchoolList()
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func fetchHighSchoolList()
    {
        //self.displayActivityIndicator(shouldDisplay: true)
        let request = HighSchools.FetchHighSchools.Request()
        interactor?.fetchHighSchools(request: request)
    }
    
    func displayHighSchools(viewModel: HighSchools.FetchHighSchools.ViewModel)
    {
        //self.displayActivityIndicator(shouldDisplay: false)
        self.shouldShowLoadingCell =  viewModel.highSchoolList.count == 0 ? false : true
        self.viewModel.highSchoolList.append(contentsOf: viewModel.highSchoolList)
        print(self.viewModel.highSchoolList.count)
        schoolTableView.reloadData()
    }
    
    func displayError(viewModel: HighSchools.FetchHighSchoolsError.ViewModel) {
        //self.displayActivityIndicator(shouldDisplay: false)
        self.presentAlertWithTitleAndMessage(title: "Try Again", message: viewModel.error.reason, options: "OK") { (option) in
        }
    }
}


// Table view display high School information
// TODO : Continous infinte scroll can be implement with $limit and $offset query parametef
extension HighSchoolsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        let count = viewModel.highSchoolList.count
        return shouldShowLoadingCell ? count + 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoadingIndexPath(indexPath) {
            return LoadingTableViewCell(style: .default, reuseIdentifier: "loading")
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! HighSchoolsTableViewCell
            cell.accessoryType = .disclosureIndicator
            // 2
            let highSchool = viewModel.highSchoolList[indexPath.row]
            cell.configure(with: highSchool.schoolName, schoolAddress: highSchool.finalAddress() ?? "")
            
            return cell
        }
    }
    
    
}

extension HighSchoolsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else { return }
        fetchHighSchoolList()
    }
    
    private func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == viewModel.highSchoolList.count
    }
    
}
