# UIKitHelpers

This framework is just an extension on UIView that makes my day easier. 

## Requirements

This is written in Swift 4, works with macOS, iOS, watchOS, and tvOS.

## Installation

You can install this library with Carthage, or Swift's package manager

### Carthage

Add this line to you `Cartfile`:

    github "Chandlerdea/UIKitHelpers"
    
Run `carthage update` and then add the created framework in `$(SRCROOT)/Carthage/build/iOS` to the Embedded Binaries section of you project.

### Cocopods

I'm having trouble linting the cocoapod, so cocoapods support isn't available just yet. I'll be adding it as soon as I figure out the issue.

### Swift Package Manager

In your Packages.swift file, add this code

    import PackageDescription

    let package = Package(
        url: "https://github.com/Chandlerdea/UIKitHelpers/UIKitHelpers.swift"
        majorVersion: 1
    )
    

## How to use

There is also a protocol `ReusableViewType` which looks like this:

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

`UITableViewCell`, `UICollectionViewCell`, `UITableViewHeaderFooterView`, and `UICollectionReusableView` all conform to this protocol. I mostly use this with registering cells, so I can register cells with string representations of their name, like this:

    tableView.register(SomeCell.self, forCellReuseIdentifier: SomeCell.reuseIdentifier)


The extension on `UIView` has some convenient methods for common `UIKit` usecases. For example:
* The ability to create constraints with a priority, without having to create and modify the constraint, in a familiar API that looks like the existing auto layout api. Here are a few examples: 
  * `constraint(equalTo anchor: NSLayoutDimension, constant: CGFloat, priority: CGFloat) -> NSLayoutConstraint`
  * `constraint(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: CGFloat) -> NSLayoutConstraint`
  * `constraint(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: CGFloat) -> NSLayoutConstraint`
* An easy, type safe way to load a class from a nib with `class func loadFromNib<T: UIView>() -> T`
* An easy way to pin a view to all sides of its superview, with optional padding and priorities for the constraints: `activateAllSideAnchors(relativeToMargins: Bool! = false, padding: UIEdgeInsets! = nil, priorities: UIEdgeInsets! = nil)`

There are a few others for small things like finding subviews, andding more than one subview at once, and other stuff. They are small solutions to ways I have found Apple's APIs to be slightly lacking, or things that I have found myself having to do a lot across projects. If you have any critiques or enhancements you think could make this better, please open a PR. I would love to what others have come up with!
