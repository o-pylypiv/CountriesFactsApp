//
//  DetailViewController.swift
//  CountriesFacts
//
//  Created by Olha Pylypiv on 12.04.2024.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    //var detailItem: Country?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
