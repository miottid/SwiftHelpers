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
public protocol SHPagedScrollViewDataSource {

    /**
     Should return the number of items in a paged scroll view
     - parameter pagedScrollView: The paged scroll view in question
     - returns: The number of items that the paged scroll view should display
     */
    func numberOfItemsInPagedScrollView(pagedScrollView: SHPagedScrollView) -> Int

    /**
     Should return a view that should be displayed at a given index
     in the paged scroll view
     - parameter pagedScrollView: The paged scroll view in question
     - parameter index:           The index of the view to display
     - returns: The view that should be displayed
     */
    func pagedScrollView(pagedScrollView: SHPagedScrollView, viewAtIndex index: Int) -> UIView

}

public class SHPagedScrollView: UIScrollView {

    /// The spacing between cells
    @IBInspectable public var interitemSpacing: CGFloat = 0

    /// The number of items to preload after the currently displayed cell
    @IBInspectable public var numberOfItemsToPreload: Int = 5

    /// The datasource of the PagedScrollView
    public var datasource: SHPagedScrollViewDataSource?

    /// The number of cells that are currently in the paged scroll view
    public var preloadedCount: Int {
        return views.count
    }

    /// Should be called by the delegate of
    /// the scrollview, to generate more cells as you scroll
    public func pagedScrollViewDidScroll() {
        let nextIndex = getScrollingInformationsFromCurrentContentOffset().nextIndex
        if nextIndex == preloadedCount - 1 {
            loadViewsUntilIndex(nextIndex + numberOfItemsToPreload)
        }
    }

    private var views = [UIView]()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        clipsToBounds = false
        pagingEnabled = true
    }

}

public extension SHPagedScrollView /* Public methods */ {

    /**
     Reloads all the views in the paged scroll view
     */
    public func reloadData() {
        guard let datasource = datasource else { return }

        views.forEach { $0.removeFromSuperview() }
        views = []

        let numberOfItemsToDisplay = min(numberOfItemsToPreload, datasource.numberOfItemsInPagedScrollView(self))
        loadViewsUntilIndex(numberOfItemsToDisplay)
    }

    /**
     Scrolls to the view at a given index
     - parameter index:    The index of the item to scroll to
     - parameter animated: Whether the scroll should be animated or not
     */
    public func scrollToItemAtIndex(index: Int, animated: Bool = true) {
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
    public func viewAtIndex(idx: Int) -> UIView? {
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
    public func getScrollingInformationsFromCurrentContentOffset() -> (currentIndex: Int, nextIndex: Int, interpolation: Float) {
        let pageWidth = bounds.width
        guard preloadedCount > 0 && pageWidth > 0 else { return (0, 0, 0) }

        let currentXOffset = contentOffset.x.rangedBetween(min: 0, max: contentSize.width)

        let currentPage = Int(floor(currentXOffset / pageWidth))
        let interpolation = (currentXOffset - (CGFloat(currentPage) * pageWidth)) / pageWidth

        return (max(currentPage, 0), min(currentPage + 1, Int(preloadedCount - 1)), Float(interpolation))
    }
}

public extension SHPagedScrollView /* Building the view */ {

    private func addView(view: UIView, atIndex idx: Int, ignoreLastConstraint: Bool) {
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

    private func addView(view: UIView) -> UIView {
        let containerView = UIView()

        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let containerWidth = NSLayoutConstraint(item: containerView, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: 0)
        let containerHeight = NSLayoutConstraint(item: containerView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 1, constant: 0)
        let containerTop = NSLayoutConstraint(item: containerView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0)
        let containerBottom = NSLayoutConstraint(item: containerView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        let containerConstraints = [containerWidth, containerHeight, containerTop, containerBottom]
        addConstraints(containerConstraints)

        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let viewTop = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: containerView, attribute: .Top, multiplier: 1, constant: 0)
        let viewBottom = NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: containerView, attribute: .Bottom, multiplier: 1, constant: 0)
        let viewLeft = NSLayoutConstraint(item: view, attribute: .Left, relatedBy: .Equal, toItem: containerView, attribute: .Left, multiplier: 1, constant: interitemSpacing / 2)
        let viewRight = NSLayoutConstraint(item: view, attribute: .Right, relatedBy: .Equal, toItem: containerView, attribute: .Right, multiplier: 1, constant: -interitemSpacing / 2)
        let viewConstraints = [viewTop, viewBottom, viewLeft, viewRight]
        containerView.addConstraints(viewConstraints)

        views.append(containerView)
        return containerView
    }

    private func addConstraintBetweenPrevious(previousView previous: UIView?, andView view: UIView) {
        let constraint: NSLayoutConstraint
        if let previous = previous {
            constraint = NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: previous, attribute: .Trailing, multiplier: 1, constant: 0)
        } else {
            constraint = NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0)
        }
        view.superview?.addConstraint(constraint)
    }

    private func addConstraintBetweenView(view: UIView, andNextView next: UIView?) {
        // we don't need a constraint between the view and the next, we already have
        // the previous one covering that. we only need to add one at the end of the
        // scrollview
        if next == nil {
            let constraint = NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1, constant: 0)
            view.superview?.addConstraint(constraint)
        }
    }

    private func removeConstraintsBetweenViews(previousView previous: UIView?, nextView next: UIView?) {
        let constraintsToRemove: [NSLayoutConstraint]

        if let previous = previous, next = next {
            constraintsToRemove = constraints.filter { // we're adding it before another view, remove the trailing constraints to the next view's leading
                let isPreviousViewTrailing = ($0.firstItem as? UIView) == previous && $0.firstAttribute == .Trailing
                let isNextViewLeading = ($0.secondItem as? UIView) == next && $0.secondAttribute == .Leading
                return (isPreviousViewTrailing && isNextViewLeading)
            }
        } else if let previous = previous { // we're adding it at the last position, remove the trailing constraints to self
            constraintsToRemove = constraints.filter {
                let isPreviousViewTrailing = ($0.firstItem as? UIView) == previous && $0.firstAttribute == .Trailing
                let isSelfTrailing = ($0.secondItem as? UIView) == self && $0.secondAttribute == .Trailing
                return isPreviousViewTrailing && isSelfTrailing
            }
        } else if let next = next { // we're adding it at the first position, remove the leading constraints to self
            constraintsToRemove = constraints.filter {
                let isNextViewLeading = ($0.firstItem as? UIView) == next && $0.firstAttribute == .Leading
                let isSelfLeading = ($0.secondItem as? UIView) == self && $0.secondAttribute == .Leading
                return isNextViewLeading && isSelfLeading
            }
        } else {
            constraintsToRemove = []
        }

        removeConstraints(constraintsToRemove)
    }

    private func loadViewsUntilIndex(index: Int) {
        guard let datasource = datasource else { return }

        let rangedIndex = min(index, datasource.numberOfItemsInPagedScrollView(self))
        guard rangedIndex > views.count else { return }

        for idx in views.count..<rangedIndex {
            let isLast = (idx == rangedIndex - 1)
            let view = datasource.pagedScrollView(self, viewAtIndex: idx)
            addView(view, atIndex: idx, ignoreLastConstraint: !isLast)
        }
        layoutIfNeeded()
    }
    
}

#endif