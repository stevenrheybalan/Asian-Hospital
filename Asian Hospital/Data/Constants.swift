//
//  Constants.swift
//  Asian Hospital
//
//  Created by HopprLab on 03/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation

struct Constant {
    static let homeMenuItems: [Item] = [
        Item(title: "Patient", subtitle: "We provide on-hand health information and quick bill access just for you", image: #imageLiteral(resourceName: "Heart")),
        Item(title: "Our Doctors", subtitle: "Keep well-versed as we provided the list and information of doctors available to help you", image: #imageLiteral(resourceName: "Doctor")),
        Item(title: "Find Our Location", subtitle: "Feel right at home as we will be guiding you every step of the way", image: #imageLiteral(resourceName: "Location")),
        Item(title: "Contact Us", subtitle: "Get in touch at ease as you can now quickly contact us directly", image: #imageLiteral(resourceName: "Contact")),
        Item(title: "About Us", subtitle: "", image: #imageLiteral(resourceName: "Hospital"))
    ]
    
    static let hotlines = [
        "contacts": [
            ["contact_name": "Emergency Hotline", "contact_number": "(02) 876-5739"],
            ["contact_name": "Admission", "contact_number": "(02) 876-5716"],
            ["contact_name": "Asian Cancer Institute", "contact_number": "(02) 876-5842"],
            ["contact_name": "Center for Executive Unit", "contact_number": "(02) 876-5796"],
            ["contact_name": "Guest Services", "contact_number": "(02) 876-5827"],
            ["contact_name": "International Health", "contact_number": "(02) 876-5838"],
            ["contact_name": "Laboratory", "contact_number": "(02) 876-5759"],
            ["contact_name": "Radiology", "contact_number": "(02) 876-5720"],
            ["contact_name": "Trunkline", "contact_number": "(02) 771-9000"]
        ]
    ]
    
    static let descriptionString = """
    Asian Hospital and Medical Center is a tertiary care hospital in the Southern Luzon corridor of Metropolitan Manila. Officially inaugurated and opened to the public on May 11, 2002. It is the first hospital in the Philippines that was designed with a hotel-like ambience that promotes healing and provides comfort for patients and their families and friends.\n\nAsian Hospital and Medical Center is strategically located in the Filinvest City in Alabang, Muntinlupa City - only 10 kilometers from the country's central business district Makati City, a mere 20-minute drive from the International and Domestic airports, and less than a kilometer from the South Luzon Expressway (SLEX).\n\nWith 289-bed capacity, the hospital has a total floor area of 44,147 square meters and stands on a 17,250-square meter campus which houses the Main Hospital and the Medical Office Building (MOB). It has 1,041 employees and 1,000 medical staff; all trained to provide high quality and compassionate patient care. Over 500 doctors hold their clinics at the MOB, which has 145 clinics and offices.\n\nIn December 2011, Asian Hospital and Medical Center became the largest single hospital investment of Metro Pacific Investments Corporation (MPIC); the local unit of the First Pacific Group headed by Manuel V. Pangilinan, currently operating eight hospitals across the archipelago, the MPIC Hospital Group.\n
    """
    
    static let hospitalCoordinate = Coordinate(latitude: 14.413492, longitude: 121.043787)
}
