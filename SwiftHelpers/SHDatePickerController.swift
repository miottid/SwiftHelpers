//
//  SHDatePickerController.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 16/08/2016.
//  Copyright © 2016 Wopata. All rights reserved.
//

import UIKit

import UIKit

/*
** A view controller responsible for presenting a date picker to the user
** and pass back the selected date.
** Should be used along with the `DatePickerAnimatedTransition` custom presentation / dismissal.
*/
public class SHDatePickerViewController: UIViewController {

    /// The date picker of the controller. Can be used to customize the mode, for example.
    public let datePicker = UIDatePicker()

    /// The background view that overlays the presenter's content. Default background is black @ 50%
    public let background = UIView()

    /// Called whenenver the view controller is dismissed. Date is `nil` unless the confirm button is tapped.
    public var completion: (NSDate? -> Void)? = nil

    private let toolbar = UIToolbar()
    private var bottomView = UIView()

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
        setupBottomView()
        setupDatePicker()
        setupToolbar()
    }

    private func setupBackground() {
        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[background]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["background": background])
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[background]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["background": background])
        let constraints = hConstraints + vConstraints
        view.addConstraints(constraints)

        background.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedBackgroundView(_:)))
        background.addGestureRecognizer(tapGestureRecognizer)

        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedBackgroundView(_:)))
        swipeGestureRecognizer.direction = .Down
        background.addGestureRecognizer(swipeGestureRecognizer)
    }

    private func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[bottomView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["bottomView": bottomView])
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[bottomView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["bottomView": bottomView])
        let constraints = hConstraints + vConstraints
        view.addConstraints(constraints)

        bottomView.backgroundColor = .whiteColor()
    }

    private func setupDatePicker() {
        bottomView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[datePicker]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["datePicker": datePicker])
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[datePicker]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["datePicker": datePicker])
        let constraints = hConstraints + vConstraints
        view.addConstraints(constraints)
    }

    private func setupToolbar() {
        bottomView.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[toolbar]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["toolbar": toolbar])
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[toolbar][datePicker]", options: NSLayoutFormatOptions(), metrics: nil, views: ["toolbar": toolbar, "datePicker": datePicker])
        let constraints = hConstraints + vConstraints
        view.addConstraints(constraints)

        let leftSpace = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        leftSpace.width = 10
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(tappedCancelButton(_:)))
        let centerSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let confirmButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(tappedDoneButton(_:)))
        let rightSpace = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        rightSpace.width = 10
        toolbar.items = [leftSpace, cancelButton, centerSpace, confirmButton, rightSpace]
    }

    func tappedDoneButton(button: UIBarButtonItem) {
        dismissWithDate(datePicker.date)
    }

    func tappedCancelButton(button: UIBarButtonItem) {
        dismissWithDate(nil)
    }

    func tappedBackgroundView(gestureRecognizer: UITapGestureRecognizer) {
        dismissWithDate(nil)
    }

    func swipedBackgroundView(gestureRecognizer: UISwipeGestureRecognizer) {
        dismissWithDate(nil)
    }

    private func dismissWithDate(date: NSDate?) {
        dismissViewControllerAnimated(true) {
            self.completion?(date)
        }
    }

}

/// A class used to animate the transition of a SHDatePickerViewController
public class SHDatePickerAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {

    private let isPresenting: Bool

    init(forPresentation isPresenting: Bool) {
        self.isPresenting = isPresenting
    }

    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }

    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            animatePresentation(transitionContext)
        } else {
            animateDismissal(transitionContext)
        }
    }

    private func animatePresentation(transitionContext: UIViewControllerContextTransitioning) {
        guard let container = transitionContext.containerView(),
            datePickerController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? SHDatePickerViewController else {
                transitionContext.completeTransition(false)
                return
        }

        let duration = transitionDuration(transitionContext)

        let datePickerView = datePickerController.view
        container.addSubview(datePickerView)
        let hConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[datePickerView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["datePickerView": datePickerView])
        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[datePickerView]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["datePickerView": datePickerView])
        let constraints = hConstraints + vConstraints
        container.addConstraints(constraints)
        container.layoutIfNeeded()

        let bottomView = datePickerController.bottomView
        bottomView.transform = CGAffineTransformMakeTranslation(0, bottomView.bounds.height)

        let background = datePickerController.background
        background.alpha = 0

        UIView.animateWithDuration(duration / 3, delay: 0, options: [.CurveEaseInOut], animations: {
            background.alpha = 1
            }, completion: { _ in
                UIView.animateWithDuration(duration / 3 * 2, delay: 0, options: [.CurveEaseInOut], animations: {
                    bottomView.transform = CGAffineTransformIdentity
                    }, completion: { _ in
                        transitionContext.completeTransition(true)
                })
        })
    }

    private func animateDismissal(transitionContext: UIViewControllerContextTransitioning) {
        guard let datePickerController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? SHDatePickerViewController else {
            transitionContext.completeTransition(false)
            return
        }

        let duration = transitionDuration(transitionContext)
        let datePickerView = datePickerController.view
        let bottomView = datePickerController.bottomView
        let background = datePickerController.background

        UIView.animateWithDuration(duration / 3 * 2, delay: 0, options: [.CurveEaseInOut], animations: {
            bottomView.transform = CGAffineTransformMakeTranslation(0, bottomView.bounds.height)
            }, completion: { _ in
                UIView.animateWithDuration(duration / 3, delay: 0, options: [.CurveEaseInOut], animations: {
                    background.alpha = 0
                    }, completion: { _ in
                        datePickerView.removeFromSuperview()
                        transitionContext.completeTransition(true)
                })
        })
    }
    
}
