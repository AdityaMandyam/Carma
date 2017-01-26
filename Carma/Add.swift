//
//  Add.swift
//  Carma
//
//  Created by Aditya M on 1/21/17.
//  Copyright © 2017 Aditya M. All rights reserved.
//

import UIKit

class Add: UIViewController, UITextFieldDelegate {
    // UI fields
    @IBOutlet weak var odometerField: UITextField!
    @IBOutlet weak var moneyField: UITextField!
    @IBOutlet weak var gallonsField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func AddButtonAction(_ sender: UIButton) { // action on add button press
        if(moneyField.text != "" && odometerField.text != "" && gallonsField.text != "") { // if fields are not empty
            let current = FillUp(amount_money: Double(moneyField.text!)!, num_gallons: Double(gallonsField.text!)!, odo_reading: Int32(odometerField.text!)!, fill_date: Date()); // create fillup object for visit
            FillUps.append(current); // append to end of array
            
            // make fields blank
            odometerField.text = "";
            moneyField.text = "";
            gallonsField.text = "";
            errorLabel.text = "Data added successfully!";
            errorLabel.textColor = UIColor.green;
        } else {
            errorLabel.text = "Please enter valid data";
            errorLabel.textColor = UIColor.red;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set fields to blank on load
        odometerField.text = "";
        moneyField.text = "";
        gallonsField.text = "";
        errorLabel.text = "";
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view .endEditing(true);
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
