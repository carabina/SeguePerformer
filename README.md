### Purpose

The `SeguePerformer` class initiates segues from a view controller using closures for view
controller preparation.

Unlike UIKit's  `UIViewController.performSegue(withIdentifier:sender:)`, which relies on
`UIViewController.prepare(for:sender:)` to configure the new view controller
before it is presented,
`SeguePerformer.peformSegue(withIdentifier:sender:preparationHandler:)` provides
this functionality via a trailing closure parameter.

The advantage of this approach is that the view controller preparation logic is
declared locally to the `performSegue` call, rather than independently in
`prepare(for:sender:)`, which can become awkward in the context of multiple
`performSegue` calls.

### Example

    class MyPresentingViewController: UIViewController {    
    
        lazy var seguePerformer = SeguePerformer(viewController: self)

        func performMySegue(with myPropertyValue: Int) {
            // Perform the segue, configuring the destination view controller
            // before it is presented.
            performSegue(withIdentifier: "mySegue", sender: self) { (myViewController: MyViewController) in
                myViewController.myProperty = myPropertyValue
            }
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // For SeguePerformer.performSegue's trailing closure to be called,
            // SeguePerformer must be notified about the prepare(for:sender:) call.
            seguePerformer.prepare(for: segue, sender: sender)
        }
        
    }

### Installation

To install SeguePerformer using CocoaPods, add the following to your Podfile:

    pod 'SeguePerformer'

