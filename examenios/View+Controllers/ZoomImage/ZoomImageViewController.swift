//
//  ZoomImageViewController.swift
//  examenios
//
//  Created by Ricardo Granja Chávez on 09/04/22.
//

import UIKit

class ZoomImageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    private var imageContent: UIImage!

    required convenience init(image: UIImage) {
        self.init()
        self.imageContent = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Selfie"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped(_:)))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imageView.image = self.imageContent
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.delegate = self
    }
    
    @objc func doubleTapped(_ sender: UITapGestureRecognizer) {
        let zoomScale = scrollView.zoomScale
        scrollView.setZoomScale(zoomScale == 1.0 ? 2.5 : 1.0, animated: true)
    }
}

extension ZoomImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { imageView }
}
