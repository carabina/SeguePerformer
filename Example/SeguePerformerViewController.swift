//
//  SeguePerformerViewController.swift
//  SeguePerformer
//
//  Created by Drew Olbrich on 12/18/18.
//  Copyright © 2018 Drew Olbrich. All rights reserved.
//

import UIKit
import SeguePerformer

class SeguePerformerViewController: UIViewController {

    lazy var seguePerformer = SeguePerformer(viewController: self)

    @IBAction func performFirstSegue(_ sender: Any) {
        seguePerformer.performSegue(withIdentifier: "programmaticSegue", sender: sender) { (programmaticViewController: ProgrammaticViewController) in
            programmaticViewController.setSegueName("First")
        }
    }

    @IBAction func performSecondSegue(_ sender: Any) {
        seguePerformer.performSegue(withIdentifier: "programmaticSegue", sender: sender) { (programmaticViewController: ProgrammaticViewController) in
            programmaticViewController.setSegueName("Second")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // This is required for the `performSegue(withIdentifier:sender:preparationHandler:)`
        // calls, above, to work.
        if seguePerformer.prepare(for: segue, sender: sender) {
            return
        }

        if let interactiveViewController = segue.destination as? InteractiveViewController {
            // Prepare for the segue using the traditional mechanism.
            prepare(interactiveViewController: interactiveViewController, for: segue)
        }
    }

    func prepare(interactiveViewController: InteractiveViewController, for segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "thirdSegue":
            interactiveViewController.setSegueName("Third")
        case "fourthSegue":
            interactiveViewController.setSegueName("Fourth")
        default:
            assertionFailure()
        }
    }

}
