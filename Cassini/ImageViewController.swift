//
//  ImageViewController.swift
//  Cassini
//
//  Created by Lasse Silkoset on 15.12.2017.
//  Copyright © 2017 Lasse Silkoset. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var imageURL: URL? {
        didSet {
            //check if i am currently on screen. In case i click on another tab, in a reusable situation.
            if view.window != nil {
            fetchImage()
        }
    }
}
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private func fetchImage() {
        if let url = imageURL {
            spinner.startAnimating()
            //Creates a memory cycle, weak self protects us from that. if the view is off screen, it gets deallocated from the heap, and this will be set to nil.
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                //if we press back, and the captured url does not equal the self?.imageURL, the rest does not get executed
                if let imageData = urlContents, url == self?.imageURL {
                    //putting it on the main queue, because all UI stuff have to be done there
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
   
    //using viewWillAppaer so that this controller is reusable. If viewDidLoad, it would be bad for, a tab bar controller for example.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if image == nil {
            fetchImage()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    //Creating imageView programaticlly
    //made fileprivate so the extension can "see" this imageview, but not other files
    fileprivate var imageView = UIImageView()
    
    //Making it an optional so that the UI is able to not show a image at some point
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            // careful here becaue scrollview might be nil
            // for example if we are setting our image as part of a prepare
            // so use optional chaining to do nothing
            // if our scrollview outlet has not yet been set
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
}
    
    extension ImageViewController : UIScrollViewDelegate {
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return imageView
        }
    }
    

