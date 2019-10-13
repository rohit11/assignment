//
//  HighSchoolsRouter.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/9/19.
//  Copyright (c) 2019 Rohit Nisal. All rights reserved.
//


import UIKit

@objc protocol HighSchoolsRoutingLogic
{
  func routeToShowHighSchoolDetails(segue: UIStoryboardSegue?)
}

protocol HighSchoolsDataPassing
{
  var dataStore: HighSchoolsDataStore? { get }
}

class HighSchoolsRouter: NSObject, HighSchoolsRoutingLogic, HighSchoolsDataPassing
{
    weak var viewController: HighSchoolsViewController?
    var dataStore: HighSchoolsDataStore?
    
    // MARK: Routing
    
    func routeToShowHighSchoolDetails(segue: UIStoryboardSegue?)
    {
        if let segue = segue {
            let destinationVC = segue.destination as! HighSchoolDetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "HighSchoolDetailsViewController") as! HighSchoolDetailsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
            navigateToSomewhere(source: viewController!, destination: destinationVC)
        }
    }
    
    //MARK: Navigation
    
    func navigateToSomewhere(source: HighSchoolsViewController, destination: HighSchoolDetailsViewController)
    {
        source.show(destination, sender: nil)
    }
    
    //MARK: Passing data
    
    func passDataToSomewhere(source: HighSchoolsDataStore, destination: inout HighSchoolDetailsDataStore)
    {
        if let selectedRow = viewController?.schoolTableView.indexPathForSelectedRow?.row {
            if  let dbn = source.highSchoolList[selectedRow].dbn {
                destination.dbn = dbn
                destination.highSchool = source.highSchoolList[selectedRow]
            }
        }
    }
}
