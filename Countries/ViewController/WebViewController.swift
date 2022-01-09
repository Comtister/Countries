//
//  WebViewController.swift
//  Countries
//
//  Created by Oguzhan Ozturk on 9.01.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var coordinator : WebViewCoordinator
    private var pageUrl : String
    private var webView : WKWebView!
    
    required init?(coder: NSCoder , coordinator : WebViewCoordinator , pageUrl : String) {
        self.pageUrl = pageUrl
        self.coordinator = coordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pageURL = URL(string: "https://www.wikidata.org/wiki/\(pageUrl)")
        let request = URLRequest(url: pageURL!)
        webView.load(request)
        
    }
    

    
}
