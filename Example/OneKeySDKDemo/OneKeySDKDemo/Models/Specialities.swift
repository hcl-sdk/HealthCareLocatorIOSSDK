//
//  Specialities.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 12/25/20.
//

import Foundation

enum Specialities: CaseIterable {
   case RegisteredPracticalNurse
   case FamilyMedicine
   case Neurosurgery
   
   var code: String {
       switch self {
       case .RegisteredPracticalNurse: return "SP.WCA.RN"
       case .FamilyMedicine: return "SP.WCA.3C"
       case .Neurosurgery: return "SP.WCA.37"
       }
   }
}
