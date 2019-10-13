//
//  ScoreView.swift
//  20191009-RohitNisal-NYCSchools
//
//  Created by Rohit Nisal on 10/11/19.
//  Copyright © 2019 Rohit Nisal. All rights reserved.
//

import UIKit

class ScoreView: UIView {
    

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()

    }
    
    func configure() {
        self.layer.cornerRadius = 20
    }
}
