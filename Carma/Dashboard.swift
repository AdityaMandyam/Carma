//
//  ViewController.swift
//  Carma
//
//  Created by Aditya M on 1/21/17.
//  Copyright © 2017 Aditya M. All rights reserved.
//

import UIKit
import Charts

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

class Dashboard: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chart: BarChartView!
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
        
        self.chart.delegate = self;
        chart.noDataText = "Not enough data yet!";

        if (FillUps.count >= 2) {
            setChart(data_points: FillUps);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     
     Setup for chart
     
     */
    
    func setChart(data_points: [FillUp]) {
        var gallons = [Double]();
        var index = data_points.count - 1;
        // get an array of the last 10 fillups' data from FillUps
        while(index >= 0) {
            gallons.append(data_points[index].getGallons());
            if gallons.count >= 10 {
                break;
            }
            index -= 1;
        }
        
        // reverse the data so that it appears in chronological order
        gallons = gallons.reversed();
        
        // create bar chart entries for the data and append them to an array
        var data_entries = [BarChartDataEntry]();
        for i in 0..<gallons.count {
            let data_entry = BarChartDataEntry(x: Double(i), yValues: [gallons[i]]);
            data_entries.append(data_entry);
        }
        
        // create a dataset from the array and assign the dataset to the chart
        let chart_data_set = BarChartDataSet(values: data_entries.reversed(), label: "Gallons purchased");
        let chart_data = BarChartData(dataSet: chart_data_set);
        
        // beautify the chart
        chart_data_set.barBorderColor = UIColor.black;
        chart_data_set.barBorderWidth = 2.0;
        chart_data_set.setColor(UIColor.red);
        let lyaxis = chart.getAxis(.left);
        lyaxis.axisMinimum = 0
        lyaxis.enabled = false;
        let ryaxis = chart.getAxis(.right);
        ryaxis.enabled = false;
        let xaxis = chart.xAxis;
        xaxis.enabled = false;
        xaxis.axisMinimum = -1;
        xaxis.granularity = 1;
        chart.drawGridBackgroundEnabled = false;
        chart.chartDescription?.text = "";
        chart.backgroundColor = NSUIColor.lightGray;
        chart.borderColor = NSUIColor.black;
        chart.pinchZoomEnabled = false;
        chart.scaleXEnabled = false;
        chart.scaleXEnabled = false;
        chart.doubleTapToZoomEnabled = false;
        chart.xAxis.drawGridLinesEnabled = false;
        chart.animate(yAxisDuration: 1)
        chart.data = chart_data;
    }
}

