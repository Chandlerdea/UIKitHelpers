//
//  UIView+Helpers.swift
//
//  Created by Chandler De Angelis on 9/17/16.
//

import Foundation
import UIKit

extension NSLayoutXAxisAnchor {

    public func constraint(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        return constraint
    }

    public func constraint(equalTo anchor: NSLayoutXAxisAnchor, priority: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor)
        constraint.priority = UILayoutPriority(priority)
        return constraint
    }
}

extension NSLayoutYAxisAnchor {

    public func constraint(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        return constraint
    }

    public func constraint(equalTo anchor: NSLayoutYAxisAnchor, priority: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor)
        constraint.priority = UILayoutPriority(priority)
        return constraint
    }
}

extension NSLayoutDimension {

    public func constraint(equalTo anchor: NSLayoutDimension, constant: CGFloat, priority: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        return constraint
    }

    public func constraint(equalTo anchor: NSLayoutDimension, priority: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor)
        constraint.priority = UILayoutPriority(priority)
        return constraint
    }
}


extension UIView {

    static let defaultSeparatorHeight: CGFloat = 0.5

    class func loadFromNib<T: UIView>() -> T where T: ReusableViewType {
        return UINib(nibName: T.reuseIdentifier, bundle: .main).instantiate(withOwner: .none, options: .none).first as! T
    }
/*
    class func loadContainerViewFromNib<T: ReusableNibView>() -> T where T: ReusableViewType {
        let nib: UINib = UINib(nibName: T.reuseIdentifier, bundle: .main)
        let views: [Any] = nib.instantiate(withOwner: .none, options: .none)
        let containerView: UIView = views.first as! UIView
        return containerView.superview as! T
    }
*/
    class public func autolayoutView<T: UIView>() -> T {
        let result = T(frame: CGRect.zero)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }

    func activateAllSideAnchors(relativeToMargins: Bool! = false, padding: UIEdgeInsets! = nil, priorities: UIEdgeInsets! = nil) {
        guard let superview = self.superview else {
            fatalError("Must have a superview")
        }

        let leftConstraint = relativeToMargins == true ? self.leftAnchor.constraint(equalTo: superview.layoutMarginsGuide.leftAnchor) : self.leftAnchor.constraint(equalTo: superview.leftAnchor)
        let rightConstraint = relativeToMargins == true ? self.rightAnchor.constraint(equalTo: superview.layoutMarginsGuide.rightAnchor) : self.rightAnchor.constraint(equalTo: superview.rightAnchor)
        let topConstraint = relativeToMargins == true ? self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor) : self.topAnchor.constraint(equalTo: superview.topAnchor)
        let bottomConstraint = relativeToMargins == true ? self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor) : self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        if let padding = padding {
            leftConstraint.constant = padding.left
            rightConstraint.constant = -padding.right
            topConstraint.constant = padding.top
            bottomConstraint.constant = -padding.bottom
        }
        if let priorities = priorities {
            leftConstraint.priority = UILayoutPriority(priorities.left)
            rightConstraint.priority = UILayoutPriority(priorities.right)
            topConstraint.priority = UILayoutPriority(priorities.top)
            bottomConstraint.priority = UILayoutPriority(priorities.bottom)
        }
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }

    @discardableResult func addSeparator(with origin: CGPoint? = nil, color: Theme.Colors! = .lightGray1) -> CALayer {
        let layer = CAShapeLayer()
        var origin: CGPoint! = origin
        if origin == nil {
            origin = CGPoint(x: 0.0, y: self.bounds.height - type(of: self).defaultSeparatorHeight)
        }
        layer.frame = CGRect(origin: origin, size: CGSize(width: self.bounds.width, height: type(of: self).defaultSeparatorHeight))
        layer.backgroundColor = color.colorValue.cgColor
        self.layer.addSublayer(layer)
        return layer
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ self.addSubview($0) })
    }

    func resetConstraints() {
        guard self.subviews.count > 0 else { return }
        self.constraints.forEach(self.removeConstraint)
        self.subviews.forEach({ $0.resetConstraints() })
    }

    func removeSublayers() {
        self.layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
    }

    /**
        Resigns the first responder of a view withing the heirarchy of a given view
        - returns:              The view that was the first responder
    */
    @discardableResult func resignSubviewFirstResponder() -> UIView? {
        /**
            Resigns the first responder and stops if resigned
            - parameter view:           The view to check as first responder
            - parameter shouldStop:     The flag to determine if this view is the first responder
            - returns:                  Whether we want to recurse into the subview
         */
        func resignFirstResponderAndStop(_ view: UIView, _ shouldStop: inout Bool) -> Bool {
            guard view.isFirstResponder else {
                return true
            }
            view.resignFirstResponder()
            shouldStop = true
            return false
        }

        for view in self.subviews {
            var newStop: Bool = false
            if resignFirstResponderAndStop(view, &newStop) {
                return view.resignSubviewFirstResponder()
            } else if newStop {
                return view
            }
        }
        return .none
    }

    func firstSubview<T>(ofType type: T.Type) -> T? where T: UIView {
        return self.subviews.first(where: { type(of: $0) == type }) as? T
    }
}
