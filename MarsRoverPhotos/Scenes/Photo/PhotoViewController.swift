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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .black
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barStyle = .default
    }
    func setUpUI() {
        let backItem = UIBarButtonItem(image: UIImage(named: "cancel"), style: .plain, target: self, action: #selector(goBack))
        backItem.tintColor = .backgroundOne
        self.navigationItem.leftBarButtonItem = backItem
        photoImageView.kf.setImage(with: viewModel?.imageURL)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }

}
