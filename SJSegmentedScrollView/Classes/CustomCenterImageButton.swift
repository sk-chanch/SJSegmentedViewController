//
//  CustomButton.swift
//  AppStarterKit
//
//  Created by Chanchana Koedtho on 9/4/2564 BE.
//  Copyright © 2564 BE megazy. All rights reserved.
//

import Foundation
import UIKit

public protocol CustomButtonCenter:AnyObject{
    var imageSize:CGSize { get set }
    var insetTop:CGFloat { get set }
    var selectedBackgroundColor:UIColor? { get set }
}



final class CustomCenterImageButton: UIButton, CustomButtonCenter {
    
    @IBInspectable var imageSize:CGSize = .init(width: 20, height: 20){
        didSet{
            layoutSubviews()
            
            
        }
    }
    
    @IBInspectable var insetTop:CGFloat = 0 {
        didSet{
            layoutSubviews()
        }
    }
    
    override var isSelected: Bool{
        didSet{
            
            if isSelected{
                viewBackground.backgroundColor = selectedBackgroundColor
            }else{
                viewBackground.backgroundColor = .clear
            }
            
            
            UIView.animate(withDuration: 0.3){[weak self] in
                self?.viewBackground.alpha = self?.isSelected ?? false ? 1:0
            }
        }
    }
    
    var selectedBackgroundColor:UIColor? = nil
    
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let superRect = super.titleRect(forContentRect: contentRect)
        return CGRect(
            x: 0,
            y: contentRect.height - superRect.height,
            width: contentRect.width,
            height: superRect.height
        )
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        return CGRect(
            x: contentRect.width / 2 - imageSize.width / 2,
            y: (contentRect.height - titleRect(forContentRect: contentRect).height) / 2 - imageSize.height / 2 + insetTop,
            width: imageSize.width,
            height: imageSize.height
        )
    }
    
    override var intrinsicContentSize: CGSize {
        _ = super.intrinsicContentSize
        let size = titleLabel?.sizeThatFits(contentRect(forBounds: bounds).size) ?? .zero
        let spacing: CGFloat = 12
        return CGSize(width: max(size.width, imageSize.width), height: imageSize.height + size.height + spacing)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        viewBackground.frame = .init(x: 0,
                                     y: 0,
                                     width: imageSize.width * 2,
                                     height: imageSize.height * 2)
        viewBackground.center = imageView?.center ?? .zero
        
        viewBackground.layer.cornerRadius = viewBackground.bounds.height / 2
    }
    
    private lazy var viewBackground:UIView = {
        let _v = UIView()
        _v.isUserInteractionEnabled = false
        _v.backgroundColor = selectedBackgroundColor
        return _v
    }()
    
    private func setup() {
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .scaleAspectFit
        
        if let imageView = self.imageView{
            insertSubview(viewBackground, belowSubview: imageView)
        }
        
    }
    
    
}
