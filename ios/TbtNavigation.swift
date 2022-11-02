//
//  TbtNavigation.swift
//  MapboxNavigation5
//
//  Created by Sahas Dangol on 8/22/22.
//

import Foundation
import UIKit
import MapboxMaps
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

@objc(TbtNavigation) class TbtNavigation: NSObject {
  @objc static func requiresMainQueueSetup() -> Bool { return true }
  
  @objc public func simpleMethod(_ coords : NSArray) {
    
    var cllocationsData1 = [Waypoint]()
    
    let a = coords[0] as! Array<Any>
    
    for data1 in a {
      let temp = data1 as! Array<Double>
      print(temp)
      print("type of temp \(type(of: temp))")
      print("lat \(temp[0])")
      print("lon \(temp[0])")
      
      cllocationsData1.append(Waypoint(coordinate: CLLocationCoordinate2D(latitude: temp[0], longitude: temp[1])))
    }

    let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.74682893940135, longitude: -122.41241455078125), name: "Origin")
    let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 37.779398571318765, longitude: -122.22290039062499), name: "Destination")
            
    
    let routeOptions = NavigationRouteOptions(waypoints: cllocationsData1)
    
    // Set options
//    let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
    
    Directions.shared.calculate(routeOptions) {[weak self] (_, result) in
        switch result {
        case .failure(let error):
          print(error.localizedDescription)
          
        case .success(let response):
          guard let weakSelf = self else {
            return
          }

          let navigationService = MapboxNavigationService(routeResponse: response, routeIndex: 0, routeOptions: routeOptions, simulating: .always)
          navigationService.router.reroutesProactively = false

          let navigationOptions = NavigationOptions(styles: [CustomDayStyle()], navigationService: navigationService)
            // Pass the generated route response to the the NavigationViewController
          let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions, navigationOptions: navigationOptions)
          
          
          
          
          viewController.modalPresentationStyle = .fullScreen
          
          
          let appDelegate = UIApplication.shared.delegate
          appDelegate!.window!!.rootViewController!.present(viewController, animated: true, completion: nil)
          
        }
    }
    
    print("I am using Native module")
    
  }
  
  @objc public func simpleMethodReturns(
    _ callback: RCTResponseSenderBlock
  ) {
    callback(["TbtNavigation.simpleMethodReturns()"])
  }
  
  @objc public func simpleMethodWithParams(
    _ param: String,
    callback: RCTResponseSenderBlock
  ) {
    callback(["TbtNavigation.simpleMethodWithParams('\(param)')"])
  }
}

class CustomDayStyle: DayStyle {
 
private let backgroundColor = #colorLiteral(red: 0.06276176125, green: 0.6164312959, blue: 0.3432356119, alpha: 1)
private let darkBackgroundColor = #colorLiteral(red: 0.0473754704, green: 0.4980872273, blue: 0.2575169504, alpha: 1)
private let secondaryBackgroundColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
private let blueColor = #colorLiteral(red: 0.26683864, green: 0.5903761983, blue: 1, alpha: 1)
private let lightGrayColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
private let darkGrayColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
private let primaryLabelColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
private let secondaryLabelColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9)
 
required init() {
super.init()
mapStyleURL = URL(string: "mapbox://styles/mapbox/streets-v11")!
styleType = .day
}
 
override func apply() {
super.apply()
 
let traitCollection = UIScreen.main.traitCollection
ArrivalTimeLabel.appearance(for: traitCollection).textColor = lightGrayColor
BottomBannerView.appearance(for: traitCollection).backgroundColor = secondaryBackgroundColor
BottomPaddingView.appearance(for: traitCollection).backgroundColor = secondaryBackgroundColor
Button.appearance(for: traitCollection).textColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
CancelButton.appearance(for: traitCollection).tintColor = lightGrayColor
DistanceLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [InstructionsBannerView.self]).unitTextColor = secondaryLabelColor
DistanceLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [InstructionsBannerView.self]).valueTextColor = primaryLabelColor
DistanceLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [StepInstructionsView.self]).unitTextColor = lightGrayColor
DistanceLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [StepInstructionsView.self]).valueTextColor = darkGrayColor
DistanceRemainingLabel.appearance(for: traitCollection).textColor = lightGrayColor
DismissButton.appearance(for: traitCollection).textColor = darkGrayColor
FloatingButton.appearance(for: traitCollection).backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
FloatingButton.appearance(for: traitCollection).tintColor = blueColor
TopBannerView.appearance(for: traitCollection).backgroundColor = backgroundColor
InstructionsBannerView.appearance(for: traitCollection).backgroundColor = backgroundColor
LanesView.appearance(for: traitCollection).backgroundColor = darkBackgroundColor
LaneView.appearance(for: traitCollection).primaryColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
ManeuverView.appearance(for: traitCollection).backgroundColor = backgroundColor
ManeuverView.appearance(for: traitCollection, whenContainedInInstancesOf: [InstructionsBannerView.self]).primaryColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
ManeuverView.appearance(for: traitCollection, whenContainedInInstancesOf: [InstructionsBannerView.self]).secondaryColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
ManeuverView.appearance(for: traitCollection, whenContainedInInstancesOf: [NextBannerView.self]).primaryColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
ManeuverView.appearance(for: traitCollection, whenContainedInInstancesOf: [NextBannerView.self]).secondaryColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
ManeuverView.appearance(for: traitCollection, whenContainedInInstancesOf: [StepInstructionsView.self]).primaryColor = darkGrayColor
ManeuverView.appearance(for: traitCollection, whenContainedInInstancesOf: [StepInstructionsView.self]).secondaryColor = lightGrayColor
NextBannerView.appearance(for: traitCollection).backgroundColor = backgroundColor
NextInstructionLabel.appearance(for: traitCollection).textColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
NavigationMapView.appearance(for: traitCollection).tintColor = blueColor
NavigationMapView.appearance(for: traitCollection).routeCasingColor = #colorLiteral(red: 0.1968861222, green: 0.4148176908, blue: 0.8596113324, alpha: 1)
NavigationMapView.appearance(for: traitCollection).trafficHeavyColor = #colorLiteral(red: 0.9995597005, green: 0, blue: 0, alpha: 1)
NavigationMapView.appearance(for: traitCollection).trafficLowColor = blueColor
NavigationMapView.appearance(for: traitCollection).trafficModerateColor = #colorLiteral(red: 1, green: 0.6184511781, blue: 0, alpha: 1)
NavigationMapView.appearance(for: traitCollection).trafficSevereColor = #colorLiteral(red: 0.7458544374, green: 0.0006075350102, blue: 0, alpha: 1)
NavigationMapView.appearance(for: traitCollection).trafficUnknownColor = blueColor
// Customize the color that appears on the traversed section of a route
NavigationMapView.appearance(for: traitCollection).traversedRouteColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5)
PrimaryLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [InstructionsBannerView.self]).normalTextColor = primaryLabelColor
PrimaryLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [StepInstructionsView.self]).normalTextColor = darkGrayColor
ResumeButton.appearance(for: traitCollection).backgroundColor = secondaryBackgroundColor
ResumeButton.appearance(for: traitCollection).tintColor = blueColor
SecondaryLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [InstructionsBannerView.self]).normalTextColor = secondaryLabelColor
SecondaryLabel.appearance(for: traitCollection, whenContainedInInstancesOf: [StepInstructionsView.self]).normalTextColor = darkGrayColor
TimeRemainingLabel.appearance(for: traitCollection).textColor = lightGrayColor
TimeRemainingLabel.appearance(for: traitCollection).trafficLowColor = darkBackgroundColor
TimeRemainingLabel.appearance(for: traitCollection).trafficUnknownColor = darkGrayColor
WayNameLabel.appearance(for: traitCollection).normalTextColor = blueColor
WayNameView.appearance(for: traitCollection).backgroundColor = secondaryBackgroundColor
}
}
 
class CustomNightStyle: NightStyle {
 
private let backgroundColor = #colorLiteral(red: 0.06276176125, green: 0.6164312959, blue: 0.3432356119, alpha: 1)
private let darkBackgroundColor = #colorLiteral(red: 0.0473754704, green: 0.4980872273, blue: 0.2575169504, alpha: 1)
private let secondaryBackgroundColor = #colorLiteral(red: 0.1335069537, green: 0.133641988, blue: 0.1335278749, alpha: 1)
private let blueColor = #colorLiteral(red: 0.26683864, green: 0.5903761983, blue: 1, alpha: 1)
private let lightGrayColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
private let darkGrayColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
private let primaryTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
private let secondaryTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.9)
 
required init() {
super.init()
mapStyleURL = URL(string: "mapbox://styles/mapbox/satellite-streets-v9")!
styleType = .night
}
 
override func apply() {
super.apply()
DistanceRemainingLabel.appearance().normalTextColor = primaryTextColor
BottomBannerView.appearance().backgroundColor = secondaryBackgroundColor
FloatingButton.appearance().backgroundColor = #colorLiteral(red: 0.1434620917, green: 0.1434366405, blue: 0.1819391251, alpha: 0.9037466989)
TimeRemainingLabel.appearance().textColor = primaryTextColor
TimeRemainingLabel.appearance().trafficLowColor = primaryTextColor
TimeRemainingLabel.appearance().trafficUnknownColor = primaryTextColor
ResumeButton.appearance().backgroundColor = #colorLiteral(red: 0.1434620917, green: 0.1434366405, blue: 0.1819391251, alpha: 0.9037466989)
ResumeButton.appearance().tintColor = blueColor
}
}
