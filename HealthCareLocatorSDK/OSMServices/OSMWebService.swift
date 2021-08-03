//
//  OSMWebService.swift
//  HealthCareLocatorSDK
//
//  Created by tanphat on 02/08/2021.
//

import Foundation
import MapKit

class OSMWebService {
    
    class func getBoundingbox(from centerPoint: CLLocationCoordinate2D, completion: @escaping (OSMModel?, Error?) -> Void) {
        let baseURL = String(format: kOSMBaseURL, "\(centerPoint.latitude)", "\(centerPoint.longitude)")
        guard let url = URL(string: baseURL) else { return }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let err = error {
                completion(nil, err)
            }
            do {
                guard let data = data else {
                    completion(nil, nil)
                    return
                }
                let decoder = JSONDecoder()
                let result = try decoder.decode(OSMModel.self, from: data)
                DispatchQueue.main.async {
                    completion(result, nil)
                }
            } catch {
                print("### error")
                completion(nil, error)
            }
        })
        task.resume()
    }
}
