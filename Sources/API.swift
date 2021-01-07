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

public enum RatingState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case great
  case good
  case average
  case bad
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "GREAT": self = .great
      case "GOOD": self = .good
      case "AVERAGE": self = .average
      case "BAD": self = .bad
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .great: return "GREAT"
      case .good: return "GOOD"
      case .average: return "AVERAGE"
      case .bad: return "BAD"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: RatingState, rhs: RatingState) -> Bool {
    switch (lhs, rhs) {
      case (.great, .great): return true
      case (.good, .good): return true
      case (.average, .average): return true
      case (.bad, .bad): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [RatingState] {
    return [
      .great,
      .good,
      .average,
      .bad,
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
            cursor
            node {
              __typename
              ... on Record {
                ...RecordFragment
              }
              ... on Review {
                ...ReviewFragment
              }
              ... on Status {
                ...StatusFragment
              }
              ... on MultipleRecord {
                id
              }
            }
          }
          pageInfo {
            __typename
            endCursor
            hasNextPage
          }
        }
      }
    }
    """

  public let operationName: String = "GetFollowingActivities"

  public let operationIdentifier: String? = "85e752c5006409898daa5cdbce370f805faef08b468e746651a51f1d78d9e06c"

  public var queryDocument: String { return operationDefinition.appending(RecordFragment.fragmentDefinition).appending(UserFragment.fragmentDefinition).appending(WorkFragment.fragmentDefinition).appending(EpisodeFragment.fragmentDefinition).appending(ReviewFragment.fragmentDefinition).appending(StatusFragment.fragmentDefinition) }

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
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil, pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "ActivityConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
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

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ActivityEdge"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("cursor", type: .nonNull(.scalar(String.self))),
              GraphQLField("node", type: .object(Node.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(cursor: String, node: Node? = nil) {
            self.init(unsafeResultMap: ["__typename": "ActivityEdge", "cursor": cursor, "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A cursor for use in pagination.
          public var cursor: String {
            get {
              return resultMap["cursor"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "cursor")
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

            public static func makeRecord(id: GraphQLID, annictId: Int, comment: String? = nil, ratingState: RatingState? = nil, createdAt: String, user: AsRecord.User, work: AsRecord.Work, episode: AsRecord.Episode) -> Node {
              return Node(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "comment": comment, "ratingState": ratingState, "createdAt": createdAt, "user": user.resultMap, "work": work.resultMap, "episode": episode.resultMap])
            }

            public static func makeReview(id: GraphQLID, annictId: Int, createdAt: String, body: String, ratingAnimationState: RatingState? = nil, user: AsReview.User, work: AsReview.Work) -> Node {
              return Node(unsafeResultMap: ["__typename": "Review", "id": id, "annictId": annictId, "createdAt": createdAt, "body": body, "ratingAnimationState": ratingAnimationState, "user": user.resultMap, "work": work.resultMap])
            }

            public static func makeStatus(id: GraphQLID, annictId: Int, createdAt: String, state: StatusState, user: AsStatus.User, work: AsStatus.Work) -> Node {
              return Node(unsafeResultMap: ["__typename": "Status", "id": id, "annictId": annictId, "createdAt": createdAt, "state": state, "user": user.resultMap, "work": work.resultMap])
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
                  GraphQLField("comment", type: .scalar(String.self)),
                  GraphQLField("ratingState", type: .scalar(RatingState.self)),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("user", type: .nonNull(.object(User.selections))),
                  GraphQLField("work", type: .nonNull(.object(Work.selections))),
                  GraphQLField("episode", type: .nonNull(.object(Episode.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID, annictId: Int, comment: String? = nil, ratingState: RatingState? = nil, createdAt: String, user: User, work: Work, episode: Episode) {
                self.init(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "comment": comment, "ratingState": ratingState, "createdAt": createdAt, "user": user.resultMap, "work": work.resultMap, "episode": episode.resultMap])
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

              public var comment: String? {
                get {
                  return resultMap["comment"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "comment")
                }
              }

              public var ratingState: RatingState? {
                get {
                  return resultMap["ratingState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingState")
                }
              }

              public var createdAt: String {
                get {
                  return resultMap["createdAt"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "createdAt")
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

              public var episode: Episode {
                get {
                  return Episode(unsafeResultMap: resultMap["episode"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "episode")
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
                    GraphQLField("avatarUrl", type: .scalar(String.self)),
                    GraphQLField("description", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
                  self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
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

                public var avatarUrl: String? {
                  get {
                    return resultMap["avatarUrl"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "avatarUrl")
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

              public struct Episode: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["Episode"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("numberText", type: .scalar(String.self)),
                    GraphQLField("title", type: .scalar(String.self)),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, annictId: Int, numberText: String? = nil, title: String? = nil) {
                  self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "numberText": numberText, "title": title])
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

                public var numberText: String? {
                  get {
                    return resultMap["numberText"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "numberText")
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

                  public var episodeFragment: EpisodeFragment {
                    get {
                      return EpisodeFragment(unsafeResultMap: resultMap)
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
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("body", type: .nonNull(.scalar(String.self))),
                  GraphQLField("ratingAnimationState", type: .scalar(RatingState.self)),
                  GraphQLField("user", type: .nonNull(.object(User.selections))),
                  GraphQLField("work", type: .nonNull(.object(Work.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID, annictId: Int, createdAt: String, body: String, ratingAnimationState: RatingState? = nil, user: User, work: Work) {
                self.init(unsafeResultMap: ["__typename": "Review", "id": id, "annictId": annictId, "createdAt": createdAt, "body": body, "ratingAnimationState": ratingAnimationState, "user": user.resultMap, "work": work.resultMap])
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

              public var createdAt: String {
                get {
                  return resultMap["createdAt"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "createdAt")
                }
              }

              public var body: String {
                get {
                  return resultMap["body"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "body")
                }
              }

              public var ratingAnimationState: RatingState? {
                get {
                  return resultMap["ratingAnimationState"] as? RatingState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "ratingAnimationState")
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

                public var reviewFragment: ReviewFragment {
                  get {
                    return ReviewFragment(unsafeResultMap: resultMap)
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
                    GraphQLField("avatarUrl", type: .scalar(String.self)),
                    GraphQLField("description", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
                  self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
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

                public var avatarUrl: String? {
                  get {
                    return resultMap["avatarUrl"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "avatarUrl")
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
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                  GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                  GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                  GraphQLField("state", type: .nonNull(.scalar(StatusState.self))),
                  GraphQLField("user", type: .nonNull(.object(User.selections))),
                  GraphQLField("work", type: .nonNull(.object(Work.selections))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID, annictId: Int, createdAt: String, state: StatusState, user: User, work: Work) {
                self.init(unsafeResultMap: ["__typename": "Status", "id": id, "annictId": annictId, "createdAt": createdAt, "state": state, "user": user.resultMap, "work": work.resultMap])
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

              public var createdAt: String {
                get {
                  return resultMap["createdAt"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "createdAt")
                }
              }

              public var state: StatusState {
                get {
                  return resultMap["state"]! as! StatusState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "state")
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

                public var statusFragment: StatusFragment {
                  get {
                    return StatusFragment(unsafeResultMap: resultMap)
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
                    GraphQLField("avatarUrl", type: .scalar(String.self)),
                    GraphQLField("description", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
                  self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
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

                public var avatarUrl: String? {
                  get {
                    return resultMap["avatarUrl"] as? String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "avatarUrl")
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

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }
        }
      }
    }
  }
}

public final class GetUserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetUser($username: String!) {
      user(username: $username) {
        __typename
        ...UserFragment
      }
    }
    """

  public let operationName: String = "GetUser"

  public let operationIdentifier: String? = "82718d3fac6860babf60481e49f8bd842e44727cf17acaeffcc20de77669d214"

  public var queryDocument: String { return operationDefinition.appending(UserFragment.fragmentDefinition) }

  public var username: String

  public init(username: String) {
    self.username = username
  }

  public var variables: GraphQLMap? {
    return ["username": username]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("user", arguments: ["username": GraphQLVariable("username")], type: .object(User.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(user: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
    }

    public var user: User? {
      get {
        return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "user")
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
          GraphQLField("avatarUrl", type: .scalar(String.self)),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
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

      public var avatarUrl: String? {
        get {
          return resultMap["avatarUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
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
  }
}

public final class GetViewerQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetViewer {
      viewer {
        __typename
        id
        annictId
        name
        username
        avatarUrl
        description
        wannaWatchCount
        watchingCount
        watchedCount
        onHoldCount
        stopWatchingCount
      }
    }
    """

  public let operationName: String = "GetViewer"

  public let operationIdentifier: String? = "439135c366daff60762a9040bc7e788dbb8b6c95ef2b9d249a14c1e2181fda89"

  public init() {
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
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("username", type: .nonNull(.scalar(String.self))),
          GraphQLField("avatarUrl", type: .scalar(String.self)),
          GraphQLField("description", type: .nonNull(.scalar(String.self))),
          GraphQLField("wannaWatchCount", type: .nonNull(.scalar(Int.self))),
          GraphQLField("watchingCount", type: .nonNull(.scalar(Int.self))),
          GraphQLField("watchedCount", type: .nonNull(.scalar(Int.self))),
          GraphQLField("onHoldCount", type: .nonNull(.scalar(Int.self))),
          GraphQLField("stopWatchingCount", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, annictId: Int, name: String, username: String, avatarUrl: String? = nil, description: String, wannaWatchCount: Int, watchingCount: Int, watchedCount: Int, onHoldCount: Int, stopWatchingCount: Int) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "annictId": annictId, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description, "wannaWatchCount": wannaWatchCount, "watchingCount": watchingCount, "watchedCount": watchedCount, "onHoldCount": onHoldCount, "stopWatchingCount": stopWatchingCount])
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

      public var avatarUrl: String? {
        get {
          return resultMap["avatarUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "avatarUrl")
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

      public var wannaWatchCount: Int {
        get {
          return resultMap["wannaWatchCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "wannaWatchCount")
        }
      }

      public var watchingCount: Int {
        get {
          return resultMap["watchingCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "watchingCount")
        }
      }

      public var watchedCount: Int {
        get {
          return resultMap["watchedCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "watchedCount")
        }
      }

      public var onHoldCount: Int {
        get {
          return resultMap["onHoldCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "onHoldCount")
        }
      }

      public var stopWatchingCount: Int {
        get {
          return resultMap["stopWatchingCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "stopWatchingCount")
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
      comment
      ratingState
      createdAt
      user {
        __typename
        ...UserFragment
      }
      work {
        __typename
        ...WorkFragment
      }
      episode {
        __typename
        ...EpisodeFragment
      }
    }
    """

  public static let possibleTypes: [String] = ["Record"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
      GraphQLField("comment", type: .scalar(String.self)),
      GraphQLField("ratingState", type: .scalar(RatingState.self)),
      GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
      GraphQLField("user", type: .nonNull(.object(User.selections))),
      GraphQLField("work", type: .nonNull(.object(Work.selections))),
      GraphQLField("episode", type: .nonNull(.object(Episode.selections))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, comment: String? = nil, ratingState: RatingState? = nil, createdAt: String, user: User, work: Work, episode: Episode) {
    self.init(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "comment": comment, "ratingState": ratingState, "createdAt": createdAt, "user": user.resultMap, "work": work.resultMap, "episode": episode.resultMap])
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

  public var comment: String? {
    get {
      return resultMap["comment"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "comment")
    }
  }

  public var ratingState: RatingState? {
    get {
      return resultMap["ratingState"] as? RatingState
    }
    set {
      resultMap.updateValue(newValue, forKey: "ratingState")
    }
  }

  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
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

  public var episode: Episode {
    get {
      return Episode(unsafeResultMap: resultMap["episode"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "episode")
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
        GraphQLField("avatarUrl", type: .scalar(String.self)),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
      self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
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

    public var avatarUrl: String? {
      get {
        return resultMap["avatarUrl"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "avatarUrl")
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

  public struct Episode: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Episode"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
        GraphQLField("numberText", type: .scalar(String.self)),
        GraphQLField("title", type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, annictId: Int, numberText: String? = nil, title: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "numberText": numberText, "title": title])
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

    public var numberText: String? {
      get {
        return resultMap["numberText"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "numberText")
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

      public var episodeFragment: EpisodeFragment {
        get {
          return EpisodeFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct StatusFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment StatusFragment on Status {
      __typename
      id
      annictId
      createdAt
      state
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

  public static let possibleTypes: [String] = ["Status"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
      GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
      GraphQLField("state", type: .nonNull(.scalar(StatusState.self))),
      GraphQLField("user", type: .nonNull(.object(User.selections))),
      GraphQLField("work", type: .nonNull(.object(Work.selections))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, createdAt: String, state: StatusState, user: User, work: Work) {
    self.init(unsafeResultMap: ["__typename": "Status", "id": id, "annictId": annictId, "createdAt": createdAt, "state": state, "user": user.resultMap, "work": work.resultMap])
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

  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  public var state: StatusState {
    get {
      return resultMap["state"]! as! StatusState
    }
    set {
      resultMap.updateValue(newValue, forKey: "state")
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
        GraphQLField("avatarUrl", type: .scalar(String.self)),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
      self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
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

    public var avatarUrl: String? {
      get {
        return resultMap["avatarUrl"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "avatarUrl")
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
      avatarUrl
      description
    }
    """

  public static let possibleTypes: [String] = ["User"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
      GraphQLField("username", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .scalar(String.self)),
      GraphQLField("description", type: .nonNull(.scalar(String.self))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
    self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
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

  public var avatarUrl: String? {
    get {
      return resultMap["avatarUrl"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "avatarUrl")
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
}

public struct EpisodeFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment EpisodeFragment on Episode {
      __typename
      id
      annictId
      numberText
      title
    }
    """

  public static let possibleTypes: [String] = ["Episode"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
      GraphQLField("numberText", type: .scalar(String.self)),
      GraphQLField("title", type: .scalar(String.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, numberText: String? = nil, title: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "numberText": numberText, "title": title])
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

  public var numberText: String? {
    get {
      return resultMap["numberText"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "numberText")
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
}

public struct ReviewFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ReviewFragment on Review {
      __typename
      id
      annictId
      createdAt
      body
      ratingAnimationState
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

  public static let possibleTypes: [String] = ["Review"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
      GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
      GraphQLField("body", type: .nonNull(.scalar(String.self))),
      GraphQLField("ratingAnimationState", type: .scalar(RatingState.self)),
      GraphQLField("user", type: .nonNull(.object(User.selections))),
      GraphQLField("work", type: .nonNull(.object(Work.selections))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, createdAt: String, body: String, ratingAnimationState: RatingState? = nil, user: User, work: Work) {
    self.init(unsafeResultMap: ["__typename": "Review", "id": id, "annictId": annictId, "createdAt": createdAt, "body": body, "ratingAnimationState": ratingAnimationState, "user": user.resultMap, "work": work.resultMap])
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

  public var createdAt: String {
    get {
      return resultMap["createdAt"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "createdAt")
    }
  }

  public var body: String {
    get {
      return resultMap["body"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "body")
    }
  }

  public var ratingAnimationState: RatingState? {
    get {
      return resultMap["ratingAnimationState"] as? RatingState
    }
    set {
      resultMap.updateValue(newValue, forKey: "ratingAnimationState")
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
        GraphQLField("avatarUrl", type: .scalar(String.self)),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, name: String, username: String, avatarUrl: String? = nil, description: String) {
      self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name, "username": username, "avatarUrl": avatarUrl, "description": description])
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

    public var avatarUrl: String? {
      get {
        return resultMap["avatarUrl"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "avatarUrl")
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