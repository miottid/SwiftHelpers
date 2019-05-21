//
//  SHPagedScrollView.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 03/06/2016.
//  Copyright © 2016 Maxime de Chalendar. All rights reserved.
//

#if os(iOS)

import UIKit

/**
 *  A data source for a PagedScrollView
 */
@objc public protocol SHPagedScrollViewDataSource {

    /**
     Should return the number of items in a paged scroll view
     - parameter pagedScrollView: The paged scroll view in question
     - returns: The number of items that the paged scroll view should display
     */
    func numberOfItems(in pagedScrollView: SHPagedScrollView) -> Int

    /**
     Should return a view that should be displayed at a given index
     in the paged scroll view
     - parameter pagedScrollView: The paged scroll view in question
     - parameter index:           The index of the view to display
     - returns: The view that should be displayed
     */
    func pagedScrollView(_ pagedScrollView: SHPagedScrollView, viewAt index: Int) -> UIView

    /**
     Called when a user taps a view
     - parameter pagedScrollView: The paged scroll view in question
     - parameter index:           The index of the view that was tapped
     */
    @objc optional func pagedScrollView(_ pagedScrollView: SHPagedScrollView, tappedViewAt index: Int)

}

open class SHPagedScrollView: UIScrollView {

    /// The spacing between cells
    @IBInspectable open var interitemSpacing: CGFloat = 0

    /// The number of items to preload after the currently displayed cell
    @IBInspectable open var numberOfItemsToPreload: Int = 5

    /// The datasource of the PagedScrollView
    open var datasource: SHPagedScrollViewDataSource?

    /// The number of cells that are currently in the paged scroll view
    open var preloadedCount: Int {
        return views.count
    }

    /// Should be called by the delegate of
    /// the scrollview, to generate more cells as you scroll
    open func pagedScrollViewDidScroll() {
        let nextIndex = getScrollingInformationsFromCurrentContentOffset().nextIndex
        if nextIndex == preloadedCount - 1 {
            loadViewsUntilIndex(nextIndex + numberOfItemsToPreload)
        }
    }

    fileprivate var views = [UIView]()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    fileprivate func commonInit() {
        clipsToBounds = false
        isPagingEnabled = true
    }

    @objc func viewWasTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let view = gestureRecognizer.view, let index = views.firstIndex(of: view) else { return }
        datasource?.pagedScrollView?(self, tappedViewAt: index)
    }

}

public extension SHPagedScrollView /* Public methods */ {

    /**
     Reloads all the views in the paged scroll view
     */
    func reloadData() {
        guard let datasource = datasource else { return }

        views.forEach { $0.removeFromSuperview() }
        views = []

        let numberOfItemsToDisplay = min(numberOfItemsToPreload, datasource.numberOfItems(in: self))
        loadViewsUntilIndex(numberOfItemsToDisplay)
    }

    /**
     Scrolls to the view at a given index
     - parameter index:    The index of the item to scroll to
     - parameter animated: Whether the scroll should be animated or not
     */
    func scrollToItem(at index: Int, animated: Bool = true) {
        loadViewsUntilIndex(index)
        let pageWidth = bounds.size.width
        let pageOffset = CGPoint(x: pageWidth * CGFloat(index), y: 0)
        setContentOffset(pageOffset, animated: animated)
    }

    /**
     Returns the view for a given index
     - parameter idx: The index of the view to get
     - returns: The displayed view
     */
    func view(at idx: Int) -> UIView? {
        guard idx >= 0 && idx < views.count else {
            print("Can't get view in PagedScrollView at index \(idx). Index should be contained between in 0..<\(views.count)")
            return nil
        }

        return views[idx].subviews[0] // views is the list of containers
    }

    /**
     Returns a tuple with informations about the current scrolling informations
     This can be used to add interpolation animations when the user scrolls, in
     scrollViewDidScroll(_:)
     currentIndex and nextIndex will always be contained between 0 and the number of displayed views.
     If currentIndex and nextIndex are the same; it means that the user is bouncing the scrollview.
     - returns: A tuple with the currently displayed index, the next index, and an iterpolation between the two.
     */
    func getScrollingInformationsFromCurrentContentOffset() -> (currentIndex: Int, nextIndex: Int, interpolation: Float) {
        let pageWidth = bounds.width
        guard preloadedCount > 0 && pageWidth > 0 else { return (0, 0, 0) }

        let currentXOffset = min(contentSize.width, max(0, contentOffset.x))

        let currentPage = Int(floor(currentXOffset / pageWidth))
        let interpolation = (currentXOffset - (CGFloat(currentPage) * pageWidth)) / pageWidth

        return (max(currentPage, 0), min(currentPage + 1, Int(preloadedCount - 1)), Float(interpolation))
    }
}

public extension SHPagedScrollView /* Building the view */ {

    fileprivate func addView(_ view: UIView, at idx: Int, ignoreLastConstraint: Bool) {
        guard idx >= 0 && idx <= views.count else {
            fatalError("Can't add a view in PagedScrollView at index \(idx). Index should be contained between in 0...\(views.count)")
        }

        let previousView: UIView? = (idx == 0 ? nil : views[idx - 1])
        let nextView: UIView? = (idx == views.count ? nil : views[idx])

        removeConstraintsBetweenViews(previousView: previousView, nextView: nextView)
        let container = addView(view)
        addConstraintBetweenPrevious(previousView: previousView, andView: container)
        if !ignoreLastConstraint {
            addConstraintBetweenView(container, andNextView: nextView)
        }
    }

    fileprivate func addView(_ view: UIView) -> UIView {
        let containerView = UIView()

        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let containerWidth = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        let containerHeight = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
        let containerTop = NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let containerBottom = NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let containerConstraints = [containerWidth, containerHeight, containerTop, containerBottom]
        addConstraints(containerConstraints)

        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let viewTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0)
        let viewBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0)
        let viewLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1, constant: interitemSpacing / 2)
        let viewRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1, constant: -interitemSpacing / 2)
        let viewConstraints = [viewTop, viewBottom, viewLeft, viewRight]
        containerView.addConstraints(viewConstraints)

        views.append(containerView)

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewWasTapped(_:)))
        containerView.addGestureRecognizer(gestureRecognizer)

        return containerView
    }

    fileprivate func addConstraintBetweenPrevious(previousView previous: UIView?, andView view: UIView) {
        let constraint: NSLayoutConstraint
        if let previous = previous {
            constraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: previous, attribute: .trailing, multiplier: 1, constant: 0)
        } else {
            constraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        }
        view.superview?.addConstraint(constraint)
    }

    fileprivate func addConstraintBetweenView(_ view: UIView, andNextView next: UIView?) {
        // we don't need a constraint between the view and the next, we already have
        // the previous one covering that. we only need to add one at the end of the
        // scrollview
        if next == nil {
            let constraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
            view.superview?.addConstraint(constraint)
        }
    }

    fileprivate func removeConstraintsBetweenViews(previousView previous: UIView?, nextView next: UIView?) {
        let constraintsToRemove: [NSLayoutConstraint]

        if let previous = previous, let next = next {
            constraintsToRemove = constraints.filter { // we're adding it before another view, remove the trailing constraints to the next view's leading
                let isPreviousViewTrailing = ($0.firstItem as? UIView) == previous && $0.firstAttribute == .trailing
                let isNextViewLeading = ($0.secondItem as? UIView) == next && $0.secondAttribute == .leading
                return (isPreviousViewTrailing && isNextViewLeading)
            }
        } else if let previous = previous { // we're adding it at the last position, remove the trailing constraints to self
            constraintsToRemove = constraints.filter {
                let isPreviousViewTrailing = ($0.firstItem as? UIView) == previous && $0.firstAttribute == .trailing
                let isSelfTrailing = ($0.secondItem as? UIView) == self && $0.secondAttribute == .trailing
                return isPreviousViewTrailing && isSelfTrailing
            }
        } else if let next = next { // we're adding it at the first position, remove the leading constraints to self
            constraintsToRemove = constraints.filter {
                let isNextViewLeading = ($0.firstItem as? UIView) == next && $0.firstAttribute == .leading
                let isSelfLeading = ($0.secondItem as? UIView) == self && $0.secondAttribute == .leading
                return isNextViewLeading && isSelfLeading
            }
        } else {
            constraintsToRemove = []
        }

        removeConstraints(constraintsToRemove)
    }

    fileprivate func loadViewsUntilIndex(_ index: Int) {
        guard let datasource = datasource else { return }

        let rangedIndex = min(index, datasource.numberOfItems(in: self))
        guard rangedIndex > views.count else { return }

        for idx in views.count..<rangedIndex {
            let isLast = (idx == rangedIndex - 1)
            let view = datasource.pagedScrollView(self, viewAt: idx)
            addView(view, at: idx, ignoreLastConstraint: !isLast)
        }
        layoutIfNeeded()
    }
    
}

#endif
