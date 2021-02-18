// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct GeopointQuery: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - lat
  ///   - lon
  ///   - distanceMeter
  public init(lat: Double, lon: Double, distanceMeter: Swift.Optional<Double?> = nil) {
    graphQLMap = ["lat": lat, "lon": lon, "distanceMeter": distanceMeter]
  }

  public var lat: Double {
    get {
      return graphQLMap["lat"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lat")
    }
  }

  public var lon: Double {
    get {
      return graphQLMap["lon"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lon")
    }
  }

  public var distanceMeter: Swift.Optional<Double?> {
    get {
      return graphQLMap["distanceMeter"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "distanceMeter")
    }
  }
}

public final class CodesByLabelQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query CodesByLabel($first: Int = 5, $offset: Int = 0, $userId: String, $criteria: String!, $codeTypes: [String!]!, $locale: String) {
      codesByLabel(
        first: $first
        offset: $offset
        userId: $userId
        criteria: $criteria
        codeTypes: $codeTypes
        locale: $locale
      ) {
        __typename
        codes {
          __typename
          id
          longLbl
        }
      }
    }
    """

  public let operationName: String = "CodesByLabel"

  public var first: Int?
  public var offset: Int?
  public var userId: String?
  public var criteria: String
  public var codeTypes: [String]
  public var locale: String?

  public init(first: Int? = nil, offset: Int? = nil, userId: String? = nil, criteria: String, codeTypes: [String], locale: String? = nil) {
    self.first = first
    self.offset = offset
    self.userId = userId
    self.criteria = criteria
    self.codeTypes = codeTypes
    self.locale = locale
  }

  public var variables: GraphQLMap? {
    return ["first": first, "offset": offset, "userId": userId, "criteria": criteria, "codeTypes": codeTypes, "locale": locale]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("codesByLabel", arguments: ["first": GraphQLVariable("first"), "offset": GraphQLVariable("offset"), "userId": GraphQLVariable("userId"), "criteria": GraphQLVariable("criteria"), "codeTypes": GraphQLVariable("codeTypes"), "locale": GraphQLVariable("locale")], type: .object(CodesByLabel.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(codesByLabel: CodesByLabel? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "codesByLabel": codesByLabel.flatMap { (value: CodesByLabel) -> ResultMap in value.resultMap }])
    }

    /// CodesByLabel:criteria would be on longLbl code types can be Liscode
    public var codesByLabel: CodesByLabel? {
      get {
        return (resultMap["codesByLabel"] as? ResultMap).flatMap { CodesByLabel(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "codesByLabel")
      }
    }

    public struct CodesByLabel: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["CodeResult"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("codes", type: .list(.object(Code.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(codes: [Code?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "CodeResult", "codes": codes.flatMap { (value: [Code?]) -> [ResultMap?] in value.map { (value: Code?) -> ResultMap? in value.flatMap { (value: Code) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var codes: [Code?]? {
        get {
          return (resultMap["codes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Code?] in value.map { (value: ResultMap?) -> Code? in value.flatMap { (value: ResultMap) -> Code in Code(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Code?]) -> [ResultMap?] in value.map { (value: Code?) -> ResultMap? in value.flatMap { (value: Code) -> ResultMap in value.resultMap } } }, forKey: "codes")
        }
      }

      public struct Code: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Code"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(String.self)),
            GraphQLField("longLbl", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String? = nil, longLbl: String) {
          self.init(unsafeResultMap: ["__typename": "Code", "id": id, "longLbl": longLbl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String? {
          get {
            return resultMap["id"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var longLbl: String {
          get {
            return resultMap["longLbl"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "longLbl")
          }
        }
      }
    }
  }
}

public final class LabelsByCodeQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query LabelsByCode($criteria: String!, $codeTypes: [String!]!) {
      labelsByCode(criteria: $criteria, codeTypes: $codeTypes) {
        __typename
        codes {
          __typename
          id
          longLbl
        }
      }
    }
    """

  public let operationName: String = "LabelsByCode"

  public var criteria: String
  public var codeTypes: [String]

  public init(criteria: String, codeTypes: [String]) {
    self.criteria = criteria
    self.codeTypes = codeTypes
  }

  public var variables: GraphQLMap? {
    return ["criteria": criteria, "codeTypes": codeTypes]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("labelsByCode", arguments: ["criteria": GraphQLVariable("criteria"), "codeTypes": GraphQLVariable("codeTypes")], type: .object(LabelsByCode.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(labelsByCode: LabelsByCode? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "labelsByCode": labelsByCode.flatMap { (value: LabelsByCode) -> ResultMap in value.resultMap }])
    }

    /// CodesByLabel:criteria would be on longLbl code types can be Liscode
    public var labelsByCode: LabelsByCode? {
      get {
        return (resultMap["labelsByCode"] as? ResultMap).flatMap { LabelsByCode(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "labelsByCode")
      }
    }

    public struct LabelsByCode: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["CodeResult"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("codes", type: .list(.object(Code.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(codes: [Code?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "CodeResult", "codes": codes.flatMap { (value: [Code?]) -> [ResultMap?] in value.map { (value: Code?) -> ResultMap? in value.flatMap { (value: Code) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var codes: [Code?]? {
        get {
          return (resultMap["codes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Code?] in value.map { (value: ResultMap?) -> Code? in value.flatMap { (value: ResultMap) -> Code in Code(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Code?]) -> [ResultMap?] in value.map { (value: Code?) -> ResultMap? in value.flatMap { (value: Code) -> ResultMap in value.resultMap } } }, forKey: "codes")
        }
      }

      public struct Code: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Code"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(String.self)),
            GraphQLField("longLbl", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String? = nil, longLbl: String) {
          self.init(unsafeResultMap: ["__typename": "Code", "id": id, "longLbl": longLbl])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String? {
          get {
            return resultMap["id"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var longLbl: String {
          get {
            return resultMap["longLbl"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "longLbl")
          }
        }
      }
    }
  }
}

public final class IndividualsByNameQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query IndividualsByName($first: Int = 5, $offset: Int = 0, $userId: String, $criteria: String!, $locale: String) {
      individualsByName(
        first: $first
        offset: $offset
        userId: $userId
        criteria: $criteria
        locale: $locale
      ) {
        __typename
        individuals {
          __typename
          id
          firstName
          lastName
          middleName
          mailingName
          professionalType {
            __typename
            code
            label
          }
          specialties {
            __typename
            code
            label
          }
          mainActivity {
            __typename
            id
            workplace {
              __typename
              address {
                __typename
                longLabel
                buildingLabel
                county {
                  __typename
                  code
                  label
                }
                city {
                  __typename
                  code
                  label
                }
                country
                location {
                  __typename
                  lat
                  lon
                }
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "IndividualsByName"

  public var first: Int?
  public var offset: Int?
  public var userId: String?
  public var criteria: String
  public var locale: String?

  public init(first: Int? = nil, offset: Int? = nil, userId: String? = nil, criteria: String, locale: String? = nil) {
    self.first = first
    self.offset = offset
    self.userId = userId
    self.criteria = criteria
    self.locale = locale
  }

  public var variables: GraphQLMap? {
    return ["first": first, "offset": offset, "userId": userId, "criteria": criteria, "locale": locale]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("individualsByName", arguments: ["first": GraphQLVariable("first"), "offset": GraphQLVariable("offset"), "userId": GraphQLVariable("userId"), "criteria": GraphQLVariable("criteria"), "locale": GraphQLVariable("locale")], type: .object(IndividualsByName.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(individualsByName: IndividualsByName? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "individualsByName": individualsByName.flatMap { (value: IndividualsByName) -> ResultMap in value.resultMap }])
    }

    public var individualsByName: IndividualsByName? {
      get {
        return (resultMap["individualsByName"] as? ResultMap).flatMap { IndividualsByName(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "individualsByName")
      }
    }

    public struct IndividualsByName: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["IndividualResult"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("individuals", type: .list(.object(Individual.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(individuals: [Individual?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "IndividualResult", "individuals": individuals.flatMap { (value: [Individual?]) -> [ResultMap?] in value.map { (value: Individual?) -> ResultMap? in value.flatMap { (value: Individual) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var individuals: [Individual?]? {
        get {
          return (resultMap["individuals"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Individual?] in value.map { (value: ResultMap?) -> Individual? in value.flatMap { (value: ResultMap) -> Individual in Individual(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Individual?]) -> [ResultMap?] in value.map { (value: Individual?) -> ResultMap? in value.flatMap { (value: Individual) -> ResultMap in value.resultMap } } }, forKey: "individuals")
        }
      }

      public struct Individual: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["IndividualWorkPlaceDetails"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
            GraphQLField("middleName", type: .scalar(String.self)),
            GraphQLField("mailingName", type: .scalar(String.self)),
            GraphQLField("professionalType", type: .nonNull(.object(ProfessionalType.selections))),
            GraphQLField("specialties", type: .nonNull(.list(.nonNull(.object(Specialty.selections))))),
            GraphQLField("mainActivity", type: .nonNull(.object(MainActivity.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, firstName: String? = nil, lastName: String, middleName: String? = nil, mailingName: String? = nil, professionalType: ProfessionalType, specialties: [Specialty], mainActivity: MainActivity) {
          self.init(unsafeResultMap: ["__typename": "IndividualWorkPlaceDetails", "id": id, "firstName": firstName, "lastName": lastName, "middleName": middleName, "mailingName": mailingName, "professionalType": professionalType.resultMap, "specialties": specialties.map { (value: Specialty) -> ResultMap in value.resultMap }, "mainActivity": mainActivity.resultMap])
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

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String {
          get {
            return resultMap["lastName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var middleName: String? {
          get {
            return resultMap["middleName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "middleName")
          }
        }

        public var mailingName: String? {
          get {
            return resultMap["mailingName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "mailingName")
          }
        }

        public var professionalType: ProfessionalType {
          get {
            return ProfessionalType(unsafeResultMap: resultMap["professionalType"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "professionalType")
          }
        }

        public var specialties: [Specialty] {
          get {
            return (resultMap["specialties"] as! [ResultMap]).map { (value: ResultMap) -> Specialty in Specialty(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Specialty) -> ResultMap in value.resultMap }, forKey: "specialties")
          }
        }

        public var mainActivity: MainActivity {
          get {
            return MainActivity(unsafeResultMap: resultMap["mainActivity"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "mainActivity")
          }
        }

        public struct ProfessionalType: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KeyedString"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("code", type: .nonNull(.scalar(String.self))),
              GraphQLField("label", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(code: String, label: String) {
            self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A unique key that can be used to identify this string
          public var code: String {
            get {
              return resultMap["code"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "code")
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

        public struct Specialty: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KeyedString"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("code", type: .nonNull(.scalar(String.self))),
              GraphQLField("label", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(code: String, label: String) {
            self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A unique key that can be used to identify this string
          public var code: String {
            get {
              return resultMap["code"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "code")
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

        public struct MainActivity: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Activity"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("workplace", type: .nonNull(.object(Workplace.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, workplace: Workplace) {
            self.init(unsafeResultMap: ["__typename": "Activity", "id": id, "workplace": workplace.resultMap])
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

          public var workplace: Workplace {
            get {
              return Workplace(unsafeResultMap: resultMap["workplace"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "workplace")
            }
          }

          public struct Workplace: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Workplace"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("address", type: .nonNull(.object(Address.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(address: Address) {
              self.init(unsafeResultMap: ["__typename": "Workplace", "address": address.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
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
                  GraphQLField("buildingLabel", type: .scalar(String.self)),
                  GraphQLField("county", type: .object(County.selections)),
                  GraphQLField("city", type: .nonNull(.object(City.selections))),
                  GraphQLField("country", type: .nonNull(.scalar(String.self))),
                  GraphQLField("location", type: .object(Location.selections)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(longLabel: String, buildingLabel: String? = nil, county: County? = nil, city: City, country: String, location: Location? = nil) {
                self.init(unsafeResultMap: ["__typename": "Address", "longLabel": longLabel, "buildingLabel": buildingLabel, "county": county.flatMap { (value: County) -> ResultMap in value.resultMap }, "city": city.resultMap, "country": country, "location": location.flatMap { (value: Location) -> ResultMap in value.resultMap }])
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

              public var buildingLabel: String? {
                get {
                  return resultMap["buildingLabel"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "buildingLabel")
                }
              }

              public var county: County? {
                get {
                  return (resultMap["county"] as? ResultMap).flatMap { County(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "county")
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

              public var country: String {
                get {
                  return resultMap["country"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "country")
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

              public struct County: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["KeyedString"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("code", type: .nonNull(.scalar(String.self))),
                    GraphQLField("label", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(code: String, label: String) {
                  self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// A unique key that can be used to identify this string
                public var code: String {
                  get {
                    return resultMap["code"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "code")
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

              public struct City: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["KeyedString"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("code", type: .nonNull(.scalar(String.self))),
                    GraphQLField("label", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(code: String, label: String) {
                  self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// A unique key that can be used to identify this string
                public var code: String {
                  get {
                    return resultMap["code"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "code")
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
                    GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(lat: Double, lon: Double) {
                  self.init(unsafeResultMap: ["__typename": "Geopoint", "lat": lat, "lon": lon])
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

                public var lon: Double {
                  get {
                    return resultMap["lon"]! as! Double
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "lon")
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class ActivitiesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Activities($first: Int = 10, $offset: Int = 0, $userId: String, $locale: String, $professionalType: String, $specialties: [String!], $county: String, $criteria: String, $location: GeopointQuery) {
      activities(
        first: $first
        offset: $offset
        userId: $userId
        locale: $locale
        professionalType: $professionalType
        specialties: $specialties
        county: $county
        criteria: $criteria
        location: $location
      ) {
        __typename
        distance
        relevance
        activity {
          __typename
          id
          individual {
            __typename
            id
            firstName
            lastName
            middleName
            mailingName
            professionalType {
              __typename
              code
              label
            }
            specialties {
              __typename
              code
              label
            }
          }
          workplace {
            __typename
            address {
              __typename
              longLabel
              buildingLabel
              county {
                __typename
                code
                label
              }
              city {
                __typename
                code
                label
              }
              country
              location {
                __typename
                lat
                lon
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "Activities"

  public var first: Int?
  public var offset: Int?
  public var userId: String?
  public var locale: String?
  public var professionalType: String?
  public var specialties: [String]?
  public var county: String?
  public var criteria: String?
  public var location: GeopointQuery?

  public init(first: Int? = nil, offset: Int? = nil, userId: String? = nil, locale: String? = nil, professionalType: String? = nil, specialties: [String]?, county: String? = nil, criteria: String? = nil, location: GeopointQuery? = nil) {
    self.first = first
    self.offset = offset
    self.userId = userId
    self.locale = locale
    self.professionalType = professionalType
    self.specialties = specialties
    self.county = county
    self.criteria = criteria
    self.location = location
  }

  public var variables: GraphQLMap? {
    return ["first": first, "offset": offset, "userId": userId, "locale": locale, "professionalType": professionalType, "specialties": specialties, "county": county, "criteria": criteria, "location": location]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("activities", arguments: ["first": GraphQLVariable("first"), "offset": GraphQLVariable("offset"), "userId": GraphQLVariable("userId"), "locale": GraphQLVariable("locale"), "professionalType": GraphQLVariable("professionalType"), "specialties": GraphQLVariable("specialties"), "county": GraphQLVariable("county"), "criteria": GraphQLVariable("criteria"), "location": GraphQLVariable("location")], type: .list(.object(Activity.selections))),
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
          GraphQLField("distance", type: .scalar(Double.self)),
          GraphQLField("relevance", type: .scalar(Int.self)),
          GraphQLField("activity", type: .nonNull(.object(Activity.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(distance: Double? = nil, relevance: Int? = nil, activity: Activity) {
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

      public var distance: Double? {
        get {
          return resultMap["distance"] as? Double
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
            GraphQLField("individual", type: .nonNull(.object(Individual.selections))),
            GraphQLField("workplace", type: .nonNull(.object(Workplace.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, individual: Individual, workplace: Workplace) {
          self.init(unsafeResultMap: ["__typename": "ActivityFragment", "id": id, "individual": individual.resultMap, "workplace": workplace.resultMap])
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

        public var individual: Individual {
          get {
            return Individual(unsafeResultMap: resultMap["individual"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "individual")
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

        public struct Individual: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["IndividualFragment"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("firstName", type: .scalar(String.self)),
              GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
              GraphQLField("middleName", type: .scalar(String.self)),
              GraphQLField("mailingName", type: .scalar(String.self)),
              GraphQLField("professionalType", type: .nonNull(.object(ProfessionalType.selections))),
              GraphQLField("specialties", type: .nonNull(.list(.nonNull(.object(Specialty.selections))))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, firstName: String? = nil, lastName: String, middleName: String? = nil, mailingName: String? = nil, professionalType: ProfessionalType, specialties: [Specialty]) {
            self.init(unsafeResultMap: ["__typename": "IndividualFragment", "id": id, "firstName": firstName, "lastName": lastName, "middleName": middleName, "mailingName": mailingName, "professionalType": professionalType.resultMap, "specialties": specialties.map { (value: Specialty) -> ResultMap in value.resultMap }])
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

          public var firstName: String? {
            get {
              return resultMap["firstName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "firstName")
            }
          }

          public var lastName: String {
            get {
              return resultMap["lastName"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "lastName")
            }
          }

          public var middleName: String? {
            get {
              return resultMap["middleName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "middleName")
            }
          }

          public var mailingName: String? {
            get {
              return resultMap["mailingName"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "mailingName")
            }
          }

          public var professionalType: ProfessionalType {
            get {
              return ProfessionalType(unsafeResultMap: resultMap["professionalType"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "professionalType")
            }
          }

          public var specialties: [Specialty] {
            get {
              return (resultMap["specialties"] as! [ResultMap]).map { (value: ResultMap) -> Specialty in Specialty(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Specialty) -> ResultMap in value.resultMap }, forKey: "specialties")
            }
          }

          public struct ProfessionalType: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["KeyedString"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("code", type: .nonNull(.scalar(String.self))),
                GraphQLField("label", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(code: String, label: String) {
              self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A unique key that can be used to identify this string
            public var code: String {
              get {
                return resultMap["code"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "code")
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

          public struct Specialty: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["KeyedString"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("code", type: .nonNull(.scalar(String.self))),
                GraphQLField("label", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(code: String, label: String) {
              self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A unique key that can be used to identify this string
            public var code: String {
              get {
                return resultMap["code"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "code")
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
        }

        public struct Workplace: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Workplace"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("address", type: .nonNull(.object(Address.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(address: Address) {
            self.init(unsafeResultMap: ["__typename": "Workplace", "address": address.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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
                GraphQLField("buildingLabel", type: .scalar(String.self)),
                GraphQLField("county", type: .object(County.selections)),
                GraphQLField("city", type: .nonNull(.object(City.selections))),
                GraphQLField("country", type: .nonNull(.scalar(String.self))),
                GraphQLField("location", type: .object(Location.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(longLabel: String, buildingLabel: String? = nil, county: County? = nil, city: City, country: String, location: Location? = nil) {
              self.init(unsafeResultMap: ["__typename": "Address", "longLabel": longLabel, "buildingLabel": buildingLabel, "county": county.flatMap { (value: County) -> ResultMap in value.resultMap }, "city": city.resultMap, "country": country, "location": location.flatMap { (value: Location) -> ResultMap in value.resultMap }])
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

            public var buildingLabel: String? {
              get {
                return resultMap["buildingLabel"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "buildingLabel")
              }
            }

            public var county: County? {
              get {
                return (resultMap["county"] as? ResultMap).flatMap { County(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "county")
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

            public var country: String {
              get {
                return resultMap["country"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "country")
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

            public struct County: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["KeyedString"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("code", type: .nonNull(.scalar(String.self))),
                  GraphQLField("label", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(code: String, label: String) {
                self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A unique key that can be used to identify this string
              public var code: String {
                get {
                  return resultMap["code"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "code")
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

            public struct City: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["KeyedString"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("code", type: .nonNull(.scalar(String.self))),
                  GraphQLField("label", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(code: String, label: String) {
                self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// A unique key that can be used to identify this string
              public var code: String {
                get {
                  return resultMap["code"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "code")
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
                  GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(lat: Double, lon: Double) {
                self.init(unsafeResultMap: ["__typename": "Geopoint", "lat": lat, "lon": lon])
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

              public var lon: Double {
                get {
                  return resultMap["lon"]! as! Double
                }
                set {
                  resultMap.updateValue(newValue, forKey: "lon")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class ActivityByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ActivityByID($userId: String, $id: ID!, $locale: String) {
      activityByID(userId: $userId, id: $id, locale: $locale) {
        __typename
        id
        phone
        fax
        webAddress
        individual {
          __typename
          id
          title {
            __typename
            code
            label
          }
          firstName
          lastName
          middleName
          mailingName
          professionalType {
            __typename
            code
            label
          }
          specialties {
            __typename
            code
            label
          }
          mainActivity {
            __typename
            id
            workplace {
              __typename
              address {
                __typename
                longLabel
                buildingLabel
                county {
                  __typename
                  code
                  label
                }
                city {
                  __typename
                  code
                  label
                }
                country
                location {
                  __typename
                  lat
                  lon
                }
              }
            }
          }
          otherActivities {
            __typename
            id
            workplace {
              __typename
              address {
                __typename
                longLabel
                buildingLabel
                county {
                  __typename
                  code
                  label
                }
                city {
                  __typename
                  code
                  label
                }
                country
                location {
                  __typename
                  lat
                  lon
                }
              }
            }
          }
        }
        workplace {
          __typename
          name
          officialName
          address {
            __typename
            longLabel
            buildingLabel
            county {
              __typename
              code
              label
            }
            city {
              __typename
              code
              label
            }
            country
            postalCode
            location {
              __typename
              lat
              lon
            }
          }
        }
      }
    }
    """

  public let operationName: String = "ActivityByID"

  public var userId: String?
  public var id: GraphQLID
  public var locale: String?

  public init(userId: String? = nil, id: GraphQLID, locale: String? = nil) {
    self.userId = userId
    self.id = id
    self.locale = locale
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "id": id, "locale": locale]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("activityByID", arguments: ["userId": GraphQLVariable("userId"), "id": GraphQLVariable("id"), "locale": GraphQLVariable("locale")], type: .object(ActivityById.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(activityById: ActivityById? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "activityByID": activityById.flatMap { (value: ActivityById) -> ResultMap in value.resultMap }])
    }

    public var activityById: ActivityById? {
      get {
        return (resultMap["activityByID"] as? ResultMap).flatMap { ActivityById(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "activityByID")
      }
    }

    public struct ActivityById: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Activity"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("phone", type: .scalar(String.self)),
          GraphQLField("fax", type: .scalar(String.self)),
          GraphQLField("webAddress", type: .scalar(String.self)),
          GraphQLField("individual", type: .nonNull(.object(Individual.selections))),
          GraphQLField("workplace", type: .nonNull(.object(Workplace.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, phone: String? = nil, fax: String? = nil, webAddress: String? = nil, individual: Individual, workplace: Workplace) {
        self.init(unsafeResultMap: ["__typename": "Activity", "id": id, "phone": phone, "fax": fax, "webAddress": webAddress, "individual": individual.resultMap, "workplace": workplace.resultMap])
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

      public var individual: Individual {
        get {
          return Individual(unsafeResultMap: resultMap["individual"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "individual")
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

      public struct Individual: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Individual"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("title", type: .nonNull(.object(Title.selections))),
            GraphQLField("firstName", type: .scalar(String.self)),
            GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
            GraphQLField("middleName", type: .scalar(String.self)),
            GraphQLField("mailingName", type: .scalar(String.self)),
            GraphQLField("professionalType", type: .nonNull(.object(ProfessionalType.selections))),
            GraphQLField("specialties", type: .nonNull(.list(.nonNull(.object(Specialty.selections))))),
            GraphQLField("mainActivity", type: .nonNull(.object(MainActivity.selections))),
            GraphQLField("otherActivities", type: .nonNull(.list(.nonNull(.object(OtherActivity.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, title: Title, firstName: String? = nil, lastName: String, middleName: String? = nil, mailingName: String? = nil, professionalType: ProfessionalType, specialties: [Specialty], mainActivity: MainActivity, otherActivities: [OtherActivity]) {
          self.init(unsafeResultMap: ["__typename": "Individual", "id": id, "title": title.resultMap, "firstName": firstName, "lastName": lastName, "middleName": middleName, "mailingName": mailingName, "professionalType": professionalType.resultMap, "specialties": specialties.map { (value: Specialty) -> ResultMap in value.resultMap }, "mainActivity": mainActivity.resultMap, "otherActivities": otherActivities.map { (value: OtherActivity) -> ResultMap in value.resultMap }])
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

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String {
          get {
            return resultMap["lastName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var middleName: String? {
          get {
            return resultMap["middleName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "middleName")
          }
        }

        public var mailingName: String? {
          get {
            return resultMap["mailingName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "mailingName")
          }
        }

        public var professionalType: ProfessionalType {
          get {
            return ProfessionalType(unsafeResultMap: resultMap["professionalType"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "professionalType")
          }
        }

        public var specialties: [Specialty] {
          get {
            return (resultMap["specialties"] as! [ResultMap]).map { (value: ResultMap) -> Specialty in Specialty(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Specialty) -> ResultMap in value.resultMap }, forKey: "specialties")
          }
        }

        public var mainActivity: MainActivity {
          get {
            return MainActivity(unsafeResultMap: resultMap["mainActivity"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "mainActivity")
          }
        }

        public var otherActivities: [OtherActivity] {
          get {
            return (resultMap["otherActivities"] as! [ResultMap]).map { (value: ResultMap) -> OtherActivity in OtherActivity(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: OtherActivity) -> ResultMap in value.resultMap }, forKey: "otherActivities")
          }
        }

        public struct Title: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KeyedString"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("code", type: .nonNull(.scalar(String.self))),
              GraphQLField("label", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(code: String, label: String) {
            self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A unique key that can be used to identify this string
          public var code: String {
            get {
              return resultMap["code"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "code")
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

        public struct ProfessionalType: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KeyedString"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("code", type: .nonNull(.scalar(String.self))),
              GraphQLField("label", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(code: String, label: String) {
            self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A unique key that can be used to identify this string
          public var code: String {
            get {
              return resultMap["code"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "code")
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

        public struct Specialty: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["KeyedString"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("code", type: .nonNull(.scalar(String.self))),
              GraphQLField("label", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(code: String, label: String) {
            self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A unique key that can be used to identify this string
          public var code: String {
            get {
              return resultMap["code"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "code")
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

        public struct MainActivity: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ActivityList"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("workplace", type: .nonNull(.object(Workplace.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, workplace: Workplace) {
            self.init(unsafeResultMap: ["__typename": "ActivityList", "id": id, "workplace": workplace.resultMap])
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

          public var workplace: Workplace {
            get {
              return Workplace(unsafeResultMap: resultMap["workplace"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "workplace")
            }
          }

          public struct Workplace: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Workplace"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("address", type: .nonNull(.object(Address.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(address: Address) {
              self.init(unsafeResultMap: ["__typename": "Workplace", "address": address.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
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
                  GraphQLField("buildingLabel", type: .scalar(String.self)),
                  GraphQLField("county", type: .object(County.selections)),
                  GraphQLField("city", type: .nonNull(.object(City.selections))),
                  GraphQLField("country", type: .nonNull(.scalar(String.self))),
                  GraphQLField("location", type: .object(Location.selections)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(longLabel: String, buildingLabel: String? = nil, county: County? = nil, city: City, country: String, location: Location? = nil) {
                self.init(unsafeResultMap: ["__typename": "Address", "longLabel": longLabel, "buildingLabel": buildingLabel, "county": county.flatMap { (value: County) -> ResultMap in value.resultMap }, "city": city.resultMap, "country": country, "location": location.flatMap { (value: Location) -> ResultMap in value.resultMap }])
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

              public var buildingLabel: String? {
                get {
                  return resultMap["buildingLabel"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "buildingLabel")
                }
              }

              public var county: County? {
                get {
                  return (resultMap["county"] as? ResultMap).flatMap { County(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "county")
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

              public var country: String {
                get {
                  return resultMap["country"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "country")
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

              public struct County: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["KeyedString"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("code", type: .nonNull(.scalar(String.self))),
                    GraphQLField("label", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(code: String, label: String) {
                  self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// A unique key that can be used to identify this string
                public var code: String {
                  get {
                    return resultMap["code"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "code")
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

              public struct City: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["KeyedString"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("code", type: .nonNull(.scalar(String.self))),
                    GraphQLField("label", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(code: String, label: String) {
                  self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// A unique key that can be used to identify this string
                public var code: String {
                  get {
                    return resultMap["code"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "code")
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
                    GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(lat: Double, lon: Double) {
                  self.init(unsafeResultMap: ["__typename": "Geopoint", "lat": lat, "lon": lon])
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

                public var lon: Double {
                  get {
                    return resultMap["lon"]! as! Double
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "lon")
                  }
                }
              }
            }
          }
        }

        public struct OtherActivity: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ActivityList"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("workplace", type: .nonNull(.object(Workplace.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, workplace: Workplace) {
            self.init(unsafeResultMap: ["__typename": "ActivityList", "id": id, "workplace": workplace.resultMap])
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

          public var workplace: Workplace {
            get {
              return Workplace(unsafeResultMap: resultMap["workplace"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "workplace")
            }
          }

          public struct Workplace: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Workplace"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("address", type: .nonNull(.object(Address.selections))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(address: Address) {
              self.init(unsafeResultMap: ["__typename": "Workplace", "address": address.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
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
                  GraphQLField("buildingLabel", type: .scalar(String.self)),
                  GraphQLField("county", type: .object(County.selections)),
                  GraphQLField("city", type: .nonNull(.object(City.selections))),
                  GraphQLField("country", type: .nonNull(.scalar(String.self))),
                  GraphQLField("location", type: .object(Location.selections)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(longLabel: String, buildingLabel: String? = nil, county: County? = nil, city: City, country: String, location: Location? = nil) {
                self.init(unsafeResultMap: ["__typename": "Address", "longLabel": longLabel, "buildingLabel": buildingLabel, "county": county.flatMap { (value: County) -> ResultMap in value.resultMap }, "city": city.resultMap, "country": country, "location": location.flatMap { (value: Location) -> ResultMap in value.resultMap }])
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

              public var buildingLabel: String? {
                get {
                  return resultMap["buildingLabel"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "buildingLabel")
                }
              }

              public var county: County? {
                get {
                  return (resultMap["county"] as? ResultMap).flatMap { County(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "county")
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

              public var country: String {
                get {
                  return resultMap["country"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "country")
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

              public struct County: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["KeyedString"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("code", type: .nonNull(.scalar(String.self))),
                    GraphQLField("label", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(code: String, label: String) {
                  self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// A unique key that can be used to identify this string
                public var code: String {
                  get {
                    return resultMap["code"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "code")
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

              public struct City: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["KeyedString"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("code", type: .nonNull(.scalar(String.self))),
                    GraphQLField("label", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(code: String, label: String) {
                  self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// A unique key that can be used to identify this string
                public var code: String {
                  get {
                    return resultMap["code"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "code")
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
                    GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(lat: Double, lon: Double) {
                  self.init(unsafeResultMap: ["__typename": "Geopoint", "lat": lat, "lon": lon])
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

                public var lon: Double {
                  get {
                    return resultMap["lon"]! as! Double
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "lon")
                  }
                }
              }
            }
          }
        }
      }

      public struct Workplace: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Workplace"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("officialName", type: .scalar(String.self)),
            GraphQLField("address", type: .nonNull(.object(Address.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, officialName: String? = nil, address: Address) {
          self.init(unsafeResultMap: ["__typename": "Workplace", "name": name, "officialName": officialName, "address": address.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public var officialName: String? {
          get {
            return resultMap["officialName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "officialName")
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
              GraphQLField("buildingLabel", type: .scalar(String.self)),
              GraphQLField("county", type: .object(County.selections)),
              GraphQLField("city", type: .nonNull(.object(City.selections))),
              GraphQLField("country", type: .nonNull(.scalar(String.self))),
              GraphQLField("postalCode", type: .nonNull(.scalar(String.self))),
              GraphQLField("location", type: .object(Location.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(longLabel: String, buildingLabel: String? = nil, county: County? = nil, city: City, country: String, postalCode: String, location: Location? = nil) {
            self.init(unsafeResultMap: ["__typename": "Address", "longLabel": longLabel, "buildingLabel": buildingLabel, "county": county.flatMap { (value: County) -> ResultMap in value.resultMap }, "city": city.resultMap, "country": country, "postalCode": postalCode, "location": location.flatMap { (value: Location) -> ResultMap in value.resultMap }])
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

          public var buildingLabel: String? {
            get {
              return resultMap["buildingLabel"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "buildingLabel")
            }
          }

          public var county: County? {
            get {
              return (resultMap["county"] as? ResultMap).flatMap { County(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "county")
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

          public var country: String {
            get {
              return resultMap["country"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "country")
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

          public struct County: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["KeyedString"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("code", type: .nonNull(.scalar(String.self))),
                GraphQLField("label", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(code: String, label: String) {
              self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A unique key that can be used to identify this string
            public var code: String {
              get {
                return resultMap["code"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "code")
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

          public struct City: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["KeyedString"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("code", type: .nonNull(.scalar(String.self))),
                GraphQLField("label", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(code: String, label: String) {
              self.init(unsafeResultMap: ["__typename": "KeyedString", "code": code, "label": label])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// A unique key that can be used to identify this string
            public var code: String {
              get {
                return resultMap["code"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "code")
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
                GraphQLField("lon", type: .nonNull(.scalar(Double.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(lat: Double, lon: Double) {
              self.init(unsafeResultMap: ["__typename": "Geopoint", "lat": lat, "lon": lon])
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

            public var lon: Double {
              get {
                return resultMap["lon"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "lon")
              }
            }
          }
        }
      }
    }
  }
}
