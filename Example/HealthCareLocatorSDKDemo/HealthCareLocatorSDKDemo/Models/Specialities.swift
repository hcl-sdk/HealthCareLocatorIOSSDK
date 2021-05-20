//
//  Specialities.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 12/25/20.
//

import Foundation

enum Specialities: CaseIterable {
   case Cardiology
   case InternalMedicine
   
   var code: String {
       switch self {
       case .Cardiology: return "SP.WCA.08"
       case .InternalMedicine: return "1SP.2900"
       }
   }
}
