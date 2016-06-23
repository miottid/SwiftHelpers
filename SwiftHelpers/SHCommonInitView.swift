//
//  SHCommonInitView.swift
//  SwiftHelpers
//
//  Created by David Miotti on 22/11/15.
//  Copyright © 2015 Wopata. All rights reserved.
//

#if os(iOS)

import UIKit

public class SHCommonInitView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func commonInit() {
        
    }

}

public class SHCommonInitTableViewCell: UITableViewCell {
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func commonInit() {
        
    }
    
}

public class SHCommonInitCollectionViewCell: UICollectionViewCell {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func commonInit() {
        
    }
    
}

#endif
