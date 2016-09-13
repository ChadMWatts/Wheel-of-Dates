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
        case hiking = "hiking"
        case trampolineHouse = "Trampoling House"
        case paintballing = "Paintballing"
        case lazerTag = "Lazer Tag"
        case goToDinner = "Dinner"
        case picnic = "Picnic"
        case waterPark = "Water Park"
        case themePark = "Theme Park"
        case miniGolfing = "Mini Golfing"
        case goKarts = "Go Carts"
        case iceSkating = "Ice Skating"
        case rollerRink = "Roller Skating Rink"
        case goToBuildABear = "Go to build a Bear Work Shop"
        case playBoardGames = "Board games"
        case biking = "Biking"
        case aquarium = "Aquarium"
        case play = "Play"
        case club = "Club"
        case fishing = "Fishing"
        case casino = "Casino"
        case zoo = "Zoo"
        case bungi = "Bungi Jump"
        case arcade = "Arcade"
        case shooting = "Shooting Range"
        case skyDiving = "SkyDiving"
        
        static var allDates = [movies, bowling, hiking, trampolineHouse, paintballing, lazerTag, goToDinner, picnic, waterPark, themePark, miniGolfing, goKarts, iceSkating, rollerRink, goToBuildABear, playBoardGames, biking]
    
}

protocol SelectedDateDelegate: class {

    func dateSelected(date: DateTypes)
}







