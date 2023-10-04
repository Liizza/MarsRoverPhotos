//
//  PickerViewController.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import UIKit
import RxSwift

class PickerViewController: UIViewController, Storyboarded {
    var viewModel: (any PickerViewModelProtocol)?
    private let disposeBag = DisposeBag()

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var popUpView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .layerOne.withAlphaComponent(0.4)
        popUpView.backgroundColor = .backgroundOne
        popUpView.roundCorners(corners: [.topLeft, .topRight], radius: 50)

        guard let viewModel else { return }
        
        viewModel.items.drive(pickerView.rx.itemTitles) { row, item in
            return item
        }.disposed(by: disposeBag)
        bind()
        
    }
    func bind() {
        cancelButton.rx.tap.asObservable().subscribe({ [weak self] _ in
            self?.dismiss()
        }).disposed(by: disposeBag)
        chooseButton.rx.tap.asObservable().bind(onNext: { [weak self] in
            guard let self else { return }
            self.viewModel?.chooseButtonPressed.asObserver().onNext(())
            self.dismiss()
        }).disposed(by: disposeBag)
        pickerView.rx.itemSelected.subscribe(onNext: {[weak self] (row,component) in
            guard let self else { return }
            self.viewModel?.itemSelected.asObserver().onNext(row)
        }).disposed(by: disposeBag)
    }
    func addShowAnimation() {
        self.view.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.2) { [weak self] in
            self?.view.alpha = 1
        }
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
