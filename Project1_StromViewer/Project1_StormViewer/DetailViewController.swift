//
//  DetailViewController.swift
//  Project1_StormViewer
//
//  Created by Konrad Cureau on 04/04/2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedImageIndex: Int?
    var picturesCount: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
        assert(selectedImage != nil, "The selected image shouldn't be nil.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(selectedImageIndex!) of \(picturesCount!)"
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
