//
//  SeguePerformerTests.swift
//  SeguePerformerTests
//
//  Created by Drew Olbrich on 12/18/18.
//  Copyright © 2018 Drew Olbrich. All rights reserved.
//

import XCTest
@testable import SeguePerformer

class SeguePerformerTests: XCTestCase {

    private var window: UIWindow?
    private var presentingViewController: PresentingViewController?

    private let testString = "whatever"

    override func setUp() {
        let storyboard = UIStoryboard(name: "SeguePerformerTests", bundle: Bundle(for: SeguePerformerTests.self))

        presentingViewController = storyboard.instantiateInitialViewController() as? PresentingViewController
        XCTAssertNotNil(presentingViewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.isHidden = false
        presentingViewController?.viewWillAppear(false)
        presentingViewController?.viewDidAppear(false)
        window?.rootViewController = presentingViewController
    }

    override func tearDown() {
        presentingViewController?.viewWillDisappear(false)
        presentingViewController?.viewDidDisappear(false)
        window?.rootViewController = nil
        window?.isHidden = true
        window = nil

        presentingViewController = nil
    }

    // Tests that SeguePerformer.prepare(for:sender:) is called as expected
    // when SeguePerformer.performSegue(withIdentifier:sender:) is called.
    func testPrepareForSegue() {
        guard let presentingViewController = presentingViewController else {
            XCTFail("Presenting view controller is undefined.")
            return
        }

        var hasCalledPreparationHandler = false

        // Peform the test segue, assigning a test string to the presented
        // view controller.
        presentingViewController.seguePerformer.performSegue(withIdentifier: "testSegue", sender: self) { (presentedViewController: PresentedViewController) in
            hasCalledPreparationHandler = true
            presentedViewController.testString = self.testString
        }

        // The preparation handler was called because
        // PresentingViewController.prepare(for:sender:) called
        // SeguePerformer.prepare(for:sender:), as expected.
        XCTAssert(hasCalledPreparationHandler)

        // A view controller was presented.
        XCTAssertNotNil(presentingViewController.presentedViewController)

        // The presented view controller is of type PresentingViewController.
        let presentedViewController = presentingViewController.presentedViewController as? PresentedViewController
        XCTAssertNotNil(presentedViewController)

        // The test string we assigned in the preparation handler was correctly assigned to
        // PresentedViewController.
        XCTAssertEqual(presentedViewController?.testString, testString)
    }

}
