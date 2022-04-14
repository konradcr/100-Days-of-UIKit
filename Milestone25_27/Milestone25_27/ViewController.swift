//
//  ViewController.swift
//  Milestone25_27
//
//  Created by Konrad Cureau on 14/04/2022.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    
    var image: UIImage?
    var firstString: String?
    var secondString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Meme Generator"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        self.image = image
        imageView.image = self.image
        
        promptText()
    }
    
    func promptText() {
        let ac = UIAlertController(title: "Enter text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let firstAnswer = ac?.textFields?[0].text else { return }
            guard let secondAnswer = ac?.textFields?[1].text else { return }
            self?.firstString = firstAnswer
            self?.secondString = secondAnswer
            self?.drawTextOnImage()
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func drawTextOnImage() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 300, height: 300))
        
        let image = renderer.image { ctx in
            self.image?.draw(in: CGRect(x: 0, y: 0, width: 300, height: 300))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 24),
                .paragraphStyle: paragraphStyle,
                .backgroundColor: UIColor.white
            ]
            
            if let firstString = firstString {
                let attributedStringTop = NSAttributedString(string: firstString, attributes: attrs)
                attributedStringTop.draw(with: CGRect(x: 20, y: 20, width: 260, height: 260), options: .usesLineFragmentOrigin, context: nil)
            }
            
            if let secondString = secondString {
                let attributedStringBottom = NSAttributedString(string: secondString, attributes: attrs)
                attributedStringBottom.draw(with: CGRect(x: 20, y: 240, width: 260, height: 260), options: .usesLineFragmentOrigin, context: nil)
            }
        }
        
        imageView.image = image
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}

