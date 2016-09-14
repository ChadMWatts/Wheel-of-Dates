//
//  DateWheelViewController.swift
//  The_Wheel_Of_Dates
//
//  Created by Chad Watts on 8/30/16.
//  Copyright © 2016 Chad Watts. All rights reserved.
//

import UIKit

class DateWheelViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var DateListPicker: UIPickerView!
    @IBOutlet weak var BackroundImage: UIImageView!
    
    weak var delegate: SelectedDateDelegate?
    
    struct Picker {
        
        var image: UIImage!
    }
    
    var counter = 0
    var images = [Picker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in DateTypes.allDates {
            images.append(Picker(image: UIImage(named: i.rawValue)))
        }
        DateListPicker.delegate = self
        DateListPicker.dataSource = self
    }
    
    // MARK: - Random Spin
    
    func randomSpin() {
        
        let randomRow = random() % images.count
        DateListPicker.selectRow(randomRow, inComponent: counter, animated: true)
        self.pickerView(DateListPicker, didSelectRow: randomRow, inComponent: counter)
    }
    
    // MARK: - PickerView
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //        let idea = DateTypes.allDates[row]
        //        delegate?.dateSelected(idea)
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        return UIImageView(image: images[row].image)
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return images[0].image.size.height
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return images[0].image.size.width
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func randomizeButtonTapped(sender: AnyObject){
        
        randomSpin()
    }
    
    @IBAction func locationsButtonTapped(sender: AnyObject) {
        
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let locationsVC = segue.destinationViewController as? LocationsTableViewController
        if segue.identifier == "toLocations" {
            
            guard let dateIndex = DateListPicker?.selectedRowInComponent(0) else {return}
            let date = DatesController.sharedController.dates[dateIndex]
            locationsVC?.dates = date
        }
    }
}
