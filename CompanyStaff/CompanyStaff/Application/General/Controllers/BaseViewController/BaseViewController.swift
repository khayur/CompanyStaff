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
    
    func showLoading() {
        loadingView.start()
    }
    
    func hideLoading() {
        loadingView.finish()
    }
}
