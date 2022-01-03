//
//  LoadingView.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

class LoadingView: BaseView {
    
    //MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    //MARK: -Properties
    var isAnimating: Bool = false
    
    //MARK: -Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.applyShadow(corner: 4.0)
        alpha = 0.0
    }
    
    //MARK: -Methods
    func start() {
        guard !isAnimating else { return }
        
        isAnimating = true
        indicator.startAnimating()
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.alpha = 1.0
        })
    }
    
    func finish() {
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            self.alpha = 0.0
        }, completion: {finished in
            self.indicator.stopAnimating()
            self.isAnimating = false
        })
    }
    
}
