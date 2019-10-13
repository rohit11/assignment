//
//  HighSchoolsTableViewCell.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/9/19.
//  Copyright © 2019 Rohit Nisal. All rights reserved.
//

import UIKit

class HighSchoolsTableViewCell: UITableViewCell {
    @IBOutlet var highSchoolNameLabel: UILabel!
    @IBOutlet var highSchoolAddressLabel: UILabel!
    @IBOutlet var reputationContainerView: UIView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configure(with: .none, schoolAddress: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with schoolName: String?, schoolAddress : String?) {
        if let schoolName = schoolName {
            highSchoolNameLabel?.text = schoolName
        }
        if let schoolAddress = schoolAddress {
            highSchoolAddressLabel?.text = schoolAddress
        }
        
    }
}
