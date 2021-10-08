//
//  ViewController.swift
//  HowMuchWaterDrink
//
//  Created by Yundong Lee on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalDrinkedWater: UILabel!
    @IBOutlet weak var drankPercentage: UILabel!
    @IBOutlet weak var typeDrinkWater: UITextField!
    
    @IBOutlet weak var bottomInfo: UILabel!
    var currentDrink = 0
    var recommend = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentDrink = 0
        updateCurrentDrink()
        
        if let name = UserDefaults.standard.string(forKey: "name"), let height = UserDefaults.standard.string(forKey: "height"), let weight = UserDefaults.standard.string(forKey: "weight"){
            
            recommend = (Int(height)! + Int(weight)!) / 100
            
            bottomInfo.text = "\(name)님의 하루 물 권장 섭치량은 \(recommend)ml입니다."
            
        }else{
            bottomInfo.text = ""
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let name = UserDefaults.standard.string(forKey: "name"), let height = UserDefaults.standard.string(forKey: "height"), let weight = UserDefaults.standard.string(forKey: "weight"){
            
            recommend = (Int(height)! + Int(weight)!) / 100
            
            bottomInfo.text = "\(name)님의 하루 물 권장 섭치량은 \(recommend)l입니다."
            
        }else{
            bottomInfo.text = ""
        }
    }
    
    func updateCurrentDrink(){
        totalDrinkedWater.text = "\(currentDrink)ml"
        drankPercentage.text = "\(currentDrink / (recommend * 10))%"
    }

    @IBAction func drinkButton(_ sender: UIButton) {
        let drink = typeDrinkWater.text!
        if drink.count != 0{
            currentDrink = currentDrink + Int(drink)!
            updateCurrentDrink()
        }
    }
    
    @IBAction func resetButton(_ sender: UIBarButtonItem) {
        
        currentDrink = 0
        updateCurrentDrink()
    }
    
    
}

