//
//  ViewController.swift
//  AppStore
//
//  Created by Evandro Rodrigo Minamoto on 21/11/23.
//

import UIKit

class ViewController: UIViewController {

    let sections = [Section].parse(jsonFile: "sampleData")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

