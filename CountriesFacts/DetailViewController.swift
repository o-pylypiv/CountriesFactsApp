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
    var detailItem: Country?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(shareTapped))
        
        title = detailItem?.name
        guard let detailItem = detailItem else {return}
        let html = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style>
                body {font-size: 150%;}
            </style>
        </head>
        <body>
            <b>Capital:</b> \(detailItem.capital)<br>
            <b>Population:</b> \(detailItem.population)<br>
            <b>Currency:</b> \(detailItem.currency)<br>
            \(detailItem.shortDescription)
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    @objc func shareTapped() {
        if let detailItem = detailItem {
            let vc = UIActivityViewController(activityItems: [detailItem.name, detailItem.capital, detailItem.population, detailItem.currency, detailItem.shortDescription], applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true)
        }
    }
}
