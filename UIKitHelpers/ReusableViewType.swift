//
//  ReusableViewType.swift
//
//  Created by Chandler De Angelis on 9/2/16.
//

import Foundation
import UIKit

public protocol ReusableViewType {
    static var reuseIdentifier: String { get }
}

extension ReusableViewType where Self: NSObject {
    static public var reuseIdentifier: String {
        let classString = NSStringFromClass(self)
        if classString.contains(".") {
            return classString.components(separatedBy: ".")[1]
        } else {
            return classString
        }
    }
}

public extension UITableViewHeaderFooterView: ReusableViewType {}
public extension UITableViewCell: ReusableViewType {}
public extension UICollectionReusableView: ReusableViewType {}
public extension UIViewController: ReusableViewType {}
