//
//  Dates.swift
//  The_Wheel_Of_Dates
//
//  Created by Chad Watts on 8/30/16.
//  Copyright © 2016 Chad Watts. All rights reserved.
//



import Foundation

    enum DateTypes: String {
        
        
        case movies = "Movies"
        case bowling = "Bowling"
        case hiking = "Hiking"
        case trampolineHouse = "Trampoling House"
        case paintballing = "Paintballing"
        case lazerTag = "LazerTag"
        case goToDinner = "Dinner"
        case picnic = "Picnic"
        case waterPark = "WaterPark"
        case themePark = "ThemePark"
        case miniGolfing = "MiniGolf"
        case goKarts = "GoKarts"
        case iceSkating = "IceSkating"
        case rollerRink = "RollerSkating"
        case goToBuildABear = "BuildABear"
        case playBoardGames = "GameNight"
        case biking = "Biking"
        case aquarium = "Aquarium"
        case play = "Play"
        case club = "Clubing"
        case fishing = "Fishing"
        case casino = "Casino"
        case zoo = "Zoo"
        case bungi = "Bungi"
        case arcade = "Arcade"
        case shooting = "ShootingRange"
        case skyDiving = "SkyDiving"
        
        static var allDates = [movies, bowling, hiking, trampolineHouse, paintballing, lazerTag, goToDinner, picnic, waterPark, themePark, miniGolfing, goKarts, iceSkating, rollerRink, goToBuildABear, playBoardGames, biking]
    
}

protocol SelectedDateDelegate: class {

    func dateSelected(date: DateTypes)
}







