//
//  InteractiveViewController.swift
//  Example
//
//  Created by Drew Olbrich on 12/18/18.
//  Copyright © 2018 Drew Olbrich. All rights reserved.
//

import UIKit

class InteractiveViewController: UIViewController {

    @IBOutlet weak var segueNameLabel: UILabel!

    func setSegueName(_ text: String?) {
        loadViewIfNeeded()
        segueNameLabel.text = text
    }

}
