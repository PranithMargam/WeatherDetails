//
//  HelpViewController.swift
//  WeatherDetails
//
//  Created by Pranith Margam on 01/05/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
        
    private func setUpUI() {
        let webView = WKWebView()
        self.view.backgroundColor = .systemGray
        self.view.addSubview(webView)
        webView.fillToSuperView()
        loadData(into: webView)
    }
    
    private func loadData(into webView: WKWebView) {
        let docURL = Bundle.main.url(forResource: "Help", withExtension: "doc")!
        let docContents = try! Data(contentsOf: docURL)
        let urlStr = "data:application/msword;base64," + docContents.base64EncodedString()
        let url = URL(string: urlStr)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
