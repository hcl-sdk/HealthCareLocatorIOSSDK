// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ActivitiesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Activities($apiKey: String!, $criteria: String!) {
      activities(apiKey: $apiKey, criteria: $criteria) {
        __typename
        distance
        relevance
        activity {
          __typename
          id
          title {
            __typename
            label
          }
          role {
            __typename
            label
          }
          phone
          fax
          webAddress
          workplace {
            __typename
            id
            name
            localPhone
            address {
              __typename
              longLabel
              city {
                __typename
                label
              }
              country {
                __typename
                label
              }
              postalCode
              location {
                __typename
                lat
                long
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "Activities"

  public var apiKey: String
  public var criteria: String

  public init(apiKey: String, criteria: String) {
    self.apiKey = apiKey
    self.criteria = criteria
  }

  public var variables: GraphQLMap? {
    return ["apiKey": apiKey, "criteria": criteria]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("activities", arguments: ["apiKey": GraphQLVariable("apiKey"), "criteria": GraphQLVariable("criteria")], type: .list(.object(Activity.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(activities: [Activity?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "activities": activities.flatMap { (value: [Activity?]) -> [ResultMap?] in value.map { (value: Activity?) -> ResultMap? in value.flatMap { (value: Activity) -> ResultMap in value.resultMap } } }])
    }

    public var activities: [Activity?]? {
      get {
        return (resultMap["activities"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Activity?] in value.map { (value: ResultMap?) -> Activity? in value.flatMap { (value: ResultMap) -> Activity in Activity(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Activity?]) -> [ResultMap?] in value.map { (value: Activity?) -> ResultMap? in value.flatMap { (value: Activity) -> ResultMap in value.resultMap } } }, forKey: "activities")
      }
    }

    public struct Activity: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ActivityResult"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("distance", type: .scalar(Int.self)),
          GraphQLField("relevance", type: .scalar(Int.self)),
          GraphQLField("activity", type: .nonNull(.object(Activity.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(distance: Int? = nil, relevance: Int? = nil, activity: Activity) {
        self.init(unsafeResultMap: ["__typename": "ActivityResult", "distance": distance, "relevance": relevance, "activity": activity.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var distance: Int? {
        get {
          return resultMap["distance"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "distance")
        }
      }

      public var relevance: Int? {
        get {
          return resultMap["relevance"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "relevance")
        }
      }

      public var activity: Activity {
        get {
          return Activity(unsafeResultMap: resultMap["activity"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "activity")
        }
      }

      public struct Activity: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ActivityFragment"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("title", type: .nonNull(.object(Title.selections))),
            GraphQLField("role", type: .nonNull(.object(Role.selections))),
            GraphQLField("phone", type: .scalar(String.self)),
            GraphQLField("fax", type: .scalar(String.self)),
            GraphQLField("webAddress", type: .scalar(String.self)),
            GraphQLField("workplace", type: .nonNull(.object(Workplace.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: Title, role: Role, phone: String? = nil, fax: String? = nil, webAddress: String? = nil, workplace: Workplace) {
          self.init(unsafeResultMap: ["__typename": "ActivityFragment", "id": id, "title": title.resultMap, "role": role.resultMap, "phone": phone, "fax": fax, "webAddress": webAddress, "workplace": workplace.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: Title {
          get {
            return Title(unsafeResultMap: resultMap["title"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "title")
          }
        }

        public var role: Role {
          get {
            return Role(unsafeResultMap: resultMap["role"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "role")
          }
        }

        public var phone: String? {
          get {
            return resultMap["phone"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "phone")
          }
        }

        public var fax: String? {
          get {
            return resultMap["fax"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "fax")
          }
        }

        public var webAddress: String? {
          get {
            return resultMap["webAddress"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "webAddress")
          }
        }

        public var workplace: Workplace {
          get {
            return Workplace(unsafeResultMap: resultMap["workplace"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "workplace")
          }
        }

        public struct Title: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KeyedString"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("label", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(label: String) {
            self.init(unsafeResultMap: ["__typename": "KeyedString", "label": label])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Contains the label corresponding to this key expressed in the requested locale ( refer to query )
          public var label: String {
            get {
              return resultMap["label"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "label")
            }
          }
        }

        public struct Role: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KeyedString"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("label", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(label: String) {
            self.init(unsafeResultMap: ["__typename": "KeyedString", "label": label])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Contains the label corresponding to this key expressed in the requested locale ( refer to query )
          public var label: String {
            get {
              return resultMap["label"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "label")
            }
          }
        }

        public struct Workplace: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Workplace"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("localPhone", type: .scalar(String.self)),
              GraphQLField("address", type: .nonNull(.object(Address.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, localPhone: String? = nil, address: Address) {
            self.init(unsafeResultMap: ["__typename": "Workplace", "id": id, "name": name, "localPhone": localPhone, "address": address.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var localPhone: String? {
            get {
              return resultMap["localPhone"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "localPhone")
            }
          }

          public var address: Address {
            get {
              return Address(unsafeResultMap: resultMap["address"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "address")
            }
          }

          public struct Address: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Address"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("longLabel", type: .nonNull(.scalar(String.self))),
                GraphQLField("city", type: .nonNull(.object(City.selections))),
                GraphQLField("country", type: .nonNull(.object(Country.selections))),
                GraphQLField("postalCode", type: .nonNull(.scalar(String.self))),
                GraphQLField("location", type: .object(Location.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(longLabel: String, city: City, country: Country, postalCode: String, location: Location? = nil) {
              self.init(unsafeResultMap: ["__typename": "Address", "longLabel": longLabel, "city": city.resultMap, "country": country.resultMap, "postalCode": postalCode, "location": location.flatMap { (value: Location) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var longLabel: String {
              get {
                return resultMap["longLabel"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "longLabel")
              }
            }

            public var city: City {
              get {
                return City(unsafeResultMap: resultMap["city"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "city")
              }
            }

            public var country: Country {
              get {
                return Country(unsafeResultMap: resultMap["country"]! as! ResultMap)
              }
              set {
                resultMap.updateValue(newValue.resultMap, forKey: "country")
              }
            }

            public var postalCode: String {
              get {
                return resultMap["postalCode"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "postalCode")
              }
            }

            public var location: Location? {
              get {
                return (resultMap["location"] as? ResultMap).flatMap { Location(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "location")
              }
            }

            public struct City: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["KeyedString"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("label", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(label: String) {
                self.init(unsafeResultMap: ["__typename": "KeyedString", "label": label])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Contains the label corresponding to this key expressed in the requested locale ( refer to query )
              public var label: String {
                get {
                  return resultMap["label"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "label")
                }
              }
            }

            public struct Country: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["KeyedString"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("label", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(label: String) {
                self.init(unsafeResultMap: ["__typename": "KeyedString", "label": label])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Contains the label corresponding to this key expressed in the requested locale ( refer to query )
              public var label: String {
                get {
                  return resultMap["label"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "label")
                }
              }
            }

            public struct Location: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Geopoint"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
                  GraphQLField("long", type: .nonNull(.scalar(Double.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(lat: Double, long: Double) {
                self.init(unsafeResultMap: ["__typename": "Geopoint", "lat": lat, "long": long])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var lat: Double {
                get {
                  return resultMap["lat"]! as! Double
                }
                set {
                  resultMap.updateValue(newValue, forKey: "lat")
                }
              }

              public var long: Double {
                get {
                  return resultMap["long"]! as! Double
                }
                set {
                  resultMap.updateValue(newValue, forKey: "long")
                }
              }
            }
          }
        }
      }
    }
  }
}
