# UIView-helpers

This is an extension on UIView that makes my day easier. The extension includes:

* The ability to create constraints with a priority, without having to create and modify the constraint, in a familiar API that looks like the existing auto layout api. Here are a few examples: 
  * `constraint(equalTo anchor: NSLayoutDimension, constant: CGFloat, priority: CGFloat) -> NSLayoutConstraint`
  * `constraint(equalTo anchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: CGFloat) -> NSLayoutConstraint`
  * `constraint(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: CGFloat) -> NSLayoutConstraint`
* An easy, type safe way to load a class from a nib with `class func loadFromNib<T: UIView>() -> T`
* An easy way to pin a view to all sides of its superview, with optional padding and priorities for the constraints: `activateAllSideAnchors(relativeToMargins: Bool! = false, padding: UIEdgeInsets! = nil, priorities: UIEdgeInsets! = nil)`

There are a few others for small things like finding subviews, andding more than one subview at once, and other stuff. They are small solutions to ways I have found Apple's APIs to be slightly lacking, or things that I have found myself having to do a lot across projects. If you have any critiques or enhancements you think could make this better, please open a PR. I would love to what others have come up with!
