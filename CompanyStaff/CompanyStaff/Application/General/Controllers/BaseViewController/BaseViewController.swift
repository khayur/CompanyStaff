//
//  BaseViewController.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

class BaseViewController: UIViewController {
    
//MARK: - Properties
    var loadingView: LoadingView!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait]
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createLoadingView()
        modalPresentationStyle = .fullScreen
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: -HelperMethods
    func createLoadingView() {
        loadingView = LoadingView.instantiate()
        loadingView.layer.zPosition = 2
        loadingView.frame = view.bounds
        view.addSubview(loadingView)
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    /// Creates an overlay view which will restrict user iteraction with view controller's contens while subview existing
    /// - Returns: Overlay view of UIView type.
    func getOverlayView() -> UIView {
        let overlayView = UIView()
        overlayView.frame = view.bounds
        overlayView.tag = Constants.tagForOverlayView
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        return overlayView
    }
    
    func showLoading() {
        loadingView.start()
    }
    
    func hideLoading() {
        loadingView.finish()
    }
}
