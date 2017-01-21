//
//  ViewController.swift
//  Carma
//
//  Created by Aditya M on 1/21/17.
//  Copyright © 2017 Aditya M. All rights reserved.
//

import UIKit

class FillUp { // fillup class to store data for each visit to gas station
    private var money: Double; // amount spent
    private var gallons: Double; // gallons purchased
    private var odometer_reading: Int32; // odometer reading during fillup
    private var date: Date; // date of fillup
    
    // constructor
    init(amount_money: Double, num_gallons: Double, odo_reading: Int32, fill_date: Date) {
        money = amount_money;
        gallons = num_gallons;
        odometer_reading = odo_reading;
        date = fill_date;
    }
    
    // get methods to return data
    func getMoney() -> Double {
        return money;
    }
    
    func getGallons() -> Double {
        return gallons;
    }
    
    func getOdometer() -> Int32 {
        return odometer_reading;
    }
    
    func getDate() -> Date {
        return date as Date;
    }
}

var FillUps = [FillUp](); // fillups array to hold data

class Dashboard: UIViewController {

    @IBOutlet var lineChart: LineChartView!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    
    override func loadView() {
        super.loadView();
        
        /*
         
         If less than 1 entry in array, not enough data
         If 2 entries in array, calculate mileage and previous spent:
                
                previous odometer reading - current odometer reading
                ----------------------------------------------------
                                gallons purchased
         
                previous spent
         
        */
        
        if(FillUps.count <= 1) {
            
            // not enough data
            mileageLabel.text = "Not enough data";
            spentLabel.text = "Not enough data";
            
            // set labels to red
            mileageLabel.textColor = UIColor.red;
            spentLabel.textColor = UIColor.red;
        } else {
            let spent: Double = FillUps[FillUps.count - 1].getMoney(); // previous visit money spent
            
            let mileage = Double(round(100 * (Double(FillUps[FillUps.count - 1].getOdometer()) - Double(FillUps[FillUps.count - 2].getOdometer())) / FillUps[FillUps.count - 1].getGallons()) / 100); // rounding for 2 digits of precision
            // have to use Double(round(100 * value) / 100)
            
            // set labels to display info
            mileageLabel.text = "\(mileage)";
            spentLabel.text = "\(spent)";
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print fillups array for checking if calculations are correct
        for item in FillUps {
            print("Odometer: \(item.getOdometer()) Money: \(item.getMoney()) Gallons: \(item.getGallons()) Date: \(item.getDate())");
        }
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

