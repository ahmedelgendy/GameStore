//
//  WebViewController.swift
//  GamesApp
//
//  Created by Elgendy on 13.02.2020.
//  Copyright © 2020 Elgendy. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var htmlContent: String
    
    init(htmlContent: String!) {
        self.htmlContent = htmlContent
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        // the meta is important for mobile scaling (responsiveness)
        let meta = "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\">"
        let htmlStart = "<HTML><HEAD>\(meta)</HEAD><BODY>"
        let htmlEnd = "</BODY></HTML>"
        let htmlString = "\(htmlStart)\(String(describing: htmlContent))\(htmlEnd)"
        
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func dismissView() {
        self.dismiss(animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
    }
    

}
