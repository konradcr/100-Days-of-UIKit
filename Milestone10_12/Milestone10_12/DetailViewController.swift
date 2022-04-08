//
//  DetailViewController.swift
//  Milestone10_12
//
//  Created by Konrad Cureau on 08/04/2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImageURL: URL?
    var selectedCaption: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedCaption
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImageURL {
            imageView.image = UIImage(contentsOfFile: imageToLoad.path)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
