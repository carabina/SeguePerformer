//
//  SeguePerformer.swift
//  SeguePerformer
//
//  Created by Drew Olbrich on 12/18/18.
//  Copyright © 2018 Drew Olbrich. All rights reserved.
//

import UIKit

/// An object that can be used to initiate segues from a view controller, but using
/// closures for view controller preparation.
///
/// Unlike `UIViewController.performSegue(withIdentifier:sender:)`, which relies on
/// `UIViewController.prepare(for:sender:)` to configure the new view controller
/// before it is presented,
/// `SeguePerformer.peformSegue(withIdentifier:sender:preparationHandler:)` provides
/// this opportunity via its `preparationHandler` closure parameter.
///
/// The advantage of this approach is that the preparation logic is declared locally
/// to the `performSegue` call, rather than separately in `prepare(for:sender:)`,
/// which can become unwieldy in the context of multiple `performSegue` calls.
///
class SeguePerformer {

    private weak var presentingviewController: UIViewController?

    private var segueIdentifier: String?
    private var seguePreparationHandler: ((_ segue: UIStoryboardSegue) -> Bool)?

    /// Returns an object that can be used to initiate segues from the specified view
    /// controller.
    ///
    /// - Parameter viewController: The view controller whose storyboard file will act
    ///     as a source of segues later initiated by
    ///     `performSegue(withIdentifier:sender:preparationHandler:)`.
    ///
    init(viewController: UIViewController) {
        self.presentingviewController = viewController
    }

    /// Initiates a segue with the specified identifer, using a closure to configure the
    /// destination view controller.
    ///
    /// - Parameters:
    ///   - identifier: The string that identifies the triggered segue.
    ///   - sender: The object that used to initiate the segue.
    ///   - preparationHandler: The closure that is called to before the segue is performed.
    ///
    /// For this method to work properly, the caller must provide an implementation of
    /// `UIViewController.prepare(for:sender:)` which calls
    /// `SeguePerformer.prepare(for:sender:)`.
    ///
    public func performSegue<T: UIViewController>(withIdentifier identifier: String, sender: Any?, preparationHandler: ((_ viewController: T) -> Void)?) {
        self.segueIdentifier = identifier

        self.seguePreparationHandler = { (segue: UIStoryboardSegue) in
            guard let viewController = segue.destination as? T else {
                assertionFailure("The presented view controller is type \(type(of: segue.destination).self), which does not match the segue preparation handler parameter type, \(T.self).")
                return false
            }
            preparationHandler?(viewController)
            return true
        }

        presentingviewController?.performSegue(withIdentifier: identifier, sender: sender)
    }

    /// Calls the `preparationHandler` closure parameter passed earlier to
    /// `performSegue(withIdentifier:sender:preparationHandler:)`.
    ///
    /// - Parameters:
    ///   - segue: The segue object containing information about the view controllers involved in the segue.
    ///   - sender: The object that initiated the segue.
    ///
    /// - Returns: `true` if the segue was initiated by an earlier call to
    ///     `performSegue(withIdentifier:sender:preparationHandler:)` or `false` if it was
    ///     initiated by a traditional call to `UIViewController.prepare(for:sender:)`.
    ///
    /// This method must be called by `UIViewController.prepare(for:sender:)`, or
    /// otherwise the `preparationHandler` closure passeed to
    /// `performSegue(withIdentifier:sender:preparationHandler:)` will never be called.
    ///
    public func prepare(for segue: UIStoryboardSegue, sender: Any?) -> Bool {
        guard segue.identifier == segueIdentifier else {
            return false
        }
        segueIdentifier = nil

        return seguePreparationHandler?(segue) ?? false
    }

}
