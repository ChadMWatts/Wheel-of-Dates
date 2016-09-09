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
    
    
    
    struct Picker {
        
        var image: UIImage!
    }
    
    var counter = 0
    var images = [Picker]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let movies = Picker(image: UIImage(named: "Movies"))
        let bowling = Picker(image: UIImage(named: "Bowling"))
        let hiking = Picker(image: UIImage(named: "Hiking"))
        let trampoline = Picker(image: UIImage(named: "Trampoline"))
        let paintballing = Picker(image: UIImage(named: "Paintballing"))
        let lazerTag = Picker(image: UIImage(named: "LazerTag"))
        let dinner = Picker(image: UIImage(named: "Dinner"))
        let picnic = Picker(image: UIImage(named: "Picnic"))
        let waterPark = Picker(image: UIImage(named: "WaterPark"))
        let miniGolf = Picker(image: UIImage(named: "MiniGolf"))
        let goKarts = Picker(image: UIImage(named: "GoKarts"))
        let iceSkating = Picker(image: UIImage(named: "IceSkating"))
        let rollerSkating = Picker(image: UIImage(named: "RollerSkating"))
        let buildABear = Picker(image: UIImage(named: "BuildABear"))
        let boardGames = Picker(image: UIImage(named: "GameNight"))
        let biking = Picker(image: UIImage(named: "Biking"))
        
        images = [movies, bowling, hiking, trampoline, paintballing, lazerTag, dinner, picnic, waterPark, miniGolf, goKarts, iceSkating, rollerSkating, buildABear, boardGames, biking]
        
        
        
        DateListPicker.delegate = self
        DateListPicker.dataSource = self
    
    }
    
    func randomSpin() {
        
        let randomDate = random() % images.count
        DateListPicker.selectRow(randomDate, inComponent: counter, animated: true)
        self.pickerView(DateListPicker, didSelectRow: randomDate, inComponent: counter)
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
