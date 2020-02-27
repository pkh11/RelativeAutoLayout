//
//  ViewController.swift
//  ReleativeLoginLayout
//
//  Created by 박균호 on 2020/02/27.
//  Copyright © 2020 박균호. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    var emailErrorHeight: NSLayoutConstraint!
    var passwordErrorHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 오브젝트의 이벤트 동작
        emailTextField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        
        emailErrorHeight = emailErrorLabel.heightAnchor.constraint(equalToConstant: 0)
        passwordErrorHeight = passwordErrorLabel.heightAnchor.constraint(equalToConstant: 0)
        emailErrorHeight.isActive = true
        passwordErrorHeight.isActive = true
        
    }
    @objc func textFieldEdited(textField: UITextField){
        if textField == emailTextField {
            if isValidEmail(email: textField.text) {
                // 새로 constraint 값을 지정
                emailErrorHeight.isActive = true
                
                // emailErrorHeight = emailErrorLabel.heightAnchor.constraint(equalToConstant: 0)
                // 이 방법은 constraint값을 지정할 경우, if문에 이미 설정한 constraint값이 있기 때문에 중복으로 처리됨. (오류남)
                
                // 처음에 label.isHidden 방법을 생각했었는데,
                // 이 방법은 constraint값을 유지한 채 오브젝트만 사라지게 하기때문에 위아래에 위치한 오브젝트들을 동적으로 위치시킬 수 없다.
                
            }else{
                // emailErrorHeight = emailErrorLabel.heightAnchor.constraint(equalToConstant: 16)
                // 마찬가지로 constraint값을 지정할 경우, if문에 이미 설정한 constraint값이 있기 때문에 중복으로 처리됨. (오류남)
                
                emailErrorHeight.isActive = false
            }
        }else if textField == passwordTextField {
            if isValidPassword(password: textField.text) {
                passwordErrorHeight.isActive = true
            }else{
                passwordErrorHeight.isActive = false
            }
        }
        
        // label 애니메이션 효과
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
    }
    // 정규식 - regular expression
    func isValidEmail(email: String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func isValidPassword(password: String?) -> Bool {
        if let hasPassword = password{
            if hasPassword.count < 8{
                return false
            }
        }
        return true
    }
}

