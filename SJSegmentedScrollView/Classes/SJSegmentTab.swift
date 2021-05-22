//
//  SJSegmentTab.swift
//  Pods
//
//  Created by Subins on 22/11/16.
//  Copyright © 2016 Subins Jose. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//    associated documentation files (the "Software"), to deal in the Software without restriction,
//    including without limitation the rights to use, copy, modify, merge, publish, distribute,
//    sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//    substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Foundation

typealias DidSelectSegmentAtIndex = (_ segment: SJSegmentTab?,_ index: Int,_ animated: Bool) -> Void

public protocol ImageSegmentTabProtocol:AnyObject {
    func configuration() -> SegmentTabConfig
}

public struct SegmentTabConfig {
    
    
    var imageTab:UIImage
    var imageSize:CGSize
    var color:UIColor
    var contentInset:UIEdgeInsets
    
    public init(imageTab: UIImage,
         imageSize: CGSize = .init(width: 20, height: 20),
         color: UIColor,
         contentInset: UIEdgeInsets =  .init(top: 2,
                                             left: 0,
                                             bottom: 2,
                                             right: 0)) {
        self.imageTab = imageTab
        self.imageSize = imageSize
        self.color = color
        self.contentInset = contentInset
    }
}

class ButtomDefault: UIButton, CustomButtonCenter {
    var imageSize: CGSize  = .zero
    
    var insetTop: CGFloat = .zero
    
    var selectedBackgroundColor: UIColor? = nil
    
    
}


open class SJSegmentTab: UIView {

	let kSegmentViewTagOffset = 100
	let button = UIButton(type: .custom)

	var didSelectSegmentAtIndex: DidSelectSegmentAtIndex?
	var isSelected = false {
		didSet {
			button.isSelected = isSelected
		}
	}
    
    private lazy var defaultButton:ButtonCenter = {
        let _btn = ButtomDefault(type: .custom)
        return _btn
    }()
    
    private lazy var customButton:CustomCenterImageButton = {
        let _btn = CustomCenterImageButton(type: .custom)
        return _btn
    }()

	convenience init(title: String) {
		self.init(frame: CGRect.zero)
        setTitle(title)
	}

	convenience init(view: UIView) {
		self.init(frame: CGRect.zero)

		insertSubview(view, at: 0)
		view.removeConstraints(view.constraints)
		addConstraintsToView(view)
	}
    
    convenience init(title: String,
                     imageST:ImageSegmentTabProtocol & UIViewController) {
        self.init(frame: CGRect.zero, isCustomButton: true)
        setTitle(title)
        
        
        let imageST = imageST.configuration()
        button.contentEdgeInsets = imageST.contentInset
        button.setImage(imageST.imageTab,
                        for: .normal)
        button.tintColor = imageST.color
        button.imageSize = imageST.imageSize
        button.selectedBackgroundColor = imageST.color
    }

    required  public init(frame: CGRect, isCustomButton:Bool = false) {
        super.init(frame: frame)

        if isCustomButton{
            button = customButton
        }else{
            button = defaultButton
        }

		translatesAutoresizingMaskIntoConstraints = false
		button.frame = bounds
		button.addTarget(self, action: #selector(SJSegmentTab.onSegmentButtonPress(_:)),
		                 for: .touchUpInside)
		addSubview(button)
		addConstraintsToView(button)
	}

	func addConstraintsToView(_ view: UIView) {

		view.translatesAutoresizingMaskIntoConstraints = false
		let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
		                                                         options: [],
		                                                         metrics: nil,
		                                                         views: ["view": view])
		let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
		                                                           options: [],
		                                                           metrics: nil,
		                                                           views: ["view": view])
		addConstraints(verticalConstraints)
		addConstraints(horizontalConstraints)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    open func setTitle(_ title: String) {
        
        button.setTitle(title, for: .normal)
    }

	open func titleColor(_ color: UIColor) {

		button.setTitleColor(color, for: .normal)
	}
    
    open func selectedTitleColor(_ color: UIColor?) {
        
        button.setTitleColor(color, for: .selected)
    }

	open func titleFont(_ font: UIFont) {

		button.titleLabel?.font = font
	}

	@objc func onSegmentButtonPress(_ sender: AnyObject) {
		let index = tag - kSegmentViewTagOffset
		NotificationCenter.default.post(name: Notification.Name(rawValue: "DidChangeSegmentIndex"),
		                                object: index)
        didSelectSegmentAtIndex?(self, index, true)
	}
}
