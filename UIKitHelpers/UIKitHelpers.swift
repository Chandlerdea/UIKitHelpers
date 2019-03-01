//
//  UIKitHelpers.swift
//
//  Created by Chandler De Angelis on 9/17/16.
//

import Foundation
import UIKit

extension NSLayoutXAxisAnchor {
    
    public func constraint(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        return constraint
    }
    
    public func constraint(equalTo anchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor)
        constraint.priority = priority
        return constraint
    }
    
    public func constraint(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0.0, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        return constraint
    }
    
    public func constraint(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0.0, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        return constraint
    }
}

extension NSLayoutYAxisAnchor {
    
    public func constraint(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        return constraint
    }
    
    public func constraint(equalTo anchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor)
        constraint.priority = priority
        return constraint
    }
    
    public func constraint(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0.0, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        return constraint
    }
    
    public func constraint(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0.0, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        return constraint
    }
}

extension NSLayoutDimension {
    
    public func constraint(equalTo anchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.priority = priority
        return constraint
    }
    
    public func constraint(equalTo anchor: NSLayoutDimension, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalTo: anchor)
        constraint.priority = priority
        return constraint
    }
    
    public func constraint(equalToConstant constant: CGFloat, priority: UILayoutPriority) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = self.constraint(equalToConstant: constant)
        constraint.priority = priority
        return constraint
    }
}

extension UIView {
    
    public static let separatorHeight: CGFloat = 0.5
    public static let defaultCornerRadius: CGFloat = 7
    
    class public func autolayoutView<T: UIView>() -> T {
        let result: T = T(frame: CGRect.zero)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
    
    class public func loadFromNib<T: UIView>() -> T where T: ReusableViewType {
        let bundle: Bundle = Bundle(for: T.self)
        let nib: UINib? = UINib(nibName: T.reuseIdentifier, bundle: bundle)
        guard let result: T = nib?.instantiate(withOwner: .none, options: .none).first as? T else {
            fatalError("There needs to be a nib for this class with a matching name")
        }
        return result
    }
    
    public func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(self.addSubview(_:))
    }
    
    @discardableResult
    public func makeSideAnchorConstraints(relativeToMargins: Bool = false, padding: UIEdgeInsets? = .none, priorities: UIEdgeInsets? = .none) -> (top: NSLayoutConstraint, left: NSLayoutConstraint, bottom: NSLayoutConstraint, right: NSLayoutConstraint) {
        guard let superview = self.superview else {
            fatalError("Must have a superview")
        }
        
        let leftConstraint: NSLayoutConstraint
        let rightConstraint: NSLayoutConstraint
        let topConstraint: NSLayoutConstraint
        let bottomConstraint: NSLayoutConstraint
        
        if relativeToMargins {
            leftConstraint = self.leftAnchor.constraint(equalTo: superview.layoutMarginsGuide.leftAnchor)
            rightConstraint = self.rightAnchor.constraint(equalTo: superview.layoutMarginsGuide.rightAnchor)
            topConstraint = self.topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor)
            bottomConstraint = self.bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor)
        } else {
            if #available(iOS 11.0, *) {
                leftConstraint = self.leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor)
                rightConstraint = self.rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor)
                topConstraint = self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor)
                bottomConstraint = self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
            } else {
                leftConstraint = self.leftAnchor.constraint(equalTo: superview.leftAnchor)
                rightConstraint = self.rightAnchor.constraint(equalTo: superview.rightAnchor)
                topConstraint = self.topAnchor.constraint(equalTo: superview.topAnchor)
                bottomConstraint = self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            }
            
            if let padding: UIEdgeInsets = padding {
                leftConstraint.constant = padding.left
                rightConstraint.constant = -padding.right
                topConstraint.constant = padding.top
                bottomConstraint.constant = -padding.bottom
            }
        }
        
        if let priorities: UIEdgeInsets = priorities {
            leftConstraint.priority = UILayoutPriority(Float(priorities.left))
            rightConstraint.priority = UILayoutPriority(Float(priorities.right))
            topConstraint.priority = UILayoutPriority(Float(priorities.top))
            bottomConstraint.priority = UILayoutPriority(Float(priorities.bottom))
        }
        
        return (
            top: topConstraint,
            left: leftConstraint,
            bottom: bottomConstraint,
            right: rightConstraint
        )
    }
    
    @discardableResult
    public func activateAllSideAnchors(relativeToMargins: Bool = false, padding: UIEdgeInsets? = .none, priorities: UIEdgeInsets? = .none) -> (top: NSLayoutConstraint, left: NSLayoutConstraint, bottom: NSLayoutConstraint, right: NSLayoutConstraint) {
        let result: (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint) = self.makeSideAnchorConstraints(relativeToMargins: relativeToMargins, padding: padding, priorities: priorities)
        NSLayoutConstraint.activate([result.0, result.1, result.2, result.3])
        return result
    }
    
    
    @discardableResult public func addSeparator(inset: CGFloat, yOrigin: CGFloat? = nil, height: CGFloat? = nil, color: UIColor? = nil) -> CALayer {
        let separator: CALayer = CALayer()
        
        if let color: UIColor = color {
            separator.backgroundColor = color.cgColor
        } else {
            separator.backgroundColor = UITableView().separatorColor?.cgColor
        }
        separator.frame = self.separatorFrame(
            inset: inset,
            yOrigin: yOrigin,
            height: height
        )
        self.layer.addSublayer(separator)
        
        return separator
    }
    
    public func separatorFrame(inset: CGFloat, yOrigin: CGFloat? = nil, height: CGFloat? = nil) -> CGRect {
        var result: CGRect = CGRect.zero
        
        let finalOrigin: CGPoint
        let finalSize: CGSize
        
        if let unwrappedYOrigin: CGFloat = yOrigin, height == nil {
            finalOrigin = CGPoint(x: inset, y: unwrappedYOrigin)
            finalSize = CGSize(width: self.bounds.width - inset, height: UIView.separatorHeight)
        } else if let unwrappedHeight: CGFloat = height, yOrigin == nil {
            finalOrigin = CGPoint(x: inset, y: self.bounds.height - unwrappedHeight)
            finalSize = CGSize(width: self.bounds.width - inset, height: unwrappedHeight)
        } else if let unwrappedYOrigin: CGFloat = yOrigin, let unwrappedHeight: CGFloat = height {
            finalOrigin = CGPoint(x: inset, y: unwrappedYOrigin)
            finalSize = CGSize(width: self.bounds.width - inset, height: unwrappedHeight)
        } else {
            finalOrigin = CGPoint(x: inset, y: self.bounds.height - UIView.separatorHeight)
            finalSize = CGSize(width: self.bounds.width - inset, height: UIView.separatorHeight)
        }
        result = CGRect(origin: finalOrigin, size: finalSize)
        
        return result
    }
    
    /**
     Resigns the first responder of a view withing the heirarchy of a given view
     - returns:              The view that was the first responder
     */
    @discardableResult public func resignSubviewFirstResponder() -> UIView? {
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
    
    @discardableResult public func createShadow(xOffset: CGFloat, yOffset: CGFloat, radius: CGFloat, color: UIColor) -> CALayer {
        let shadowLayer: CALayer = CALayer()
        shadowLayer.cornerRadius = self.layer.cornerRadius
        shadowLayer.backgroundColor = UIColor.white.cgColor
        shadowLayer.frame = self.layer.bounds
        shadowLayer.shadowOffset = CGSize(width: xOffset, height: yOffset)
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowRadius = radius
        shadowLayer.shadowOpacity = 1
        self.layer.insertSublayer(shadowLayer, at: 0)
        return shadowLayer
    }
}

extension UILayoutPriority {
    
    public static var zero: UILayoutPriority {
        return UILayoutPriority(rawValue: 0)
    }
    
    public static var almostRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 999)
    }
}

extension UICollectionView {
    
    public func registerCellClasses<T>(_ classes: [T.Type]) where T: UICollectionViewCell {
        classes.forEach {
            let identifier: String = $0.reuseIdentifier
            self.register($0.self, forCellWithReuseIdentifier: identifier)
        }
    }
    
    public func registerCellNibs<T>(_ classes: [T.Type]) where T: UICollectionViewCell {
        classes.forEach {
            let name: String = $0.reuseIdentifier
            let nib: UINib = UINib(nibName: name, bundle: Bundle(for: $0))
            self.register(nib, forCellWithReuseIdentifier: name)
        }
    }
    
    public func registerReusableHeaderViewClasses<T>(_ classes: [T.Type]) where T: UICollectionReusableView {
        classes.forEach {
            let identifier: String = $0.reuseIdentifier
            self.register($0.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
        }
    }
    
    public func registerReusableFooterViewClasses<T>(_ classes: [T.Type]) where T: UICollectionReusableView {
        classes.forEach {
            let identifier: String = $0.reuseIdentifier
            self.register($0.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier)
        }
    }
    
    public func scrollToLastItem(in section: Int, animated: Bool? = false) {
        let rowCount: Int = self.numberOfItems(inSection: section)
        guard rowCount > 0 else { return }
        let path: IndexPath = IndexPath(item: rowCount - 1, section: section)
        self.scrollToItem(at: path, at: .bottom, animated: animated!)
    }
    
    public func scrollToLastItem(animated: Bool? = true) {
        let sectionCount: Int = self.numberOfSections
        self.scrollToLastItem(in: sectionCount - 1)
    }
    
}

extension UITableView {
    
    public func registerCellClasses<T: UITableViewCell>(_ classes: [T.Type]) {
        classes.forEach {
            let identifier = $0.reuseIdentifier
            self.register($0.self, forCellReuseIdentifier: identifier)
        }
    }
    
    public func registerCellNibs<T: UITableViewCell>(_ classes: [T.Type]) {
        classes.forEach {
            let name = $0.reuseIdentifier
            let nib = UINib(nibName: name, bundle: Bundle(for: $0))
            self.register(nib, forCellReuseIdentifier: name)
        }
    }
    
    public func registerHeaderFooterNibs<T: UITableViewHeaderFooterView>(_ classes: [T.Type]) {
        classes.forEach {
            let bundle: Bundle = Bundle(for: $0)
            let nib: UINib = UINib(nibName: $0.reuseIdentifier, bundle: bundle)
            self.register(nib, forHeaderFooterViewReuseIdentifier: $0.reuseIdentifier)
        }
    }
    
    public func registerHeaderFooterClasses<T: UITableViewHeaderFooterView>(_ classes: [T.Type]) {
        classes.forEach {
            self.register($0, forHeaderFooterViewReuseIdentifier: $0.reuseIdentifier)
        }
    }
    
    public func scrollToLastRow(in section: Int, animated: Bool? = false) {
        let rowCount: Int = self.numberOfRows(inSection: section)
        guard rowCount > 0 else { return }
        let path: IndexPath = IndexPath(item: rowCount - 1, section: section)
        self.scrollToRow(at: path, at: .bottom, animated: animated!)
    }
    
    public func scrollToLastRow(animated: Bool? = true) {
        let sectionCount: Int = self.numberOfSections
        self.scrollToLastRow(in: sectionCount - 1)
    }
}

extension UIColor {
    
    private static let denominator: CGFloat = 255.0
    
    public static let defaultViewTintColor: UIColor = UIColor(redValue: 0, greenValue: 122, blueValue: 255)
    
    public convenience init(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat = 1.0) {
        let redValue: CGFloat = redValue / UIColor.denominator
        let greenValue: CGFloat = greenValue / UIColor.denominator
        let blueValue: CGFloat = blueValue / UIColor.denominator
        if #available(iOS 10.0, *) {
            self.init(displayP3Red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
        } else {
            self.init(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
        }
    }
    
    public convenience init(rgb: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: rgb, green: rgb, blue: rgb, alpha: alpha)
    }
}

extension UITextField {
    
    public func setPlaceholder(_ text: String, color: UIColor) {
        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: color
        ]
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: attrs)
    }
    
}

extension UIViewController {
    
    public class func loadFromNib<T>() -> T where T: UIViewController {
        return T(nibName: T.reuseIdentifier, bundle: .none)
    }
    
    public func addChild(viewController: UIViewController, viewFrame: CGRect? = .none) {
        viewController.willMove(toParent: self)
        self.addChild(viewController)
        if let newFrame = viewFrame {
            viewController.view.frame = newFrame
        } else {
            viewController.view.frame = CGRect.zero
        }
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    public func addChild(viewController: UIViewController, constraints: () -> [NSLayoutConstraint]) {
        viewController.willMove(toParent: self)
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints())
        viewController.didMove(toParent: self)
    }
    
    public func removeChild(viewController: UIViewController) {
        viewController.willMove(toParent: .none)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    public func removeAllChildren() {
        for child in self.children {
            child.willMove(toParent: .none)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    public func childOfType<T: UIViewController>(_ viewControllerType: T.Type) -> T? {
        let result = self.children.filter({ child in
            switch child {
            case let navController as UINavigationController where viewControllerType is UINavigationController.Type == false:
                return navController.viewControllers.filter({ $0 is T }).count > 0
            case _ as T:
                return true
            default:
                return false
            }
        }).first
        if result is UINavigationController, viewControllerType is UINavigationController.Type == false {
            return (result as! UINavigationController).viewControllers.filter({ $0 is T }).first as? T
        } else {
            return result as? T
        }
    }
}

extension UIStackView {
    
    public func removeAllArrangedSubviews() {
        for view in self.arrangedSubviews {
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}

extension UISearchBar {
    
    public var textField: UITextField? {
        return self.value(forKey: "searchField") as? UITextField
    }
}

extension UINavigationController {
    
    public static func rootViewController(_ rootViewController: UIViewController, prefersLargeTitles: Bool = false) -> UINavigationController {
        let navigationController: UINavigationController = UINavigationController(rootViewController: rootViewController)
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = prefersLargeTitles
        }
        return navigationController
    }
}

extension UIEdgeInsets {
    
    public static func withValue(_ value: CGFloat) -> UIEdgeInsets {
        return self.init(top: value, left: value, bottom: value, right: value)
    }
    
    public static func withPriority(_ priority: UILayoutPriority) -> UIEdgeInsets {
        return self.withValue(CGFloat(priority.rawValue))
    }
    
    public init(topPriority: UILayoutPriority, leftPriority: UILayoutPriority, bottomPriority: UILayoutPriority, rightPriority: UILayoutPriority) {
        self.init(top: CGFloat(topPriority.rawValue), left: CGFloat(leftPriority.rawValue), bottom: CGFloat(bottomPriority.rawValue), right: CGFloat(rightPriority.rawValue))
    }
    
    public var size: CGSize {
        return CGSize(
            width: self.left + self.right,
            height: self.top + self.bottom
        )
    }
}

public final class SizeableNavigationBar: UINavigationBar {
    
    private let customHeight: CGFloat
    private let contentOffset: CGFloat
    
    public init(customHeight: CGFloat, contentOffset: CGFloat) {
        self.customHeight = customHeight
        self.contentOffset = contentOffset
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        var result: CGSize = super.sizeThatFits(size)
        result.height = self.customHeight
        return result
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in self.subviews {
            if NSStringFromClass(type(of: subview)).contains("BarBackground") {
                var subviewFrame: CGRect = subview.frame
                subviewFrame.origin.y = 0
                subviewFrame.size.height = self.customHeight
                subview.frame = subviewFrame
            } else if NSStringFromClass(type(of: subview)).contains("BarContentView") {
                var subviewFrame: CGRect = subview.frame
                subviewFrame.origin.y = self.contentOffset
                subviewFrame.size.height = self.customHeight - subviewFrame.origin.y
                subview.frame = subviewFrame
            }
        }
    }
}

extension UIColor {
    
    public convenience init?(hexString: String) {
        var red: CGFloat   = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat  = 0.0
        var alpha: CGFloat = 1.0
        
        let startIndex: String.Index = hexString.index(after: hexString.startIndex)
        let trimmedString: String = String(hexString[startIndex..<hexString.endIndex])
        let scanner = Scanner(string: trimmedString)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (trimmedString.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                // Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8
                return nil
            }
        } else {
            // "Scan hex error
            return nil
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UILabel {
    
    public static func autolayoutLabel(with style: UIFont.TextStyle) -> UILabel {
        let label: UILabel = UILabel.autolayoutView()
        label.font = UIFont.preferredFont(forTextStyle: style)
        if #available(iOS 10.0, *) {
            label.adjustsFontForContentSizeCategory = true
        }
        return label
    }
    
    public convenience init(textStyle: UIFont.TextStyle) {
        self.init(frame: .zero)
        self.font = UIFont.preferredFont(forTextStyle: textStyle)
        if #available(iOS 10.0, *) {
            self.adjustsFontForContentSizeCategory = true
        }
    }
}

extension UIViewController {
    
    public func showAlert(title: String, message: String) {
        let alertController: UIAlertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let action: UIAlertAction = UIAlertAction(
            title: NSLocalizedString("OK", comment: ""),
            style: .default) { [weak alertController] _ in
                alertController?.dismiss(animated: true, completion: .none)
        }
        alertController.addAction(action)
        self.present(
            alertController,
            animated: true,
            completion: .none
        )
    }
    
    public func showAlert(title: String, error: NSError) {
        self.showAlert(title: title, message: error.localizedDescription)
    }
}

extension UIResponder {
    
    public func sendAction(_ selector: Selector) {
        UIApplication.shared.sendAction(selector, to: .none, from: self, for: .none)
    }
}


