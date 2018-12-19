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
`prepare(for:sender:)`, which can become especially  awkward in the context of 
multiple `performSegue` calls.

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

Without `SeguePerformer`, the traditional way of writing this would be:

    class MyPresentingViewController: UIViewController {    
    
        var myPropertyValue: Int?
    
        func performMySegue(with myPropertyValue: Int) {
            self.myPropertyValue = myPropertyValue
            performSegue(withIdentifier: "mySegue", sender: self)
            // Continues in prepare(for:sender:)...
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Handle the case where the segue's destination view controller was
            // presented by performMySegue(with:) and is of type MyViewController.
            if let myViewController = segue.destinationViewController as? MyViewController, 
                let myPropertyValue = myPropertyValue {
                myViewController.myPropertyValue = myPropertyValue
                self.myPropertyValue = nil
            }
        }
        
    }


### Installation

To install SeguePerformer using CocoaPods, add the following to your Podfile:

    pod 'SeguePerformer'

Optionally, you may instead copy `SeguePerformer.swift` into your project.

### License

SeguePerformer is released under the MIT license. See [LICENSE.md](https://github.com/SeguePerformer//LICENSE.md) for details.
