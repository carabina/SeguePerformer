//
//  ClassicSegueViewController.swift
//  Example
//
//  Created by Drew Olbrich on 12/18/18.
//  Copyright © 2018 Drew Olbrich. All rights reserved.
//

import UIKit

class ClassicSegueViewController: UIViewController {

    @IBOutlet weak var firstProgrammaticSegueButton: UIButton!
    @IBOutlet weak var secondProgrammaticSegueButton: UIButton!

    @IBAction func performFirstSegue(_ sender: Any) {
        performSegue(withIdentifier: "programmaticSegue", sender: sender)
    }

    @IBAction func performSecondSegue(_ sender: Any) {
        performSegue(withIdentifier: "programmaticSegue", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let programmaticViewController = segue.destination as? ProgrammaticViewController {
            prepare(programmaticViewController: programmaticViewController, for: segue, sender: sender)
        }

        if let interactiveViewController = segue.destination as? InteractiveViewController {
            prepare(interactiveViewController: interactiveViewController, for: segue, sender: sender)
        }
    }

    func prepare(programmaticViewController: ProgrammaticViewController, for segue: UIStoryboardSegue, sender: Any?) {
        assert(segue.identifier == "programmaticSegue")

        guard let button = sender as? UIButton else {
            assertionFailure()
            return
        }

        switch button {
        case firstProgrammaticSegueButton:
            programmaticViewController.setSegueName("First")
        case secondProgrammaticSegueButton:
            programmaticViewController.setSegueName("Second")
        default:
            break
        }
    }

    func prepare(interactiveViewController: InteractiveViewController, for segue: UIStoryboardSegue, sender: Any?) {
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
