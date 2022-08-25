//
//  TbtNavigation.swift
//  MapboxNavigation5
//
//  Created by Sahas Dangol on 8/22/22.
//

import Foundation
import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation

@objc(TbtNavigation) class TbtNavigation: NSObject {
  @objc static func requiresMainQueueSetup() -> Bool { return true }
  
  @objc public func simpleMethod() {
    let origin = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 38.9131752, longitude: -77.0324047), name: "Mapbox")
    let destination = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.0365), name: "White House")
    
    // Set options
    let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
    
    Directions.shared.calculate(routeOptions) { [weak self] (session, result) in
      
        switch result {
        case .failure(let error):
            print(error.localizedDescription)
        case .success(let response):
          
          print("response: '\(response)'")
          let navigationService = MapboxNavigationService(routeResponse: response, routeIndex: 0, routeOptions: routeOptions, simulating:  .always)
          
          let navigationOptions = NavigationOptions(styles: [CustomDayStyle(), CustomNightStyle()], navigationService: navigationService)
          
          
            // Pass the generated route response to the the NavigationViewController
            let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions, navigationOptions: navigationOptions)
          
            viewController.modalPresentationStyle = .fullScreen
          viewController.routeLineTracksTraversal = true

          
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
mapStyleURL = URL(string: "mapbox://styles/mapbox/satellite-streets-v9")!
styleType = .day
}
 
override func apply() {
super.apply()
ArrivalTimeLabel.appearance().textColor = lightGrayColor
BottomBannerView.appearance().backgroundColor = secondaryBackgroundColor
Button.appearance().textColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
CancelButton.appearance().tintColor = lightGrayColor
DistanceLabel.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).unitTextColor = secondaryLabelColor
DistanceLabel.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).valueTextColor = primaryLabelColor
DistanceLabel.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).unitTextColor = lightGrayColor
DistanceLabel.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).valueTextColor = darkGrayColor
DistanceRemainingLabel.appearance().textColor = lightGrayColor
DismissButton.appearance().textColor = darkGrayColor
FloatingButton.appearance().backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
FloatingButton.appearance().tintColor = blueColor
InstructionsBannerView.appearance().backgroundColor = backgroundColor
LanesView.appearance().backgroundColor = darkBackgroundColor
LaneView.appearance().primaryColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
ManeuverView.appearance().backgroundColor = backgroundColor
ManeuverView.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).primaryColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
ManeuverView.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).secondaryColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
ManeuverView.appearance(whenContainedInInstancesOf: [NextBannerView.self]).primaryColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
ManeuverView.appearance(whenContainedInInstancesOf: [NextBannerView.self]).secondaryColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
ManeuverView.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).primaryColor = darkGrayColor
ManeuverView.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).secondaryColor = lightGrayColor
MarkerView.appearance().pinColor = blueColor
NextBannerView.appearance().backgroundColor = backgroundColor
NextInstructionLabel.appearance().textColor = #colorLiteral(red: 0.9842069745, green: 0.9843751788, blue: 0.9841964841, alpha: 1)
NavigationMapView.appearance().tintColor = blueColor
NavigationMapView.appearance().routeCasingColor = #colorLiteral(red: 0.1968861222, green: 0.4148176908, blue: 0.8596113324, alpha: 1)
NavigationMapView.appearance().trafficHeavyColor = #colorLiteral(red: 0.9995597005, green: 0, blue: 0, alpha: 1)
NavigationMapView.appearance().trafficLowColor = blueColor
NavigationMapView.appearance().trafficModerateColor = #colorLiteral(red: 1, green: 0.6184511781, blue: 0, alpha: 1)
NavigationMapView.appearance().trafficSevereColor = #colorLiteral(red: 0.7458544374, green: 0.0006075350102, blue: 0, alpha: 1)
NavigationMapView.appearance().trafficUnknownColor = blueColor
// Customize the color that appears on the traversed section of a route
NavigationMapView.appearance().traversedRouteColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.5)
PrimaryLabel.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).normalTextColor = primaryLabelColor
PrimaryLabel.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).normalTextColor = darkGrayColor
ResumeButton.appearance().backgroundColor = secondaryBackgroundColor
ResumeButton.appearance().tintColor = blueColor
SecondaryLabel.appearance(whenContainedInInstancesOf: [InstructionsBannerView.self]).normalTextColor = secondaryLabelColor
SecondaryLabel.appearance(whenContainedInInstancesOf: [StepInstructionsView.self]).normalTextColor = darkGrayColor
TimeRemainingLabel.appearance().textColor = lightGrayColor
TimeRemainingLabel.appearance().trafficLowColor = darkBackgroundColor
TimeRemainingLabel.appearance().trafficUnknownColor = darkGrayColor
WayNameLabel.appearance().normalTextColor = blueColor
WayNameView.appearance().backgroundColor = secondaryBackgroundColor
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