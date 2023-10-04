//
//  HistoryTableViewCell.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    var viewModel: HistoryCellViewModelProtocol?
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var roverLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with viewModel: HistoryCellViewModelProtocol) {
        self.viewModel = viewModel
        updateData()
    }
    func setUpUI() {
        titleLabel.textColor = .accentOne
        titleLabel.font = .titleTwoFont
        shadowView.layer.cornerRadius = 30
        shadowView.addShadow(width: 0, height: 3, color: .shadowColor(alpha: 0.08), radius: 16)
    }
    func updateData() {
        guard let viewModel else { return }
        roverLabel.attributedText = viewModel.roverText
        cameraLabel.attributedText = viewModel.cameraText
        dateLabel.attributedText = viewModel.dateText
    }
    
}
