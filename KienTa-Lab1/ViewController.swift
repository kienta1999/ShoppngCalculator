//
//  ViewController.swift
//  KienTa-Lab1
//
//  Created by Kien Ta on 9/24/20.
//  Copyright © 2020 Kien Ta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var originalPrice: UITextField!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet weak var tax: UITextField!
    @IBOutlet weak var finalPrice: UILabel!
    
    
    @IBOutlet weak var changePrice: UIStepper!
    @IBOutlet weak var changeDiscount: UIStepper!
    @IBOutlet weak var changeTax: UIStepper!
    
    
    var originalPriceVal:Double = 0
    var discountVal:Double = 0
    var taxVal:Double = 0
    var finalPriceVal:Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func originalPriceEdited(_ sender: Any) {
        originalPriceVal = stringOptionalToDouble(str:originalPrice.text)
        updateFinalPrice()
        changePrice.value = originalPriceVal;
        
    }
    @IBAction func discountEdited(_ sender: Any) {
        discountVal = stringOptionalToDouble(str:discount.text)
        if(discountVal > 100){
            discountVal = 100
            discount.text = "100"
        }
        updateFinalPrice()
        changeDiscount.value = discountVal;
//        print(finalPriceVal)
    }
    
    @IBAction func taxEdited(_ sender: Any) {
        taxVal = stringOptionalToDouble(str:tax.text)
        updateFinalPrice()
//        print(finalPriceVal)
        changeTax.value = taxVal;
    }
    
    
    func stringOptionalToDouble(str: String?) -> Double {
        var num:Double
        if (str != nil){
            if let optionalNum = Double(str!){
                num = optionalNum
            }
            else{
                num = 0
                if(str != ""){
                    originalPrice.text = ""
                    discount.text = ""
                    tax.text = ""
                    discountVal = 0
                    taxVal = 0
                    originalPriceVal = 0.0
                }
                
            }
        }
        else{
            num = 0.0
        }
        return num;
    }
    func calculatePrice(price: Double, discount: Double, tax: Double) -> Double {
        return price * (1 - discount / 100) * (1 + tax / 100)
    }
    func updateFinalPrice(){
        finalPriceVal = calculatePrice(price: originalPriceVal, discount: discountVal, tax: taxVal)
        finalPrice.text = "$\(String(format: "%.2f", finalPriceVal))"
    }
    
    
    @IBAction func changPriceAction(_ sender: UIStepper) {
        if(sender.tag == 0){
            originalPrice.text = "\(String(changePrice.value))";
            originalPriceVal = changePrice.value;
        }
        else if(sender.tag == 1){
            discount.text = "\(String(changeDiscount.value))";
            discountVal = changeDiscount.value;
        }
        else {
            tax.text = "\(String(changeTax.value))";
            taxVal = changeTax.value;
        }
        updateFinalPrice()
    }
    
}

