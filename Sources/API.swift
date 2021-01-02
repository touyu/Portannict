// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// Season name
public enum SeasonName: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case winter
  case spring
  case summer
  case autumn
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "WINTER": self = .winter
      case "SPRING": self = .spring
      case "SUMMER": self = .summer
      case "AUTUMN": self = .autumn
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .winter: return "WINTER"
      case .spring: return "SPRING"
      case .summer: return "SUMMER"
      case .autumn: return "AUTUMN"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: SeasonName, rhs: SeasonName) -> Bool {
    switch (lhs, rhs) {
      case (.winter, .winter): return true
      case (.spring, .spring): return true
      case (.summer, .summer): return true
      case (.autumn, .autumn): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [SeasonName] {
    return [
      .winter,
      .spring,
      .summer,
      .autumn,
    ]
  }
}

public enum StatusState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case wannaWatch
  case watching
  case watched
  case onHold
  case stopWatching
  case noState
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "WANNA_WATCH": self = .wannaWatch
      case "WATCHING": self = .watching
      case "WATCHED": self = .watched
      case "ON_HOLD": self = .onHold
      case "STOP_WATCHING": self = .stopWatching
      case "NO_STATE": self = .noState
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .wannaWatch: return "WANNA_WATCH"
      case .watching: return "WATCHING"
      case .watched: return "WATCHED"
      case .onHold: return "ON_HOLD"
      case .stopWatching: return "STOP_WATCHING"
      case .noState: return "NO_STATE"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: StatusState, rhs: StatusState) -> Bool {
    switch (lhs, rhs) {
      case (.wannaWatch, .wannaWatch): return true
      case (.watching, .watching): return true
      case (.watched, .watched): return true
      case (.onHold, .onHold): return true
      case (.stopWatching, .stopWatching): return true
      case (.noState, .noState): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [StatusState] {
    return [
      .wannaWatch,
      .watching,
      .watched,
      .onHold,
      .stopWatching,
      .noState,
    ]
  }
}

public final class GetFollowingActivitiesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetFollowingActivities($first: Int, $after: String) {
      viewer {
        __typename
        followingActivities(first: $first, after: $after, orderBy: {field: CREATED_AT, direction: DESC}) {
          __typename
          edges {
            __typename
            node {
              __typename
              ... on Record {
                ...RecordFragment
              }
              ... on Review {
                id
              }
              ... on Status {
                id
              }
              ... on MultipleRecord {
                id
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "GetFollowingActivities"

  public let operationIdentifier: String? = "b012a2ace9950d6d55c36de1147976ac1ac38abb05b78ee6b4fc153f6d4937a3"

  public var queryDocument: String { return operationDefinition.appending(RecordFragment.fragmentDefinition).appending(UserFragment.fragmentDefinition).appending(WorkFragment.fragmentDefinition) }

  public var first: Int?
  public var after: String?

  public init(first: Int? = nil, after: String? = nil) {
    self.first = first
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["first": first, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("viewer", type: .object(Viewer.selections)),
      ]
    }

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
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("followingActivities", arguments: ["first": GraphQLVariable("first"), "after": GraphQLVariable("after"), "orderBy": ["field": "CREATED_AT", "direction": "DESC"]], type: .object(FollowingActivity.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(followingActivities: FollowingActivity? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "followingActivities": followingActivities.flatMap { (value: FollowingActivity) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var followingActivities: FollowingActivity? {
        get {
          return (resultMap["followingActivities"] as? ResultMap).flatMap { FollowingActivity(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "followingActivities")
        }
      }

      public struct FollowingActivity: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ActivityConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .list(.object(Edge.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "ActivityConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ActivityEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil) {
            self.init(unsafeResultMap: ["__typename": "ActivityEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["MultipleRecord", "Record", "Review", "Status"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLTypeCase(
                  variants: ["Record": AsRecord.selections, "Review": AsReview.selections, "Status": AsStatus.selections, "MultipleRecord": AsMultipleRecord.selections],
                  default: [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  ]
                )
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public static func makeRecord(id: GraphQLID, annictId: Int, user: AsRecord.User, work: AsRecord.Work) -> Node {
              return Node(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "user": user.resultMap, "work": work.resultMap])
            }

            public static func makeReview(id: GraphQLID) -> Node {
              return Node(unsafeResultMap: ["__typename": "Review", "id": id])
            }

            public static func makeStatus(id: GraphQLID) -> Node {
              return Node(unsafeResultMap: ["__typename": "Status", "id": id])
            }

            public static func makeMultipleRecord(id: GraphQLID) -> Node {
              return Node(unsafeResultMap: ["__typename": "MultipleRecord", "id": id])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var asRecord: AsRecord? {
              get {
                if !AsRecord.possibleTypes.contains(__typename) { return nil }
                return AsRecord(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
              }
            }

            public struct AsRecord: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Record"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                  GraphQLField("user", type: .nonNull(.object(User.selections))),
                  GraphQLField("work", type: .nonNull(.object(Work.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID, annictId: Int, user: User, work: Work) {
                self.init(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "user": user.resultMap, "work": work.resultMap])
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

              public var annictId: Int {
                get {
                  return resultMap["annictId"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "annictId")
                }
              }

              public var user: User {
                get {
                  return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "user")
                }
              }

              public var work: Work {
                get {
                  return Work(unsafeResultMap: resultMap["work"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "work")
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

                public var recordFragment: RecordFragment {
                  get {
                    return RecordFragment(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }

              public struct User: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["User"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                    GraphQLField("username", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, name: String, username: String) {
                  self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username])
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

                public var username: String {
                  get {
                    return resultMap["username"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "username")
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

                  public var userFragment: UserFragment {
                    get {
                      return UserFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public struct Work: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Work"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("title", type: .nonNull(.scalar(String.self))),
                    GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("seasonName", type: .scalar(SeasonName.self)),
                    GraphQLField("seasonYear", type: .scalar(Int.self)),
                    GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil) {
                  self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState])
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

                public var annictId: Int {
                  get {
                    return resultMap["annictId"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "annictId")
                  }
                }

                public var title: String {
                  get {
                    return resultMap["title"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "title")
                  }
                }

                public var episodesCount: Int {
                  get {
                    return resultMap["episodesCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "episodesCount")
                  }
                }

                public var watchersCount: Int {
                  get {
                    return resultMap["watchersCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "watchersCount")
                  }
                }

                public var reviewsCount: Int {
                  get {
                    return resultMap["reviewsCount"]! as! Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "reviewsCount")
                  }
                }

                public var seasonName: SeasonName? {
                  get {
                    return resultMap["seasonName"] as? SeasonName
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "seasonName")
                  }
                }

                public var seasonYear: Int? {
                  get {
                    return resultMap["seasonYear"] as? Int
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "seasonYear")
                  }
                }

                public var viewerStatusState: StatusState? {
                  get {
                    return resultMap["viewerStatusState"] as? StatusState
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "viewerStatusState")
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

                  public var workFragment: WorkFragment {
                    get {
                      return WorkFragment(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }
            }

            public var asReview: AsReview? {
              get {
                if !AsReview.possibleTypes.contains(__typename) { return nil }
                return AsReview(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
              }
            }

            public struct AsReview: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Review"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID) {
                self.init(unsafeResultMap: ["__typename": "Review", "id": id])
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
            }

            public var asStatus: AsStatus? {
              get {
                if !AsStatus.possibleTypes.contains(__typename) { return nil }
                return AsStatus(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
              }
            }

            public struct AsStatus: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Status"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID) {
                self.init(unsafeResultMap: ["__typename": "Status", "id": id])
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
            }

            public var asMultipleRecord: AsMultipleRecord? {
              get {
                if !AsMultipleRecord.possibleTypes.contains(__typename) { return nil }
                return AsMultipleRecord(unsafeResultMap: resultMap)
              }
              set {
                guard let newValue = newValue else { return }
                resultMap = newValue.resultMap
              }
            }

            public struct AsMultipleRecord: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["MultipleRecord"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID) {
                self.init(unsafeResultMap: ["__typename": "MultipleRecord", "id": id])
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
            }
          }
        }
      }
    }
  }
}

public final class SearchWorksByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchWorksByID($annictId: Int!, $after: String) {
      searchWorks(annictIds: [$annictId], after: $after) {
        __typename
        nodes {
          __typename
          ...WorkFragment
          episodes(first: 5, orderBy: {direction: ASC, field: SORT_NUMBER}) {
            __typename
            nodes {
              __typename
              id
              annictId
              title
              numberText
              viewerRecordsCount
            }
          }
        }
      }
    }
    """

  public let operationName: String = "SearchWorksByID"

  public let operationIdentifier: String? = "999459cc336c9f020f1ff9e3492ae12d5bc379d1b7e4fad6a468f862565f1172"

  public var queryDocument: String { return operationDefinition.appending(WorkFragment.fragmentDefinition) }

  public var annictId: Int
  public var after: String?

  public init(annictId: Int, after: String? = nil) {
    self.annictId = annictId
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["annictId": annictId, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("searchWorks", arguments: ["annictIds": [GraphQLVariable("annictId")], "after": GraphQLVariable("after")], type: .object(SearchWork.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchWorks: SearchWork? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "searchWorks": searchWorks.flatMap { (value: SearchWork) -> ResultMap in value.resultMap }])
    }

    public var searchWorks: SearchWork? {
      get {
        return (resultMap["searchWorks"] as? ResultMap).flatMap { SearchWork(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "searchWorks")
      }
    }

    public struct SearchWork: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["WorkConnection"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nodes: [Node?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "WorkConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Work"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("title", type: .nonNull(.scalar(String.self))),
            GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("seasonName", type: .scalar(SeasonName.self)),
            GraphQLField("seasonYear", type: .scalar(Int.self)),
            GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
            GraphQLField("episodes", arguments: ["first": 5, "orderBy": ["direction": "ASC", "field": "SORT_NUMBER"]], type: .object(Episode.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, episodes: Episode? = nil) {
          self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "episodes": episodes.flatMap { (value: Episode) -> ResultMap in value.resultMap }])
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

        public var annictId: Int {
          get {
            return resultMap["annictId"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "annictId")
          }
        }

        public var title: String {
          get {
            return resultMap["title"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var episodesCount: Int {
          get {
            return resultMap["episodesCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "episodesCount")
          }
        }

        public var watchersCount: Int {
          get {
            return resultMap["watchersCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "watchersCount")
          }
        }

        public var reviewsCount: Int {
          get {
            return resultMap["reviewsCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "reviewsCount")
          }
        }

        public var seasonName: SeasonName? {
          get {
            return resultMap["seasonName"] as? SeasonName
          }
          set {
            resultMap.updateValue(newValue, forKey: "seasonName")
          }
        }

        public var seasonYear: Int? {
          get {
            return resultMap["seasonYear"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "seasonYear")
          }
        }

        public var viewerStatusState: StatusState? {
          get {
            return resultMap["viewerStatusState"] as? StatusState
          }
          set {
            resultMap.updateValue(newValue, forKey: "viewerStatusState")
          }
        }

        public var episodes: Episode? {
          get {
            return (resultMap["episodes"] as? ResultMap).flatMap { Episode(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "episodes")
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

          public var workFragment: WorkFragment {
            get {
              return WorkFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Episode: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["EpisodeConnection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(nodes: [Node?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "EpisodeConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of nodes.
          public var nodes: [Node?]? {
            get {
              return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Episode"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                GraphQLField("title", type: .scalar(String.self)),
                GraphQLField("numberText", type: .scalar(String.self)),
                GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, viewerRecordsCount: Int) {
              self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "viewerRecordsCount": viewerRecordsCount])
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

            public var annictId: Int {
              get {
                return resultMap["annictId"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "annictId")
              }
            }

            public var title: String? {
              get {
                return resultMap["title"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "title")
              }
            }

            public var numberText: String? {
              get {
                return resultMap["numberText"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "numberText")
              }
            }

            public var viewerRecordsCount: Int {
              get {
                return resultMap["viewerRecordsCount"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "viewerRecordsCount")
              }
            }
          }
        }
      }
    }
  }
}

public struct WorkFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment WorkFragment on Work {
      __typename
      id
      annictId
      title
      episodesCount
      watchersCount
      reviewsCount
      seasonName
      seasonYear
      viewerStatusState
    }
    """

  public static let possibleTypes: [String] = ["Work"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
      GraphQLField("title", type: .nonNull(.scalar(String.self))),
      GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
      GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
      GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
      GraphQLField("seasonName", type: .scalar(SeasonName.self)),
      GraphQLField("seasonYear", type: .scalar(Int.self)),
      GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil) {
    self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState])
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

  public var annictId: Int {
    get {
      return resultMap["annictId"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "annictId")
    }
  }

  public var title: String {
    get {
      return resultMap["title"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var episodesCount: Int {
    get {
      return resultMap["episodesCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "episodesCount")
    }
  }

  public var watchersCount: Int {
    get {
      return resultMap["watchersCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "watchersCount")
    }
  }

  public var reviewsCount: Int {
    get {
      return resultMap["reviewsCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "reviewsCount")
    }
  }

  public var seasonName: SeasonName? {
    get {
      return resultMap["seasonName"] as? SeasonName
    }
    set {
      resultMap.updateValue(newValue, forKey: "seasonName")
    }
  }

  public var seasonYear: Int? {
    get {
      return resultMap["seasonYear"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "seasonYear")
    }
  }

  public var viewerStatusState: StatusState? {
    get {
      return resultMap["viewerStatusState"] as? StatusState
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerStatusState")
    }
  }
}

public struct RecordFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RecordFragment on Record {
      __typename
      id
      annictId
      user {
        __typename
        ...UserFragment
      }
      work {
        __typename
        ...WorkFragment
      }
    }
    """

  public static let possibleTypes: [String] = ["Record"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
      GraphQLField("user", type: .nonNull(.object(User.selections))),
      GraphQLField("work", type: .nonNull(.object(Work.selections))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, user: User, work: Work) {
    self.init(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "user": user.resultMap, "work": work.resultMap])
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

  public var annictId: Int {
    get {
      return resultMap["annictId"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "annictId")
    }
  }

  public var user: User {
    get {
      return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "user")
    }
  }

  public var work: Work {
    get {
      return Work(unsafeResultMap: resultMap["work"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "work")
    }
  }

  public struct User: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["User"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("username", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, name: String, username: String) {
      self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username])
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

    public var username: String {
      get {
        return resultMap["username"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "username")
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

      public var userFragment: UserFragment {
        get {
          return UserFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }

  public struct Work: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Work"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("episodesCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("watchersCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("reviewsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("seasonName", type: .scalar(SeasonName.self)),
        GraphQLField("seasonYear", type: .scalar(Int.self)),
        GraphQLField("viewerStatusState", type: .scalar(StatusState.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil) {
      self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState])
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

    public var annictId: Int {
      get {
        return resultMap["annictId"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "annictId")
      }
    }

    public var title: String {
      get {
        return resultMap["title"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "title")
      }
    }

    public var episodesCount: Int {
      get {
        return resultMap["episodesCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "episodesCount")
      }
    }

    public var watchersCount: Int {
      get {
        return resultMap["watchersCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "watchersCount")
      }
    }

    public var reviewsCount: Int {
      get {
        return resultMap["reviewsCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "reviewsCount")
      }
    }

    public var seasonName: SeasonName? {
      get {
        return resultMap["seasonName"] as? SeasonName
      }
      set {
        resultMap.updateValue(newValue, forKey: "seasonName")
      }
    }

    public var seasonYear: Int? {
      get {
        return resultMap["seasonYear"] as? Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "seasonYear")
      }
    }

    public var viewerStatusState: StatusState? {
      get {
        return resultMap["viewerStatusState"] as? StatusState
      }
      set {
        resultMap.updateValue(newValue, forKey: "viewerStatusState")
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

      public var workFragment: WorkFragment {
        get {
          return WorkFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct UserFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment UserFragment on User {
      __typename
      id
      name
      username
    }
    """

  public static let possibleTypes: [String] = ["User"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("username", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String, username: String) {
    self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username])
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

  public var username: String {
    get {
      return resultMap["username"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "username")
    }
  }
}
