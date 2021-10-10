//
//  ViewController.swift
//  HowMuchWaterDrink
//
//  Created by Yundong Lee on 2021/10/08.
//

import UIKit

class DrinkViewController: UIViewController {

    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var totalDrinkedWater: UILabel!
    @IBOutlet weak var drankPercentage: UILabel!
    @IBOutlet weak var typeDrinkWater: UITextField!
    @IBOutlet weak var centerImage: UIImageView!
    @IBOutlet weak var bottomInfo: UILabel!
    
    // currentDrink 값 바꾸면 자동으로 updateCurrentDrink 호출.
    // 마신 물의 양이 추천 양보다 많으면 위 레이블들 색 빨간색으로 변경. ml
    var currentDrink = 0{
        didSet{
            updateCurrentDrink()
            if Double(currentDrink) > recommend * 1000{
                totalDrinkedWater.textColor = .red
                drankPercentage.textColor = .red
                helloLabel.textColor = .red
            }else{
                totalDrinkedWater.textColor = .white
                drankPercentage.textColor = .white
                helloLabel.textColor = .white
            }
        }
    }
    // recommend 단위 리터임.
    var recommend : Double = 1{
        didSet{
            if recommend == 0{
                recommend = 0.1
            }
        }
    }
    
    func configureViews(){
        helloLabel.textColor = .white
        totalDrinkedWater.textColor = .white
        drankPercentage.textColor = .white
        bottomInfo.textColor = .white
        typeDrinkWater.backgroundColor = .clear
        bottomButton.backgroundColor = .white
        bottomButton.setTitle("물마시기", for: .normal)
        bottomButton.tintColor = .black
        
        helloLabel.text = "잘마셨어요! \n오늘 마신 양은"
        typeDrinkWater.placeholder = "얼마나 마셨나요? (ml)"
    }
    
    
    // 기본 현재 마신 물은 0, 정보가 있으면 정보 가져와서 설정하기.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        getUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserInfo()
    }
    
    
    // 텍스트 필드는 숫자만 받을 수 있음.
    // 텍스트 필드안에 값으로 현제 마신 물의 양 증가 시키고 UI update.
    @IBAction func drinkButton(_ sender: UIButton) {
        let drink = typeDrinkWater.text!
        if drink.count != 0{
            currentDrink = currentDrink + Int(drink)!
        }
        typeDrinkWater.text = ""
    }
    
    // 현재 마신 물의 양을 0으로 하고 ui update.
    @IBAction func resetButton(_ sender: UIBarButtonItem) {
        currentDrink = 0
    }
    
    // 키보드 내리기
    @IBAction func tapOutside(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // 저장 그리고
    // 현재 마신 물의 양으로 UI 업데이트하기.
    func updateCurrentDrink(){
        if let info = UserDefaults.standard.object(forKey: "info"), var dic = info as? [String : String] {
            dic["currentDrink"] = "\(currentDrink)"
            UserDefaults.standard.set(dic, forKey: "info")
        }
        
        totalDrinkedWater.text = "\(currentDrink)ml"
        let percent = Double(currentDrink) / (recommend * 10.0)
        drankPercentage.text = String(format: "%.2f", percent) + "%"
        
        
        if percent <= 10{
            centerImage.image = UIImage(named: "1-1")
        }else if percent <= 20{
            centerImage.image = UIImage(named: "1-2")
        }else if percent <= 30{
            centerImage.image = UIImage(named: "1-3")
        }else if percent <= 40{
            centerImage.image = UIImage(named: "1-4")
        }else if percent <= 50{
            centerImage.image = UIImage(named: "1-5")
        }else if percent <= 60{
            centerImage.image = UIImage(named: "1-6")
        }else if percent <= 70{
            centerImage.image = UIImage(named: "1-7")
        }else if percent <= 80{
            centerImage.image = UIImage(named: "1-8")
        }else{
            centerImage.image = UIImage(named: "1-9")
        }
    }

    // 사용자의 정보를 userdefault에서 가져오고 UI 사용자에 맞게 설정하기.
    // 사용자 정보가 없으면 아래 정보는 없게 표시.
    func getUserInfo(){
        if let info = UserDefaults.standard.object(forKey: "info"), let dic = info as? [String : String] {
            recommend = (Double(dic["height"]!)! + Double(dic["weight"]!)!) / 100
            bottomInfo.text = "\(dic["name"]!)님의 하루 물 권장 섭치량은 \(recommend)l입니다."
            
            if let currentDrinkData = dic["currentDrink"]{
                currentDrink = Int(currentDrinkData)!
            }else{
                currentDrink = 0
            }
         
        }else{
            bottomInfo.text = ""
            currentDrink = 0
        }
    }

}
