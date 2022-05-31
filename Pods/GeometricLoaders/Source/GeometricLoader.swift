//
//  GeometricLoader.swift
//  GeometricLoaders
//
//  Created by Pablo Garcia on 16/10/2017.
//  Copyright © 2017 Pablo Garcia. All rights reserved.
//

import UIKit

public class GeometricLoader: UIView {
    
    internal var loaderView = UIView()
    internal var loaderSuperview: UIView?
    internal var isAnimating = false
    
    public static func createGeometricLoader(mainview : UIView) -> Self {
        
        let loader = self.init()
        loader.setupView(view: mainview)
        
        return loader
    }
    
    internal func configureLoader() {
        preconditionFailure("This method has to be called from GeometricLoader subclass")
    }
 
    open func startAnimation() {
        
        self.configureLoader()
        isHidden = false
        if superview == nil {
            loaderSuperview?.addSubview(self)
        }
    }
    open func stopAnimation() {
        
        self.isHidden = false
        self.isAnimating = false
        self.removeFromSuperview()
        self.layer.removeAllAnimations()
        
    }
    
    internal func setupView(view : UIView) {
        
//        guard let window = UIApplication.shared.delegate?.window else { return }
//        guard let mainWindow = window else {return}
        
        self.frame = view.frame
        self.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        view.addSubview(self)
        
        self.loaderSuperview = view
        self.loaderView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width/2, height: frame.width/2)
        self.loaderView.center = CGPoint(x: frame.width/2, y: frame.height/2)
        self.loaderView.backgroundColor = UIColor.clear
        self.isHidden = true
        self.addSubview(loaderView)
        
    }
    
}
