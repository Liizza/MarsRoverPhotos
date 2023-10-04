//
//  SaveFiltersViewController.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import UIKit
import RxSwift

class SaveFiltersViewController: UIViewController, Storyboarded {
    var viewModel: SaveFiltersViewModelProtocol?
    let disposeBag = DisposeBag()
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .layerOne.withAlphaComponent(0.4)
        addShowAnimation()
        setUpUI()
        bind()
    }
    func setUpUI() {
        alertView.layer.cornerRadius = 30
        saveButton.layer.borderColor = UIColor.layerTwo.cgColor
        saveButton.layer.borderWidth = 0.3
        titleLabel.text = "Save Filters"
        descriptionLabel.text = "The current filters and the date you have chosen can be saved to the filter history."
    }
    func addShowAnimation() {
        self.view.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.2) { [weak self] in
            self?.view.alpha = 1
        }
    }
    func bind() {
        guard let viewModel else { return }
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        cancelButton.rx.tap.asObservable().subscribe(onNext: { [weak self] in
            self?.dismiss()
        }).disposed(by: disposeBag)
        saveButton.rx.tap.asObservable().subscribe(onNext: { event in
            self.dismiss()
            viewModel.didSaveFilters.asObserver().onNext(event)
        }).disposed(by: disposeBag)
    }
    func dismiss() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.view.alpha = 0.0
       }) { [weak self] _ in
           self?.dismiss(animated: false)
           self?.removeFromParent()
       }
    }

}
