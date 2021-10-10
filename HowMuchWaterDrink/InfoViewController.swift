//
//  InfoViewController.swift
//  HowMuchWaterDrink
//
//  Created by Yundong Lee on 2021/10/08.
//

import UIKit
import TextFieldEffects
class InfoViewController: UIViewController {

    @IBOutlet weak var nickNameTextField: HoshiTextField!
    @IBOutlet weak var heightTextField: HoshiTextField!
    @IBOutlet weak var weightTextField: HoshiTextField!
    
    
    func confugureViews(){
        nickNameTextField.backgroundColor = .clear
        nickNameTextField.borderActiveColor = .white
        nickNameTextField.placeholderColor = .white
        nickNameTextField.borderInactiveColor = .white
        heightTextField.backgroundColor = .clear
        heightTextField.borderActiveColor = .white
        heightTextField.borderInactiveColor = .white
        heightTextField.placeholderColor = .white
        
        weightTextField.backgroundColor = .clear
        weightTextField.placeholderColor = .white
        weightTextField.borderActiveColor = .white
        weightTextField.borderInactiveColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func tapOutside(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let name = nickNameTextField.text!
        let height = heightTextField.text!
        let weight = weightTextField.text!
        
        if name.count == 0 || height.count == 0 || weight.count == 0{
            // present pop up
            presentAlertController("모든 정보를 입력해주세요.")
        }else{
            // save data
            
            let data = ["name" : name, "height" : height, "weight" : weight]
            
            UserDefaults.standard.set(data, forKey: "info")
//            UserDefaults.standard.set(name, forKey: "name")
//            UserDefaults.standard.set(height, forKey: "height")
//            UserDefaults.standard.set(weight, forKey: "weight")
            presentAlertController("저장되었습니다.")
        }
    }
    
    
    func presentAlertController(_ popUpContent : String){
        let alert = UIAlertController(title: nil, message: popUpContent, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
}
