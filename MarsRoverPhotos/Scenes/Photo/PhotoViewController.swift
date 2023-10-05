//
//  PhotoViewController.swift
//  MarsRoverPhotos
//
//  Created by Liza on 05.10.2023.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController, Storyboarded {
    var viewModel: PhotoViewModelProtocol?
    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    func setUpUI() {
        photoImageView.kf.setImage(with: viewModel?.imageURL)
    }

}
