//
//  SHDatePickerController.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 16/08/2016.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

import UIKit

#if os(iOS)

/*
** A view controller responsible for presenting a date picker to the user
** and pass back the selected date.
** Should be used along with the `DatePickerAnimatedTransition` custom presentation / dismissal.
*/
open class SHDatePickerViewController: UIViewController {

    /// The date picker of the controller. Can be used to customize the mode, for example.
    public let datePicker = UIDatePicker()

    /// The background view that overlays the presenter's content. Default background is black @ 50%
    public let background = UIView()

    /// Called whenenver the view controller is dismissed. Date is `nil` unless the confirm button is tapped.
    open var completion: ((Date?) -> Void)? = nil

    fileprivate let toolbar = UIToolbar()
    fileprivate var bottomView = UIView()

    override open func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
        setupBottomView()
        setupDatePicker()
        setupToolbar()
    }

    fileprivate func setupBackground() {
        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[background]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["background": background])
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[background]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["background": background])
        let constraints = hConstraints + vConstraints
        view.addConstraints(constraints)

        background.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedBackgroundView(_:)))
        background.addGestureRecognizer(tapGestureRecognizer)

        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedBackgroundView(_:)))
        swipeGestureRecognizer.direction = .down
        background.addGestureRecognizer(swipeGestureRecognizer)
    }

    fileprivate func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomView]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["bottomView": bottomView])
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[bottomView]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["bottomView": bottomView])
        let constraints = hConstraints + vConstraints
        view.addConstraints(constraints)

        bottomView.backgroundColor = .white
    }

    fileprivate func setupDatePicker() {
        bottomView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[datePicker]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["datePicker": datePicker])
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[datePicker]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["datePicker": datePicker])
        let constraints = hConstraints + vConstraints
        view.addConstraints(constraints)
    }

    fileprivate func setupToolbar() {
        bottomView.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[toolbar]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["toolbar": toolbar])
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[toolbar][datePicker]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["toolbar": toolbar, "datePicker": datePicker])
        let constraints = hConstraints + vConstraints
        view.addConstraints(constraints)

        let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftSpace.width = 10
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tappedCancelButton(_:)))
        let centerSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let confirmButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDoneButton(_:)))
        let rightSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        rightSpace.width = 10
        toolbar.items = [leftSpace, cancelButton, centerSpace, confirmButton, rightSpace]
    }

    @objc func tappedDoneButton(_ button: UIBarButtonItem) {
        dismissWithDate(datePicker.date)
    }

    @objc func tappedCancelButton(_ button: UIBarButtonItem) {
        dismissWithDate(nil)
    }

    @objc func tappedBackgroundView(_ gestureRecognizer: UITapGestureRecognizer) {
        dismissWithDate(nil)
    }

    @objc func swipedBackgroundView(_ gestureRecognizer: UISwipeGestureRecognizer) {
        dismissWithDate(nil)
    }

    fileprivate func dismissWithDate(_ date: Date?) {
        dismiss(animated: true) {
            self.completion?(date)
        }
    }

}

/// A class used to animate the transition of a SHDatePickerViewController
open class SHDatePickerAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {

    open var presenting: Bool

    public init(forPresentation presenting: Bool) {
        self.presenting = presenting
    }

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            animatePresentation(transitionContext)
        } else {
            animateDismissal(transitionContext)
        }
    }

    fileprivate func animatePresentation(_ transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard
            let datePickerController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? SHDatePickerViewController,
            let datePickerView = datePickerController.view else {
                transitionContext.completeTransition(false)
                return
        }

        let duration = transitionDuration(using: transitionContext)

        container.addSubview(datePickerView)

        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[datePickerView]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["datePickerView": datePickerView])
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[datePickerView]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["datePickerView": datePickerView])
        let constraints = hConstraints + vConstraints
        container.addConstraints(constraints)
        container.layoutIfNeeded()

        let bottomView = datePickerController.bottomView
        bottomView.transform = CGAffineTransform(translationX: 0, y: bottomView.bounds.height)

        let background = datePickerController.background
        background.alpha = 0

        UIView.animate(withDuration: duration / 3, delay: 0, options: UIView.AnimationOptions(), animations: {
            background.alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: duration / 3.0 * 2, delay: 0, options: UIView.AnimationOptions(), animations: {
                    bottomView.transform = CGAffineTransform.identity
                    }, completion: { _ in
                        transitionContext.completeTransition(true)
                })
        })
    }

    fileprivate func animateDismissal(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let datePickerController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? SHDatePickerViewController else {
            transitionContext.completeTransition(false)
            return
        }

        let duration = transitionDuration(using: transitionContext)
        let datePickerView = datePickerController.view
        let bottomView = datePickerController.bottomView
        let background = datePickerController.background

        UIView.animate(withDuration: duration / 3 * 2, delay: 0, options: UIView.AnimationOptions(), animations: {
            bottomView.transform = CGAffineTransform(translationX: 0, y: bottomView.bounds.height)
            }, completion: { _ in
                UIView.animate(withDuration: duration / 3, delay: 0, options: UIView.AnimationOptions(), animations: {
                    background.alpha = 0
                    }, completion: { _ in
                        datePickerView?.removeFromSuperview()
                        transitionContext.completeTransition(true)
                })
        })
    }
    
}

#endif
