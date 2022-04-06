//
//  ViewController.swift
//  Project4_EasyBrowser
//
//  Created by Konrad Cureau on 05/04/2022.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        let url = URL(string: "https://" + actionTitle)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        let appareance = UINavigationBarAppearance()
        appareance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = appareance
        navigationController?.navigationBar.scrollEdgeAppearance = appareance
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        let previous = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: webView, action: #selector(webView.goBack))
        let next = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"), style: .plain, target: webView, action: #selector(webView.goForward))
        previous.isEnabled = webView.canGoBack
        next.isEnabled = webView.canGoForward
        
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [previous, spacer, next, spacer, progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        var isAllowed = false
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    isAllowed = true
                    return
                }
            }
            if !isAllowed {
                let ac = UIAlertController(title: "Oops...", message: "You're not allowed to access this page.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default))
                present(ac, animated: true)
            }
        }
        
        decisionHandler(.cancel)
    }
}

