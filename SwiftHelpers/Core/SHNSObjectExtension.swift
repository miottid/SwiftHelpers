//
//  SHNSObjectExtension.swift
//  SwiftHelpers
//
//  Created by Maxime de Chalendar on 04/07/2016.
//  Copyright © 2016 Muxu.Muxu. All rights reserved.
//

import Foundation

extension NSObject {

    /**
     Returns a string representing the name of a class, not prefixed by the module.
     Example:
     NSStringFromClass(UITableViewCell) returns "UIKit.UITableViewCell"
     UITableViewCell.className returns "UITableViewCell"
     */
    public class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    /**
     Returns a string that can be used as a reuse identifier for objects of a given class.
     This simply returns the `className` variable, but it's here because the naming of this
     property makes more sense when using it for a dequeable resource, such as UITableViewCell
     or UICollectionViewCell
    */
    public class var classReuseIdentifier: String {
        return className
    }

}
