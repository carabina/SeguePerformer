# SeguePerformer

## Purpose

The SeguePerformer class provides an interface for initiating UIKit segues
programatically, using closures for view controller preparation.

In UIKit's existing programmatic segue presentation interface,
UIViewController's `performSegue(withIdentifier:sender:)` method relies on a
separate definition of `prepare(for:sender:)` to configure the new view
controller before it is presented.

The SeguePerformer class provides a
`peformSegue(withIdentifier:sender:preparationHandler:)` method which allows for
configuration of the new view controller via a trailing closure parameter.

The advantage of this approach is that the view controller preparation logic is
declared locally to the `performSegue` call, rather than independently in
`prepare(for:sender:)`, which can become particularly awkward in the context of 
multiple `performSegue` calls.

## Example

To use SeguePerformer, do the following:

1. Add a `seguePerformer` lazy property to your view controller.
2. Call `seguePerformer.peformSegue(withIdentifier:sender:preparationHandler:)` to initiate segues whose destination view controllers require configuration.
3. Override your view controller's `prepare(for:sender:)` method, passing its parameters along to `seguePerformer.prepare(for:sender:)`. Without this step, the `preparationHandler` closure will never be called.

For example:

    import UIKit
    import SeguePerformer

    class MyPresentingViewController: UIViewController {    
    
        lazy var seguePerformer = SeguePerformer(viewController: self)

        func performMySegue(with myPropertyValue: Int) {
            // Perform the segue, configuring the destination view controller
            // before it is presented.
            seguePerformer.performSegue(withIdentifier: "mySegue", sender: self) { 
                (myViewController: MyViewController) in
                myViewController.myProperty = myPropertyValue
            }
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // For SeguePerformer.performSegue's trailing closure to be called,
            // SeguePerformer must be notified about the prepare(for:sender:) call.
            if seguePerformer.prepare(for: segue, sender: sender) {
                return
            }

            // Prepare for interactive segues configured in Storyboard here.
        }
        
    }

Without SeguePerformer, the traditional way of writing this would be:

    import UIKit
    
    class MyPresentingViewController: UIViewController {    
    
        var myViewControllerPropertyValue: Int?
    
        func performMySegue(with myPropertyValue: Int) {
            myViewControllerPropertyValue = myPropertyValue
            performSegue(withIdentifier: "mySegue", sender: self)
            // Continues in prepare(for:sender:)...
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let myViewController = segue.destinationViewController as? MyViewController, 
                let myViewControllerPropertyValue = myViewControllerPropertyValue {
                // ...continued from performMySegue(with:)
                myViewController.myPropertyValue = myViewControllerPropertyValue
                self.myViewControllerPropertyValue = nil
            }
        }
        
    }

## Installation

To install SeguePerformer using CocoaPods, add the following to your Podfile:

    pod 'SeguePerformer'

Optionally, you may instead drag `SeguePerformer.swift` into your project.
