//
//  MYMapShowControllerView.swift
//  旅游app_useSwift
//
//  Created by zhenghuadong on 16/4/18.
//  Copyright © 2016年 zhenghuadong. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MYMapShowViewController: UIViewController,MKMapViewDelegate {
    
    var _startPlaceMark:CLPlacemark?
    var _endPlaceMark:CLPlacemark?
    var _mapkitView:MKMapView = MKMapView()
    
    func setUpStartAndEndPlaceMark(startPlaceMark:CLPlacemark,endPlaceMark:CLPlacemark) -> Void {
        
        _startPlaceMark = startPlaceMark
        _endPlaceMark = endPlaceMark
        _mapkitView.frame = self.view.bounds
        self.view .addSubview(_mapkitView)
        _mapkitView.delegate = self
//        _mapkitView.setCenterCoordinate((endPlaceMark.location?.coordinate)!, animated: true)
        let span = MKCoordinateSpanMake(0.0051109, 0.0034153);
        let region = MKCoordinateRegionMake(endPlaceMark.location!.coordinate, span);
        _mapkitView.setRegion(region, animated: true)
        _mapkitView.mapType = MKMapType.Standard
        _mapkitView.showsBuildings = true
        _mapkitView.showsTraffic = true
        let request:MKDirectionsRequest = MKDirectionsRequest()
        
        let mkStartPlace = MKPlacemark.init(placemark: startPlaceMark)
        let mkEndPlace = MKPlacemark.init(placemark: endPlaceMark)
        
        let startMapItem = MKMapItem.init(placemark: mkStartPlace)
        let endMapItem = MKMapItem.init(placemark: mkEndPlace)
        
        request.source = startMapItem
        request.destination = endMapItem
        
        
        let directions = MKDirections.init(request: request)
         directions.calculateDirectionsWithCompletionHandler { (directionsResponse: MKDirectionsResponse?, error:NSError?) in
            
            for var route:MKRoute in  (directionsResponse?.routes)!
            {
          
                 let polyline:MKPolyline = route.polyline
                 self._mapkitView .addOverlay(polyline)
            }
            
         }
       }
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        var overLayRender:MKOverlayRenderer?
        if overlay.isKindOfClass(MKPolyline) {
            let render = MKPolylineRenderer.init(overlay: overlay)
            render.lineWidth = 2
            render.strokeColor = UIColor.redColor()
            overLayRender = render
        }
        
        return overLayRender!
    }
    
}