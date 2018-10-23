//  This file was automatically generated and should not be edited.

import Apollo

public final class GetViewerQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetViewer {\n  viewer {\n    __typename\n    ...UserDetails\n    annictId\n    backgroundImageUrl\n    recordsCount\n    description\n    followingsCount\n    followersCount\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(UserDetails.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("viewer", type: .object(Viewer.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(viewer: Viewer? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "viewer": viewer.flatMap { (value: Viewer) -> ResultMap in value.resultMap }])
    }

    public var viewer: Viewer? {
      get {
        return (resultMap["viewer"] as? ResultMap).flatMap { Viewer(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "viewer")
      }
    }

    public struct Viewer: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(UserDetails.self),
        GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
        GraphQLField("backgroundImageUrl", type: .scalar(String.self)),
        GraphQLField("recordsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
        GraphQLField("followingsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("followersCount", type: .nonNull(.scalar(Int.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(avatarUrl: String? = nil, name: String, username: String, annictId: Int, backgroundImageUrl: String? = nil, recordsCount: Int, description: String, followingsCount: Int, followersCount: Int) {
        self.init(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username, "annictId": annictId, "backgroundImageUrl": backgroundImageUrl, "recordsCount": recordsCount, "description": description, "followingsCount": followingsCount, "followersCount": followersCount])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var annictId: Int {
        get {
          return resultMap["annictId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "annictId")
        }
      }

      public var backgroundImageUrl: String? {
        get {
          return resultMap["backgroundImageUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "backgroundImageUrl")
        }
      }

      public var recordsCount: Int {
        get {
          return resultMap["recordsCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "recordsCount")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var followingsCount: Int {
        get {
          return resultMap["followingsCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "followingsCount")
        }
      }

      public var followersCount: Int {
        get {
          return resultMap["followersCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "followersCount")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var userDetails: UserDetails {
          get {
            return UserDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct UserDetails: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment UserDetails on User {\n  __typename\n  avatarUrl\n  name\n  username\n}"

  public static let possibleTypes = ["User"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("avatarUrl", type: .scalar(String.self)),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("username", type: .nonNull(.scalar(String.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(avatarUrl: String? = nil, name: String, username: String) {
    self.init(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "name": name, "username": username])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var avatarUrl: String? {
    get {
      return resultMap["avatarUrl"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "avatarUrl")
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

  public var username: String {
    get {
      return resultMap["username"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "username")
    }
  }
}