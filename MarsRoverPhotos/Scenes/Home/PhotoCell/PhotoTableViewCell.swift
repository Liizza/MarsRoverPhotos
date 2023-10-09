//
//  PhotoTableViewCell.swift
//  MarsRoverPhotos
//
//  Created by Liza on 02.10.2023.
//

import UIKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {
    private var viewModel: PhotoCellModelProtocol? 
    @IBOutlet weak var roverLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel: PhotoCellModelProtocol) {
        self.viewModel = viewModel
        updateData()
    }
    func setUpUI() {
        photoImageView.layer.cornerRadius = 20
        photoImageView.contentMode = .scaleAspectFill
        shadowView.layer.cornerRadius = 30
        shadowView.addShadow(width: 0, height: 3, color: .shadowColor(alpha: 0.08), radius: 16)
    }
    func updateData() {
        guard let viewModel else { return }
        roverLabel.attributedText = viewModel.roverText
        cameraLabel.attributedText = viewModel.cameraText
        dateLabel.attributedText = viewModel.dateText
        photoImageView.kf.indicatorType = .activity
        photoImageView.kf.setImage(with: viewModel.imageURL)
    }
}
