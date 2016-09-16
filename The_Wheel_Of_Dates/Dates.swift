//
//  Dates.swift
//  The_Wheel_Of_Dates
//
//  Created by Chad Watts on 8/30/16.
//  Copyright © 2016 Chad Watts. All rights reserved.
//



import Foundation

    enum DateTypes: String {
        
        case picnic = "Picnic Areas"
        case movies = "Movie Theater"
        case bowling = "Bowling Alleys"
        case hiking = "Hiking Trails"
        case trampolineHouse = "Trampoline"
        case paintballing = "Paintball"
        case lazerTag = "Lazer Tag"
        case goToDinner = "Restuarnts"
        case waterPark = "WaterPark"
        case themePark = "ThemePark"
        case miniGolfing = "MiniGolf"
        case goKarts = "GoKarts"
        case iceSkating = "Ice Skating Rink"
        case rollerRink = "Roller Derby"
        case goToBuildABear = "Build A Bear"
        case playBoardGames = "GameNight"
        case biking = "Biking Routes"
        case aquarium = "Aquarium"
        case play = "Performing Arts"
        case club = "Club"
        case fishing = "Fishing"
        case casino = "Casino"
        case zoo = "Zoo"
        case bungi = "Bungi Jumping"
        case arcade = "Arcade"
        case shooting = "Shooting Range"
        case skyDiving = "Sky Diving"
        case horseRace = "Horse Race"
        case demolitionDerby = "Demolition Derby"
        case museum = "Museum"
        case animalShelter = "Animal Shelter"
        case scavengerHunt = "Scavenger Hunt"
        case getOutGames = "Escape The Room"
        case visistTheElder = "Senior Citizen Center"
        
        static var allDates = [movies, bowling, hiking, trampolineHouse, paintballing, lazerTag, goToDinner, picnic, waterPark, themePark, miniGolfing, goKarts, iceSkating, rollerRink, goToBuildABear, playBoardGames, biking, aquarium, play, club, fishing, casino, zoo, bungi, arcade, shooting, skyDiving, horseRace, demolitionDerby]
    
}

protocol SelectedDateDelegate: class {

    func dateSelected(date: DateTypes)
}







