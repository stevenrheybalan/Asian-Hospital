//
//  Constants.swift
//  Asian Hospital
//
//  Created by HopprLab on 03/04/2018.
//  Copyright © 2018 Asian Hospital Inc. All rights reserved.
//

import Foundation
import SCLAlertView

struct Constants {
    static let menuIdentifier = [
        "showPatientLogin",
        "showDoctors",
        "showLocation",
        "showContacts",
        "showAboutUs"
    ]
    
    static let homeMenuItems: [Item] = [
        Item(title: "Patient", subtitle: "We provide on-hand health information and quick bill access just for you", image: #imageLiteral(resourceName: "Heart")),
        Item(title: "Our Doctors", subtitle: "Keep well-versed as we provided the list and information of doctors available to help you", image: #imageLiteral(resourceName: "Doctor")),
        Item(title: "Find Our Location", subtitle: "Feel right at home as we will be guiding you every step of the way", image: #imageLiteral(resourceName: "Location")),
        Item(title: "Contact Us", subtitle: "Get in touch at ease as you can now quickly contact us directly", image: #imageLiteral(resourceName: "Contact")),
        Item(title: "About Us", subtitle: "", image: #imageLiteral(resourceName: "Hospital"))
    ]
    
    static let patientTableViewItems: [TableViewItem] = [
        TableViewItem(title: "Health Information", rowHeight: 165, hasCollectionView: true, items: [
            Item(title: PatientInformationType.demographics.rawValue, subtitle: "", image: #imageLiteral(resourceName: "Profile")),
            Item(title: PatientInformationType.allergies.rawValue, subtitle: "", image: #imageLiteral(resourceName: "Allergies")),
            Item(title: PatientInformationType.diagnosis.rawValue, subtitle: "", image: #imageLiteral(resourceName: "Diagnosis")),
            Item(title: PatientInformationType.medications.rawValue, subtitle: "", image: #imageLiteral(resourceName: "Medications"))]),
        TableViewItem(title: "Summary", rowHeight: 184, hasCollectionView: false, items: [
            Item(title: "Health Record Summary", subtitle: "Apple HealthKit", image: #imageLiteral(resourceName: "Heart"), buttonTitle: "Download")]),
        TableViewItem(title: "Others", rowHeight: 184, hasCollectionView: false, items: [
            Item(title: "Patient Barcode", subtitle: "Apple Wallet", image: #imageLiteral(resourceName: "Barcode"), buttonTitle: "Generate"),
            Item(title: "Billing Details", subtitle: "Inpatient Only", image: #imageLiteral(resourceName: "Bill"), buttonTitle: "Generate")])
    ]
    
    static let contactTableViewItems: [TableViewItem] = [
        TableViewItem(title: "", rowHeight: 165, hasCollectionView: true, items: [
            Item(title: "Facebook", subtitle: "https://www.facebook.com/AsianHospitalPH", image: #imageLiteral(resourceName: "Facebook")),
            Item(title: "Twitter", subtitle: "https://www.twitter.com/asianhospitalPH", image: #imageLiteral(resourceName: "Twitter")),
            Item(title: "Website", subtitle: "http://www.asianhospital.com", image: #imageLiteral(resourceName: "Website"))]),
        TableViewItem(title: "Telephone Directory", rowHeight: 65, hasCollectionView: false, items: [
            Item(title: "Emergency Hotline", subtitle: "(02) 876-5739", image: nil),
            Item(title: "Admission", subtitle: "(02) 876-5716", image: nil),
            Item(title: "Asian Cancer Institute", subtitle: "(02) 876-5842", image: nil),
            Item(title: "Center for Executive Unit", subtitle: "(02) 876-5796", image: nil),
            Item(title: "Guest Services", subtitle: "(02) 876-5827", image: nil),
            Item(title: "International Health", subtitle: "(02) 876-5838", image: nil),
            Item(title: "Laboratory", subtitle: "(02) 876-5759", image: nil),
            Item(title: "Radiology", subtitle: "(02) 876-5720", image: nil),
            Item(title: "Trunkline", subtitle: "(02) 771-9000", image: nil)])
    ]
    
    static let descriptionString = """
    Asian Hospital and Medical Center is a tertiary care hospital in the Southern Luzon corridor of Metropolitan Manila. Officially inaugurated and opened to the public on May 11, 2002. It is the first hospital in the Philippines that was designed with a hotel-like ambience that promotes healing and provides comfort for patients and their families and friends.\n\nAsian Hospital and Medical Center is strategically located in the Filinvest City in Alabang, Muntinlupa City - only 10 kilometers from the country's central business district Makati City, a mere 20-minute drive from the International and Domestic airports, and less than a kilometer from the South Luzon Expressway (SLEX).\n\nWith 289-bed capacity, the hospital has a total floor area of 44,147 square meters and stands on a 17,250-square meter campus which houses the Main Hospital and the Medical Office Building (MOB). It has 1,041 employees and 1,000 medical staff; all trained to provide high quality and compassionate patient care. Over 500 doctors hold their clinics at the MOB, which has 145 clinics and offices.\n\nIn December 2011, Asian Hospital and Medical Center became the largest single hospital investment of Metro Pacific Investments Corporation (MPIC); the local unit of the First Pacific Group headed by Manuel V. Pangilinan, currently operating eight hospitals across the archipelago, the MPIC Hospital Group.\n
    """
    
    static let hospitalCoordinate = Coordinate(latitude: 14.413492, longitude: 121.043787)
    
    static let dataPrivacyString = (title: "Data Privacy", description: "Because we protect your data.\nWe only allow an on-site creation of account.\n\nDue to Republic Act No. 10173 compliance.")
    
    static var loadingAlertView: SCLAlertView {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        return SCLAlertView(appearance: appearance)
    }
}
