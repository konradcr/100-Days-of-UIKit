//
//  DetailViewController.swift
//  Milestone1_3
//
//  Created by Konrad Cureau on 05/04/2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var flagPicture: UIImageView!
    var selectedImage: String?
    var selectedImageTitle: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = selectedImage {
            flagPicture.image = UIImage(named: imageToLoad)
        }
        
        title = selectedImageTitle
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = flagPicture.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        guard let imageName = selectedImageTitle else {
            print("No image name found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, imageName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
