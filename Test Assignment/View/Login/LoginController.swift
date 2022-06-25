//
//  ViewController.swift
//  Test Assignment
//
//  Created by Ahmed Serdah on 24/06/2022.
//

import UIKit
import RxCocoa
import RxSwift

class LoginController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var searchViewModel: SearchViewModel = .shared
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTextFieldsToViewModel()
        subscribeToLoading()
        subscribeIsLoginEnabled()
        subscribeToLoginButton()
        
    }
    
    
    func bindTextFieldsToViewModel() {
        loginTextField.rx.text.orEmpty.bind(to: searchViewModel.loginBehavior).disposed(by: disposeBag)
    }
    
    func subscribeToLoading() {
        searchViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator()
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    
    func subscribeIsLoginEnabled() {
        searchViewModel.isSubmitButtonEnapled.bind(to: submitButton.rx.isEnabled).disposed(by: disposeBag)
    }
    func subscribeToLoginButton() {
        submitButton.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                if let vc = UIStoryboard(name: "Result", bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }).disposed(by: disposeBag)
    }
    
}

