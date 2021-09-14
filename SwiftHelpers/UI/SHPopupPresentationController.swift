//
//  SHPopupPresentationController.swift
//  SwiftHelpers
//
//  Created by David Miotti on 18/01/2018.
//  Copyright © 2018 Muxu.Muxu. All rights reserved.
//

#if os(iOS)
    
public protocol SHPopupPresentationControllerDelegate: AnyObject {
    func presentationControllerDidDismiss(presentationController: SHPopupPresentationController)
}

import UIKit

open class SHPopupInteractor: UIPercentDrivenInteractiveTransition {
    open var hasStarted = false
    open var shouldFinish = false
}

//! The corner radius applied to the view containing the presented view
//! controller.
private let cornerRadius: CGFloat = 12

open class SHPopupPresentationController: UIPresentationController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    open var interactor: SHPopupInteractor?
    
    public var popupPresentationControllerDelegate: SHPopupPresentationControllerDelegate?
    
    // You can customize the dimming view background color
    open var dimingViewBackgroundColor = UIColor.black.withAlphaComponent(0.5)
    
    private var dimmingView: UIView?
    private var presentationWrappingView: UIView?
    
    public init(presentedViewController: UIViewController, presenting: UIViewController) {
        super.init(presentedViewController: presentedViewController, presenting: presenting)
        // The presented view controller must have a modalPresentationStyle
        // of UIModalPresentationCustom for a custom presentation controller
        // to be used.
        presentedViewController.modalPresentationStyle = .custom
    }
    
    open override var presentedView: UIView? {
        // Return the wrapping view created in -presentationTransitionWillBegin.
        return presentationWrappingView
    }
    
    //| ----------------------------------------------------------------------------
    //  This is one of the first methods invoked on the presentation controller
    //  at the start of a presentation.  By the time this method is called,
    //  the containerView has been created and the view hierarchy set up for the
    //  presentation.  However, the -presentedView has not yet been retrieved.
    //
    open override func presentationTransitionWillBegin() {
        // The default implementation of -presentedView returns
        // self.presentedViewController.view.
        let presentedViewControllerView = super.presentedView
        
        // Wrap the presented view controller's view in an intermediate hierarchy
        // that applies a shadow and rounded corners to the top-left and top-right
        // edges.  The final effect is built using three intermediate views.
        //
        // presentationWrapperView              <- shadow
        //   |- presentationRoundedCornerView   <- rounded corners (masksToBounds)
        //        |- presentedViewControllerWrapperView
        //             |- presentedViewControllerView (presentedViewController.view)
        let presentationWrapperView = UIView(frame: frameOfPresentedViewInContainerView)
        presentationWrapperView.layer.shadowOpacity = 0.44
        presentationWrapperView.layer.shadowRadius = 13
        presentationWrapperView.layer.shadowOffset = CGSize(width: 0, height: -6)
        presentationWrappingView = presentationWrapperView
        
        // presentationRoundedCornerView is CORNER_RADIUS points taller than the
        // height of the presented view controller's view.  This is because
        // the cornerRadius is applied to all corners of the view.  Since the
        // effect calls for only the top two corners to be rounded we size
        // the view such that the bottom CORNER_RADIUS points lie below
        // the bottom edge of the screen.
        let presentationRoundedCornerViewFrame = presentationWrapperView.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -cornerRadius, right: 0))
        let presentationRoundedCornerView = UIView(frame: presentationRoundedCornerViewFrame)
        presentationRoundedCornerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentationRoundedCornerView.layer.cornerRadius = cornerRadius
        presentationRoundedCornerView.layer.masksToBounds = true
        
        // To undo the extra height added to presentationRoundedCornerView,
        // presentedViewControllerWrapperView is inset by CORNER_RADIUS points.
        // This also matches the size of presentedViewControllerWrapperView's
        // bounds to the size of -frameOfPresentedViewInContainerView.
        let presentedViewControllerWrapperViewFrame = presentationRoundedCornerView.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: -cornerRadius, right: 0))
        let presentedViewControllerWrapperView = UIView(frame: presentedViewControllerWrapperViewFrame)
        presentedViewControllerWrapperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add presentedViewControllerView -> presentedViewControllerWrapperView.
        presentedViewControllerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentedViewControllerView?.frame = presentedViewControllerWrapperView.bounds
        presentedViewControllerWrapperView.addSubview(presentedViewControllerView!)
        
        // Add presentedViewControllerWrapperView -> presentationRoundedCornerView.
        presentationRoundedCornerView.addSubview(presentedViewControllerWrapperView)
        
        // Add presentationRoundedCornerView -> presentationWrapperView.
        presentationWrapperView.addSubview(presentationRoundedCornerView)
        
        // Add a dimming view behind presentationWrapperView.  self.presentedView
        // is added later (by the animator) so any views added here will be
        // appear behind the -presentedView.
        let dimmingView = UIView(frame: containerView!.bounds)
        dimmingView.backgroundColor = dimingViewBackgroundColor
        dimmingView.isOpaque = false
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped(_:)))
        dimmingView.addGestureRecognizer(tapGesture)
        self.dimmingView = dimmingView
        containerView!.addSubview(dimmingView)
        
        // Get the transition coordinator for the presentation so we can
        // fade in the dimmingView alongside the presentation animation.
        let transitionCoordinator = presentingViewController.transitionCoordinator
        
        self.dimmingView?.alpha = 0
        transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView?.alpha = 1
        })
    }
    
    open override func presentationTransitionDidEnd(_ completed: Bool) {
        // The value of the 'completed' argument is the same value passed to the
        // -completeTransition: method by the animator.  It may
        // be NO in the case of a cancelled interactive transition.
        if !completed {
            // The system removes the presented view controller's view from its
            // superview and disposes of the containerView.  This implicitly
            // removes the views created in -presentationTransitionWillBegin: from
            // the view hierarchy.  However, we still need to relinquish our strong
            // references to those view.
            presentationWrappingView = nil
            dimmingView = nil
        }
    }
    
    open override func dismissalTransitionWillBegin() {
        // Get the transition coordinator for the dismissal so we can
        // fade out the dimmingView alongside the dismissal animation.
        let transitionCoordinator = presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView?.alpha = 0
        })
    }
    
    open override func dismissalTransitionDidEnd(_ completed: Bool) {
        // The value of the 'completed' argument is the same value passed to the
        // -completeTransition: method by the animator.  It may
        // be NO in the case of a cancelled interactive transition.
        if completed {
            // The system removes the presented view controller's view from its
            // superview and disposes of the containerView.  This implicitly
            // removes the views created in -presentationTransitionWillBegin: from
            // the view hierarchy.  However, we still need to relinquish our strong
            // references to those view.
            presentationWrappingView = nil
            dimmingView = nil
        }
    }
    
    // MARK: - Layout
    
    //| ----------------------------------------------------------------------------
    //  This method is invoked whenever the presentedViewController's
    //  preferredContentSize property changes.  It is also invoked just before the
    //  presentation transition begins (prior to -presentationTransitionWillBegin).
    //
    open override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        if let container = container as? UIViewController, container == presentedViewController {
            containerView?.setNeedsLayout()
        }
    }
    
    //| ----------------------------------------------------------------------------
    //  When the presentation controller receives a
    //  -viewWillTransitionToSize:withTransitionCoordinator: message it calls this
    //  method to retrieve the new size for the presentedViewController's view.
    //  The presentation controller then sends a
    //  -viewWillTransitionToSize:withTransitionCoordinator: message to the
    //  presentedViewController with this size as the first argument.
    //
    //  Note that it is up to the presentation controller to adjust the frame
    //  of the presented view controller's view to match this promised size.
    //  We do this in -containerViewWillLayoutSubviews.
    //
    open override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if let container = container as? UIViewController, container == presentedViewController {
            return container.preferredContentSize
        }
        return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
    }
    
    open override var frameOfPresentedViewInContainerView: CGRect {
        let containerViewBounds = containerView!.bounds
        let presentedViewContentSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerViewBounds.size)
        
        // The presented view extends presentedViewContentSize.height points from
        // the bottom edge of the screen.
        var presentedViewControllerFrame = containerViewBounds
        presentedViewControllerFrame.size.height = presentedViewContentSize.height
        presentedViewControllerFrame.origin.y = containerViewBounds.maxY - presentedViewContentSize.height
        return presentedViewControllerFrame
    }
    
    //| ----------------------------------------------------------------------------
    //  This method is similar to the -viewWillLayoutSubviews method in
    //  UIViewController.  It allows the presentation controller to alter the
    //  layout of any custom views it manages.
    //
    open override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        dimmingView?.frame = containerView!.bounds
        presentationWrappingView?.frame = frameOfPresentedViewInContainerView
    }
    
    // MARK: - Tap Gesture Recognizer
    
    @objc func dimmingViewTapped(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true, completion: {
            self.popupPresentationControllerDelegate?.presentationControllerDidDismiss(presentationController: self)
        })
    }
    
    // MARK:  - UIViewControllerAnimatedTransitioning
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        guard let transitionContext = transitionContext else {
            return 0
        }
        
        let percent = (frameOfPresentedViewInContainerView.height * 100 / presentingViewController.view.bounds.height)
        let duration = min(0.35, TimeInterval(0.50 * percent / 100))
        return transitionContext.isAnimated ? duration : 0
    }
    
    //| ----------------------------------------------------------------------------
    //  The presentation animation is tightly integrated with the overall
    //  presentation so it makes the most sense to implement
    //  <UIViewControllerAnimatedTransitioning> in the presentation controller
    //  rather than in a separate object.
    //
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        // For a Presentation:
        //      fromView = The presenting view.
        //      toView   = The presented view.
        // For a Dismissal:
        //      fromView = The presented view.
        //      toView   = The presenting view.
        let toView = transitionContext.view(forKey: .to)
        // If NO is returned from -shouldRemovePresentersView, the view associated
        // with UITransitionContextFromViewKey is nil during presentation.  This
        // intended to be a hint that your animator should NOT be manipulating the
        // presenting view controller's view.  For a dismissal, the -presentedView
        // is returned.
        //
        // Why not allow the animator manipulate the presenting view controller's
        // view at all times?  First of all, if the presenting view controller's
        // view is going to stay visible after the animation finishes during the
        // whole presentation life cycle there is no need to animate it at all — it
        // just stays where it is.  Second, if the ownership for that view
        // controller is transferred to the presentation controller, the
        // presentation controller will most likely not know how to layout that
        // view controller's view when needed, for example when the orientation
        // changes, but the original owner of the presenting view controller does.
        let fromView = transitionContext.view(forKey: .from)
        
        let isPresenting = (fromViewController == presentingViewController)
        
        // This will be the current frame of fromViewController.view.
        _ = transitionContext.initialFrame(for: fromViewController)
        // For a presentation which removes the presenter's view, this will be
        // CGRectZero.  Otherwise, the current frame of fromViewController.view.
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromViewController)
        // This will be CGRectZero.
        var toViewInitalFrame = transitionContext.initialFrame(for: toViewController)
        // For a presentation, this will be the value returned from the
        // presentation controller's -frameOfPresentedViewInContainerView method.
        let toViewFinalFrame = transitionContext.finalFrame(for: toViewController)
        
        if let toView = toView {
            // We are responsible for adding the incoming view to the containerView
            // for the presentation (will have no effect on dismissal because the
            // presenting view controller's view was not removed).
            containerView.addSubview(toView)
        }
        
        if isPresenting {
            toViewInitalFrame.origin = CGPoint(x: containerView.bounds.minX, y: containerView.bounds.maxY)
            toViewInitalFrame.size = toViewFinalFrame.size
            toView!.frame = toViewInitalFrame
        } else {
            // Because our presentation wraps the presented view controller's view
            // in an intermediate view hierarchy, it is more accurate to rely
            // on the current frame of fromView than fromViewInitialFrame as the
            // initial frame (though in this example they will be the same).
            fromViewFinalFrame = fromView!.frame.offsetBy(dx: 0, dy: fromView!.frame.height)
        }
        
        let duration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            if isPresenting {
                toView!.frame = toViewFinalFrame
            } else {
                fromView!.frame = fromViewFinalFrame
            }
        }, completion: { finished in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        })
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    //| ----------------------------------------------------------------------------
    //  If the modalPresentationStyle of the presented view controller is
    //  UIModalPresentationCustom, the system calls this method on the presented
    //  view controller's transitioningDelegate to retrieve the presentation
    //  controller that will manage the presentation.  If your implementation
    //  returns nil, an instance of UIPresentationController is used.
    //
    open func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        assert(presentedViewController == presented, "You didn't initialize \(self) with the correct presentedViewController.  Expected \(presented), got \(presentedViewController).")
        return self
    }
    
    //| ----------------------------------------------------------------------------
    //  The system calls this method on the presented view controller's
    //  transitioningDelegate to retrieve the animator object used for animating
    //  the presentation of the incoming view controller.  Your implementation is
    //  expected to return an object that conforms to the
    //  UIViewControllerAnimatedTransitioning protocol, or nil if the default
    //  presentation animation should be used.
    //
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    //| ----------------------------------------------------------------------------
    //  The system calls this method on the presented view controller's
    //  transitioningDelegate to retrieve the animator object used for animating
    //  the dismissal of the presented view controller.  Your implementation is
    //  expected to return an object that conforms to the
    //  UIViewControllerAnimatedTransitioning protocol, or nil if the default
    //  dismissal animation should be used.
    //
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    open func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactor = interactor else { return nil }
        return interactor.hasStarted ? interactor : nil
    }
}
    
#endif
