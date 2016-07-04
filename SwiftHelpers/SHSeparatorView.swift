//
//  SHSeparatorView.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 04/07/2016.
//  Copyright © 2016 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

/**
 A class that creates 1px views on any screen scale

 This class will convert 1pt width or height constraints to 1px constraints
 */
class SeparatorView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        let constraintsToEdit = constraints.filter { theCompilerFailsToDetectThisAsAnNSLayoutConstraint in
            let constraint = theCompilerFailsToDetectThisAsAnNSLayoutConstraint as NSLayoutConstraint
            return (constraint.firstAttribute == .Height || constraint.firstAttribute == .Width) && constraint.constant == 1
        }

        for constraint in constraintsToEdit {
            constraint.constant = 1 / UIScreen.mainScreen().scale
        }
    }
    
}

#endif
