//
//  WebViewController.swift
//  Services
//
//  Created by Alexandr Onischenko on 30.03.2024.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController {
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        view.uiDelegate = self
        view.navigationDelegate = self
        view.allowsLinkPreview = true
        view.allowsBackForwardNavigationGestures = true
        return view
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()

    private var request: URLRequest

    init(request: URLRequest) {
        self.request = request
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        webView.load(request)
    }

    private func configureView() {
        view = webView
        webView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
