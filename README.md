# SeguePerformer

[![Travis](https://img.shields.io/travis/milpitas/SeguePerformer.svg)](https://travis-ci.org/milpitas/SeguePerformer)
[![Platforms](https://img.shields.io/badge/platforms-iOS-lightgray.svg)](http://developer.apple.com/ios)
[![Swift 4.2](https://img.shields.io/badge/swift-4.2-red.svg?style=flat)](https://developer.apple.com/swift)
[![License](https://img.shields.io/github/license/milpitas/SeguePerformer.svg)](https://tldrlegal.com/license/mit-license)
[![Twitter](https://img.shields.io/badge/twitter-@drewolbrich-blue.svg)](http://twitter.com/drewolbrich)

## Purpose

The SeguePerformer class provides an interface for initiating UIKit segues
programatically, using closures for view controller preparation.

In UIKit's existing programmatic segue presentation interface,
UIViewController's `performSegue(withIdentifier:sender:)` method relies on a
non-local definition of `prepare(for:sender:)` to configure the new view
controller before it is presented. This can become unweildy in the context
of multiple `performSegue` calls.

SeguePerformer improves upon this by providing a
`performSegue(withIdentifier:sender:preparationHandler:)` method which allows for
configuration of the new view controller via a trailing closure parameter.

## Installation

To install SeguePerformer using CocoaPods, add the following to your Podfile:

```
pod 'SeguePerformer'
```

Or, if you prefer, drag `SeguePerformer.swift` into your project.

## Usage

1. Add a lazy `seguePerformer` property to your view controller.
2. Call `seguePerformer.performSegue(withIdentifier:sender:preparationHandler:)` to initiate segues whose destination view controllers require configuration.
3. Override your view controller's `prepare(for:sender:)` method, passing its parameters along to `seguePerformer.prepare(for:sender:)`. Without this step, the `preparationHandler` closure will never be called.

## Example

```swift
import SeguePerformer

class MyPresentingViewController: UIViewController {

    lazy var seguePerformer = SeguePerformer(viewController: self)

    func performMySegue(with myPropertyValue: Int) {
        // Perform the segue, configuring the destination view controller
        // before it is presented.
        seguePerformer.performSegue(withIdentifier: "mySegue", sender: self) {
            (myPresentedViewController: MyPresentedViewController) in
            myPresentedViewController.myProperty = myPropertyValue
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
```

Without SeguePerformer, the traditional way of writing this would be:

```swift
class MyPresentingViewController: UIViewController {

    var myPresentedViewControllerPropertyValue: Int?

    func performMySegue(with myPropertyValue: Int) {
        myPresentedViewControllerPropertyValue = myPropertyValue
        performSegue(withIdentifier: "mySegue", sender: self)
        // Continues in prepare(for:sender:)...
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let myPresentedViewController = segue.destination as? MyPresentedViewController,
            let myPresentedViewControllerPropertyValue = myPresentedViewControllerPropertyValue {
            // ...continued from performMySegue(with:)
            myPresentedViewController.myProperty = myPresentedViewControllerPropertyValue
            self.myPresentedViewControllerPropertyValue = nil
        }
    }

}
```
