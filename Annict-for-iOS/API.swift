//  This file was automatically generated and should not be edited.

import Apollo

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

public final class CreateRecordMutation: GraphQLMutation {
  /// mutation CreateRecord($episodeId: ID!, $comment: String, $ratingState: RatingState) {
  ///   createRecord(input: {episodeId: $episodeId, comment: $comment, ratingState: $ratingState}) {
  ///     __typename
  ///     record {
  ///       __typename
  ///       ...MinimumRecord
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "mutation CreateRecord($episodeId: ID!, $comment: String, $ratingState: RatingState) { createRecord(input: {episodeId: $episodeId, comment: $comment, ratingState: $ratingState}) { __typename record { __typename ...MinimumRecord } } }"

  public let operationName = "CreateRecord"

  public var queryDocument: String { return operationDefinition.appending(MinimumRecord.fragmentDefinition).appending(MinimumUser.fragmentDefinition) }

  public var episodeId: GraphQLID
  public var comment: String?
  public var ratingState: RatingState?

  public init(episodeId: GraphQLID, comment: String? = nil, ratingState: RatingState? = nil) {
    self.episodeId = episodeId
    self.comment = comment
    self.ratingState = ratingState
  }

  public var variables: GraphQLMap? {
    return ["episodeId": episodeId, "comment": comment, "ratingState": ratingState]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createRecord", arguments: ["input": ["episodeId": GraphQLVariable("episodeId"), "comment": GraphQLVariable("comment"), "ratingState": GraphQLVariable("ratingState")]], type: .object(CreateRecord.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createRecord: CreateRecord? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createRecord": createRecord.flatMap { (value: CreateRecord) -> ResultMap in value.resultMap }])
    }

    public var createRecord: CreateRecord? {
      get {
        return (resultMap["createRecord"] as? ResultMap).flatMap { CreateRecord(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createRecord")
      }
    }

    public struct CreateRecord: GraphQLSelectionSet {
      public static let possibleTypes = ["CreateRecordPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("record", type: .object(Record.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(record: Record? = nil) {
        self.init(unsafeResultMap: ["__typename": "CreateRecordPayload", "record": record.flatMap { (value: Record) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var record: Record? {
        get {
          return (resultMap["record"] as? ResultMap).flatMap { Record(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "record")
        }
      }

      public struct Record: GraphQLSelectionSet {
        public static let possibleTypes = ["Record"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(MinimumRecord.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

          public var minimumRecord: MinimumRecord {
            get {
              return MinimumRecord(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class DeleteRecordMutation: GraphQLMutation {
  /// mutation DeleteRecord($recordId: ID!) {
  ///   deleteRecord(input: {recordId: $recordId}) {
  ///     __typename
  ///     episode {
  ///       __typename
  ///       ...MinimumEpisode
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "mutation DeleteRecord($recordId: ID!) { deleteRecord(input: {recordId: $recordId}) { __typename episode { __typename ...MinimumEpisode } } }"

  public let operationName = "DeleteRecord"

  public var queryDocument: String { return operationDefinition.appending(MinimumEpisode.fragmentDefinition) }

  public var recordId: GraphQLID

  public init(recordId: GraphQLID) {
    self.recordId = recordId
  }

  public var variables: GraphQLMap? {
    return ["recordId": recordId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteRecord", arguments: ["input": ["recordId": GraphQLVariable("recordId")]], type: .object(DeleteRecord.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteRecord: DeleteRecord? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "deleteRecord": deleteRecord.flatMap { (value: DeleteRecord) -> ResultMap in value.resultMap }])
    }

    public var deleteRecord: DeleteRecord? {
      get {
        return (resultMap["deleteRecord"] as? ResultMap).flatMap { DeleteRecord(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "deleteRecord")
      }
    }

    public struct DeleteRecord: GraphQLSelectionSet {
      public static let possibleTypes = ["DeleteRecordPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("episode", type: .object(Episode.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(episode: Episode? = nil) {
        self.init(unsafeResultMap: ["__typename": "DeleteRecordPayload", "episode": episode.flatMap { (value: Episode) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var episode: Episode? {
        get {
          return (resultMap["episode"] as? ResultMap).flatMap { Episode(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "episode")
        }
      }

      public struct Episode: GraphQLSelectionSet {
        public static let possibleTypes = ["Episode"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(MinimumEpisode.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, sortNumber: Int, viewerRecordsCount: Int, recordCommentsCount: Int, viewerDidTrack: Bool) {
          self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "sortNumber": sortNumber, "viewerRecordsCount": viewerRecordsCount, "recordCommentsCount": recordCommentsCount, "viewerDidTrack": viewerDidTrack])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

          public var minimumEpisode: MinimumEpisode {
            get {
              return MinimumEpisode(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class GetFollowingActivitiesQuery: GraphQLQuery {
  /// query GetFollowingActivities($after: String) {
  ///   viewer {
  ///     __typename
  ///     followingActivities(after: $after, first: 30, orderBy: {field: CREATED_AT, direction: DESC}) {
  ///       __typename
  ///       pageInfo {
  ///         __typename
  ///         ...PageInfoFrag
  ///       }
  ///       edges {
  ///         __typename
  ///         annictId
  ///         node {
  ///           __typename
  ///           ... on Status {
  ///             createdAt
  ///             annictId
  ///             id
  ///             state
  ///             work {
  ///               __typename
  ///               ...MinimumWork
  ///             }
  ///             user {
  ///               __typename
  ///               ...MinimumUser
  ///             }
  ///           }
  ///           ... on Record {
  ///             ...MinimumRecord
  ///             episode {
  ///               __typename
  ///               ...MinimumEpisode
  ///             }
  ///             work {
  ///               __typename
  ///               ...MinimumWork
  ///             }
  ///           }
  ///           ... on Review {
  ///             createdAt
  ///             annictId
  ///             id
  ///             work {
  ///               __typename
  ///               ...MinimumWork
  ///             }
  ///             user {
  ///               __typename
  ///               ...MinimumUser
  ///             }
  ///           }
  ///           ... on MultipleRecord {
  ///             createdAt
  ///             annictId
  ///             id
  ///             records(first: 30) {
  ///               __typename
  ///               nodes {
  ///                 __typename
  ///                 episode {
  ///                   __typename
  ///                   ...MinimumEpisode
  ///                 }
  ///               }
  ///             }
  ///             work {
  ///               __typename
  ///               ...MinimumWork
  ///             }
  ///             user {
  ///               __typename
  ///               ...MinimumUser
  ///             }
  ///           }
  ///         }
  ///       }
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query GetFollowingActivities($after: String) { viewer { __typename followingActivities(after: $after, first: 30, orderBy: {field: CREATED_AT, direction: DESC}) { __typename pageInfo { __typename ...PageInfoFrag } edges { __typename annictId node { __typename ... on Status { createdAt annictId id state work { __typename ...MinimumWork } user { __typename ...MinimumUser } } ... on Record { ...MinimumRecord episode { __typename ...MinimumEpisode } work { __typename ...MinimumWork } } ... on Review { createdAt annictId id work { __typename ...MinimumWork } user { __typename ...MinimumUser } } ... on MultipleRecord { createdAt annictId id records(first: 30) { __typename nodes { __typename episode { __typename ...MinimumEpisode } } } work { __typename ...MinimumWork } user { __typename ...MinimumUser } } } } } } }"

  public let operationName = "GetFollowingActivities"

  public var queryDocument: String { return operationDefinition.appending(PageInfoFrag.fragmentDefinition).appending(MinimumWork.fragmentDefinition).appending(MinimumUser.fragmentDefinition).appending(MinimumRecord.fragmentDefinition).appending(MinimumEpisode.fragmentDefinition) }

  public var after: String?

  public init(after: String? = nil) {
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["after": after]
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
        GraphQLField("followingActivities", arguments: ["after": GraphQLVariable("after"), "first": 30, "orderBy": ["field": "CREATED_AT", "direction": "DESC"]], type: .object(FollowingActivity.selections)),
      ]

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
        public static let possibleTypes = ["ActivityConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(pageInfo: PageInfo, edges: [Edge?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "ActivityConnection", "pageInfo": pageInfo.resultMap, "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        /// A list of edges.
        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(PageInfoFrag.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(endCursor: String? = nil, hasNextPage: Bool, hasPreviousPage: Bool, startCursor: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage, "hasPreviousPage": hasPreviousPage, "startCursor": startCursor])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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

            public var pageInfoFrag: PageInfoFrag {
              get {
                return PageInfoFrag(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes = ["ActivityEdge"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(annictId: Int, node: Node? = nil) {
            self.init(unsafeResultMap: ["__typename": "ActivityEdge", "annictId": annictId, "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
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

          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Status", "Record", "Review", "MultipleRecord"]

            public static let selections: [GraphQLSelection] = [
              GraphQLTypeCase(
                variants: ["Status": AsStatus.selections, "Record": AsRecord.selections, "Review": AsReview.selections, "MultipleRecord": AsMultipleRecord.selections],
                default: [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                ]
              )
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public static func makeStatus(createdAt: String, annictId: Int, id: GraphQLID, state: StatusState, work: AsStatus.Work, user: AsStatus.User) -> Node {
              return Node(unsafeResultMap: ["__typename": "Status", "createdAt": createdAt, "annictId": annictId, "id": id, "state": state, "work": work.resultMap, "user": user.resultMap])
            }

            public static func makeReview(createdAt: String, annictId: Int, id: GraphQLID, work: AsReview.Work, user: AsReview.User) -> Node {
              return Node(unsafeResultMap: ["__typename": "Review", "createdAt": createdAt, "annictId": annictId, "id": id, "work": work.resultMap, "user": user.resultMap])
            }

            public static func makeMultipleRecord(createdAt: String, annictId: Int, id: GraphQLID, records: AsMultipleRecord.Record? = nil, work: AsMultipleRecord.Work, user: AsMultipleRecord.User) -> Node {
              return Node(unsafeResultMap: ["__typename": "MultipleRecord", "createdAt": createdAt, "annictId": annictId, "id": id, "records": records.flatMap { (value: AsMultipleRecord.Record) -> ResultMap in value.resultMap }, "work": work.resultMap, "user": user.resultMap])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
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
              public static let possibleTypes = ["Status"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("state", type: .nonNull(.scalar(StatusState.self))),
                GraphQLField("work", type: .nonNull(.object(Work.selections))),
                GraphQLField("user", type: .nonNull(.object(User.selections))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(createdAt: String, annictId: Int, id: GraphQLID, state: StatusState, work: Work, user: User) {
                self.init(unsafeResultMap: ["__typename": "Status", "createdAt": createdAt, "annictId": annictId, "id": id, "state": state, "work": work.resultMap, "user": user.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
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

              public var annictId: Int {
                get {
                  return resultMap["annictId"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "annictId")
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

              public var state: StatusState {
                get {
                  return resultMap["state"]! as! StatusState
                }
                set {
                  resultMap.updateValue(newValue, forKey: "state")
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

              public var user: User {
                get {
                  return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "user")
                }
              }

              public struct Work: GraphQLSelectionSet {
                public static let possibleTypes = ["Work"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(MinimumWork.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
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

                  public var minimumWork: MinimumWork {
                    get {
                      return MinimumWork(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public struct User: GraphQLSelectionSet {
                public static let possibleTypes = ["User"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(MinimumUser.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(annictId: Int, name: String, username: String, avatarUrl: String? = nil) {
                  self.init(unsafeResultMap: ["__typename": "User", "annictId": annictId, "name": name, "username": username, "avatarUrl": avatarUrl])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
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

                  public var minimumUser: MinimumUser {
                    get {
                      return MinimumUser(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
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
              public static let possibleTypes = ["Record"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(MinimumRecord.self),
                GraphQLField("episode", type: .nonNull(.object(Episode.selections))),
                GraphQLField("work", type: .nonNull(.object(Work.selections))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
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

                public var minimumRecord: MinimumRecord {
                  get {
                    return MinimumRecord(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
                  }
                }
              }

              public struct Episode: GraphQLSelectionSet {
                public static let possibleTypes = ["Episode"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(MinimumEpisode.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, sortNumber: Int, viewerRecordsCount: Int, recordCommentsCount: Int, viewerDidTrack: Bool) {
                  self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "sortNumber": sortNumber, "viewerRecordsCount": viewerRecordsCount, "recordCommentsCount": recordCommentsCount, "viewerDidTrack": viewerDidTrack])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
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

                  public var minimumEpisode: MinimumEpisode {
                    get {
                      return MinimumEpisode(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public struct Work: GraphQLSelectionSet {
                public static let possibleTypes = ["Work"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(MinimumWork.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
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

                  public var minimumWork: MinimumWork {
                    get {
                      return MinimumWork(unsafeResultMap: resultMap)
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
              public static let possibleTypes = ["Review"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("work", type: .nonNull(.object(Work.selections))),
                GraphQLField("user", type: .nonNull(.object(User.selections))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(createdAt: String, annictId: Int, id: GraphQLID, work: Work, user: User) {
                self.init(unsafeResultMap: ["__typename": "Review", "createdAt": createdAt, "annictId": annictId, "id": id, "work": work.resultMap, "user": user.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
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

              public var annictId: Int {
                get {
                  return resultMap["annictId"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "annictId")
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

              public var work: Work {
                get {
                  return Work(unsafeResultMap: resultMap["work"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "work")
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

              public struct Work: GraphQLSelectionSet {
                public static let possibleTypes = ["Work"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(MinimumWork.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
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

                  public var minimumWork: MinimumWork {
                    get {
                      return MinimumWork(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public struct User: GraphQLSelectionSet {
                public static let possibleTypes = ["User"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(MinimumUser.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(annictId: Int, name: String, username: String, avatarUrl: String? = nil) {
                  self.init(unsafeResultMap: ["__typename": "User", "annictId": annictId, "name": name, "username": username, "avatarUrl": avatarUrl])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
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

                  public var minimumUser: MinimumUser {
                    get {
                      return MinimumUser(unsafeResultMap: resultMap)
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
              public static let possibleTypes = ["MultipleRecord"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
                GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
                GraphQLField("records", arguments: ["first": 30], type: .object(Record.selections)),
                GraphQLField("work", type: .nonNull(.object(Work.selections))),
                GraphQLField("user", type: .nonNull(.object(User.selections))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(createdAt: String, annictId: Int, id: GraphQLID, records: Record? = nil, work: Work, user: User) {
                self.init(unsafeResultMap: ["__typename": "MultipleRecord", "createdAt": createdAt, "annictId": annictId, "id": id, "records": records.flatMap { (value: Record) -> ResultMap in value.resultMap }, "work": work.resultMap, "user": user.resultMap])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
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

              public var annictId: Int {
                get {
                  return resultMap["annictId"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "annictId")
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

              public var records: Record? {
                get {
                  return (resultMap["records"] as? ResultMap).flatMap { Record(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "records")
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

              public var user: User {
                get {
                  return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
                }
                set {
                  resultMap.updateValue(newValue.resultMap, forKey: "user")
                }
              }

              public struct Record: GraphQLSelectionSet {
                public static let possibleTypes = ["RecordConnection"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("nodes", type: .list(.object(Node.selections))),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(nodes: [Node?]? = nil) {
                  self.init(unsafeResultMap: ["__typename": "RecordConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
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
                  public static let possibleTypes = ["Record"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("episode", type: .nonNull(.object(Episode.selections))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(episode: Episode) {
                    self.init(unsafeResultMap: ["__typename": "Record", "episode": episode.resultMap])
                  }

                  public var __typename: String {
                    get {
                      return resultMap["__typename"]! as! String
                    }
                    set {
                      resultMap.updateValue(newValue, forKey: "__typename")
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

                  public struct Episode: GraphQLSelectionSet {
                    public static let possibleTypes = ["Episode"]

                    public static let selections: [GraphQLSelection] = [
                      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                      GraphQLFragmentSpread(MinimumEpisode.self),
                    ]

                    public private(set) var resultMap: ResultMap

                    public init(unsafeResultMap: ResultMap) {
                      self.resultMap = unsafeResultMap
                    }

                    public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, sortNumber: Int, viewerRecordsCount: Int, recordCommentsCount: Int, viewerDidTrack: Bool) {
                      self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "sortNumber": sortNumber, "viewerRecordsCount": viewerRecordsCount, "recordCommentsCount": recordCommentsCount, "viewerDidTrack": viewerDidTrack])
                    }

                    public var __typename: String {
                      get {
                        return resultMap["__typename"]! as! String
                      }
                      set {
                        resultMap.updateValue(newValue, forKey: "__typename")
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

                      public var minimumEpisode: MinimumEpisode {
                        get {
                          return MinimumEpisode(unsafeResultMap: resultMap)
                        }
                        set {
                          resultMap += newValue.resultMap
                        }
                      }
                    }
                  }
                }
              }

              public struct Work: GraphQLSelectionSet {
                public static let possibleTypes = ["Work"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(MinimumWork.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
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

                  public var minimumWork: MinimumWork {
                    get {
                      return MinimumWork(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
                    }
                  }
                }
              }

              public struct User: GraphQLSelectionSet {
                public static let possibleTypes = ["User"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLFragmentSpread(MinimumUser.self),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(annictId: Int, name: String, username: String, avatarUrl: String? = nil) {
                  self.init(unsafeResultMap: ["__typename": "User", "annictId": annictId, "name": name, "username": username, "avatarUrl": avatarUrl])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
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

                  public var minimumUser: MinimumUser {
                    get {
                      return MinimumUser(unsafeResultMap: resultMap)
                    }
                    set {
                      resultMap += newValue.resultMap
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
}

public final class GetEpisodeRecordsQuery: GraphQLQuery {
  /// query GetEpisodeRecords($episodeID: Int!) {
  ///   searchEpisodes(first: 1, annictIds: [$episodeID]) {
  ///     __typename
  ///     nodes {
  ///       __typename
  ///       ...MinimumEpisode
  ///       records(first: 30, hasComment: true) {
  ///         __typename
  ///         nodes {
  ///           __typename
  ///           ...MinimumRecord
  ///         }
  ///       }
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query GetEpisodeRecords($episodeID: Int!) { searchEpisodes(first: 1, annictIds: [$episodeID]) { __typename nodes { __typename ...MinimumEpisode records(first: 30, hasComment: true) { __typename nodes { __typename ...MinimumRecord } } } } }"

  public let operationName = "GetEpisodeRecords"

  public var queryDocument: String { return operationDefinition.appending(MinimumEpisode.fragmentDefinition).appending(MinimumRecord.fragmentDefinition).appending(MinimumUser.fragmentDefinition) }

  public var episodeID: Int

  public init(episodeID: Int) {
    self.episodeID = episodeID
  }

  public var variables: GraphQLMap? {
    return ["episodeID": episodeID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("searchEpisodes", arguments: ["first": 1, "annictIds": [GraphQLVariable("episodeID")]], type: .object(SearchEpisode.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(searchEpisodes: SearchEpisode? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "searchEpisodes": searchEpisodes.flatMap { (value: SearchEpisode) -> ResultMap in value.resultMap }])
    }

    public var searchEpisodes: SearchEpisode? {
      get {
        return (resultMap["searchEpisodes"] as? ResultMap).flatMap { SearchEpisode(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "searchEpisodes")
      }
    }

    public struct SearchEpisode: GraphQLSelectionSet {
      public static let possibleTypes = ["EpisodeConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
      ]

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
        public static let possibleTypes = ["Episode"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(MinimumEpisode.self),
          GraphQLField("records", arguments: ["first": 30, "hasComment": true], type: .object(Record.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var records: Record? {
          get {
            return (resultMap["records"] as? ResultMap).flatMap { Record(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "records")
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

          public var minimumEpisode: MinimumEpisode {
            get {
              return MinimumEpisode(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Record: GraphQLSelectionSet {
          public static let possibleTypes = ["RecordConnection"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(nodes: [Node?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "RecordConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
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
            public static let possibleTypes = ["Record"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(MinimumRecord.self),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
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

              public var minimumRecord: MinimumRecord {
                get {
                  return MinimumRecord(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class GetViewerInfoQuery: GraphQLQuery {
  /// query GetViewerInfo {
  ///   viewer {
  ///     __typename
  ///     watchingCount
  ///     recordsCount
  ///     followersCount
  ///     followingsCount
  ///     description
  ///     annictId
  ///     username
  ///     name
  ///     avatarUrl
  ///   }
  /// }
  public let operationDefinition =
    "query GetViewerInfo { viewer { __typename watchingCount recordsCount followersCount followingsCount description annictId username name avatarUrl } }"

  public let operationName = "GetViewerInfo"

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
        GraphQLField("watchingCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("recordsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("followersCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("followingsCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
        GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
        GraphQLField("username", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("avatarUrl", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(watchingCount: Int, recordsCount: Int, followersCount: Int, followingsCount: Int, description: String, annictId: Int, username: String, name: String, avatarUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "watchingCount": watchingCount, "recordsCount": recordsCount, "followersCount": followersCount, "followingsCount": followingsCount, "description": description, "annictId": annictId, "username": username, "name": name, "avatarUrl": avatarUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var recordsCount: Int {
        get {
          return resultMap["recordsCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "recordsCount")
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

      public var followingsCount: Int {
        get {
          return resultMap["followingsCount"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "followingsCount")
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

      public var annictId: Int {
        get {
          return resultMap["annictId"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "annictId")
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

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
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
    }
  }
}

public final class GetViewerWatchingEpisodesQuery: GraphQLQuery {
  /// query GetViewerWatchingEpisodes($first: Int, $after: String) {
  ///   viewer {
  ///     __typename
  ///     works(state: WATCHING, first: $first, after: $after) {
  ///       __typename
  ///       pageInfo {
  ///         __typename
  ///         endCursor
  ///         hasNextPage
  ///       }
  ///       nodes {
  ///         __typename
  ///         ...MinimumWork
  ///         episodes(orderBy: {field: CREATED_AT, direction: DESC}) {
  ///           __typename
  ///           nodes {
  ///             __typename
  ///             ...MinimumEpisode
  ///           }
  ///         }
  ///       }
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query GetViewerWatchingEpisodes($first: Int, $after: String) { viewer { __typename works(state: WATCHING, first: $first, after: $after) { __typename pageInfo { __typename endCursor hasNextPage } nodes { __typename ...MinimumWork episodes(orderBy: {field: CREATED_AT, direction: DESC}) { __typename nodes { __typename ...MinimumEpisode } } } } } }"

  public let operationName = "GetViewerWatchingEpisodes"

  public var queryDocument: String { return operationDefinition.appending(MinimumWork.fragmentDefinition).appending(MinimumEpisode.fragmentDefinition) }

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
        GraphQLField("works", arguments: ["state": "WATCHING", "first": GraphQLVariable("first"), "after": GraphQLVariable("after")], type: .object(Work.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(works: Work? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "works": works.flatMap { (value: Work) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var works: Work? {
        get {
          return (resultMap["works"] as? ResultMap).flatMap { Work(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "works")
        }
      }

      public struct Work: GraphQLSelectionSet {
        public static let possibleTypes = ["WorkConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(pageInfo: PageInfo, nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "WorkConnection", "pageInfo": pageInfo.resultMap, "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("endCursor", type: .scalar(String.self)),
            GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          ]

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

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["Work"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(MinimumWork.self),
            GraphQLField("episodes", arguments: ["orderBy": ["field": "CREATED_AT", "direction": "DESC"]], type: .object(Episode.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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

            public var minimumWork: MinimumWork {
              get {
                return MinimumWork(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }

          public struct Episode: GraphQLSelectionSet {
            public static let possibleTypes = ["EpisodeConnection"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]

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
              public static let possibleTypes = ["Episode"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLFragmentSpread(MinimumEpisode.self),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, sortNumber: Int, viewerRecordsCount: Int, recordCommentsCount: Int, viewerDidTrack: Bool) {
                self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "sortNumber": sortNumber, "viewerRecordsCount": viewerRecordsCount, "recordCommentsCount": recordCommentsCount, "viewerDidTrack": viewerDidTrack])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
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

                public var minimumEpisode: MinimumEpisode {
                  get {
                    return MinimumEpisode(unsafeResultMap: resultMap)
                  }
                  set {
                    resultMap += newValue.resultMap
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

public final class GetViewerWorksQuery: GraphQLQuery {
  /// query GetViewerWorks($state: StatusState, $after: String) {
  ///   viewer {
  ///     __typename
  ///     works(state: $state, first: 30, after: $after, orderBy: {field: SEASON, direction: DESC}) {
  ///       __typename
  ///       nodes {
  ///         __typename
  ///         ...MinimumWork
  ///       }
  ///       pageInfo {
  ///         __typename
  ///         endCursor
  ///         hasNextPage
  ///       }
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query GetViewerWorks($state: StatusState, $after: String) { viewer { __typename works(state: $state, first: 30, after: $after, orderBy: {field: SEASON, direction: DESC}) { __typename nodes { __typename ...MinimumWork } pageInfo { __typename endCursor hasNextPage } } } }"

  public let operationName = "GetViewerWorks"

  public var queryDocument: String { return operationDefinition.appending(MinimumWork.fragmentDefinition) }

  public var state: StatusState?
  public var after: String?

  public init(state: StatusState? = nil, after: String? = nil) {
    self.state = state
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["state": state, "after": after]
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
        GraphQLField("works", arguments: ["state": GraphQLVariable("state"), "first": 30, "after": GraphQLVariable("after"), "orderBy": ["field": "SEASON", "direction": "DESC"]], type: .object(Work.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(works: Work? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "works": works.flatMap { (value: Work) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var works: Work? {
        get {
          return (resultMap["works"] as? ResultMap).flatMap { Work(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "works")
        }
      }

      public struct Work: GraphQLSelectionSet {
        public static let possibleTypes = ["WorkConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
          GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil, pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "WorkConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
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

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["Work"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(MinimumWork.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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

            public var minimumWork: MinimumWork {
              get {
                return MinimumWork(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes = ["PageInfo"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("endCursor", type: .scalar(String.self)),
            GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
          ]

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

public final class SearchWorksQuery: GraphQLQuery {
  /// query SearchWorks($season: String!, $after: String) {
  ///   searchWorks(seasons: [$season], orderBy: {field: WATCHERS_COUNT, direction: DESC}, first: 30, after: $after) {
  ///     __typename
  ///     nodes {
  ///       __typename
  ///       ...MinimumWork
  ///     }
  ///     pageInfo {
  ///       __typename
  ///       endCursor
  ///       hasNextPage
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query SearchWorks($season: String!, $after: String) { searchWorks(seasons: [$season], orderBy: {field: WATCHERS_COUNT, direction: DESC}, first: 30, after: $after) { __typename nodes { __typename ...MinimumWork } pageInfo { __typename endCursor hasNextPage } } }"

  public let operationName = "SearchWorks"

  public var queryDocument: String { return operationDefinition.appending(MinimumWork.fragmentDefinition) }

  public var season: String
  public var after: String?

  public init(season: String, after: String? = nil) {
    self.season = season
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["season": season, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("searchWorks", arguments: ["seasons": [GraphQLVariable("season")], "orderBy": ["field": "WATCHERS_COUNT", "direction": "DESC"], "first": 30, "after": GraphQLVariable("after")], type: .object(SearchWork.selections)),
    ]

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
      public static let possibleTypes = ["WorkConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
        GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nodes: [Node?]? = nil, pageInfo: PageInfo) {
        self.init(unsafeResultMap: ["__typename": "WorkConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
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

      /// Information to aid in pagination.
      public var pageInfo: PageInfo {
        get {
          return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes = ["Work"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(MinimumWork.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

          public var minimumWork: MinimumWork {
            get {
              return MinimumWork(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }

      public struct PageInfo: GraphQLSelectionSet {
        public static let possibleTypes = ["PageInfo"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("endCursor", type: .scalar(String.self)),
          GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
        ]

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

public final class SearchWorksByIdQuery: GraphQLQuery {
  /// query SearchWorksByID($annictId: Int!, $after: String) {
  ///   searchWorks(annictIds: [$annictId]) {
  ///     __typename
  ///     nodes {
  ///       __typename
  ///       episodes(first: 30, after: $after, orderBy: {field: SORT_NUMBER, direction: ASC}) {
  ///         __typename
  ///         nodes {
  ///           __typename
  ///           ...MinimumEpisode
  ///         }
  ///         pageInfo {
  ///           __typename
  ///           ...PageInfoF
  ///         }
  ///       }
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query SearchWorksByID($annictId: Int!, $after: String) { searchWorks(annictIds: [$annictId]) { __typename nodes { __typename episodes(first: 30, after: $after, orderBy: {field: SORT_NUMBER, direction: ASC}) { __typename nodes { __typename ...MinimumEpisode } pageInfo { __typename ...PageInfoF } } } } }"

  public let operationName = "SearchWorksByID"

  public var queryDocument: String { return operationDefinition.appending(MinimumEpisode.fragmentDefinition).appending(PageInfoF.fragmentDefinition) }

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
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("searchWorks", arguments: ["annictIds": [GraphQLVariable("annictId")]], type: .object(SearchWork.selections)),
    ]

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
      public static let possibleTypes = ["WorkConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
      ]

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
        public static let possibleTypes = ["Work"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("episodes", arguments: ["first": 30, "after": GraphQLVariable("after"), "orderBy": ["field": "SORT_NUMBER", "direction": "ASC"]], type: .object(Episode.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(episodes: Episode? = nil) {
          self.init(unsafeResultMap: ["__typename": "Work", "episodes": episodes.flatMap { (value: Episode) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

        public struct Episode: GraphQLSelectionSet {
          public static let possibleTypes = ["EpisodeConnection"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(nodes: [Node?]? = nil, pageInfo: PageInfo) {
            self.init(unsafeResultMap: ["__typename": "EpisodeConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
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

          /// Information to aid in pagination.
          public var pageInfo: PageInfo {
            get {
              return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Episode"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(MinimumEpisode.self),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, sortNumber: Int, viewerRecordsCount: Int, recordCommentsCount: Int, viewerDidTrack: Bool) {
              self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "sortNumber": sortNumber, "viewerRecordsCount": viewerRecordsCount, "recordCommentsCount": recordCommentsCount, "viewerDidTrack": viewerDidTrack])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
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

              public var minimumEpisode: MinimumEpisode {
                get {
                  return MinimumEpisode(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }

          public struct PageInfo: GraphQLSelectionSet {
            public static let possibleTypes = ["PageInfo"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PageInfoF.self),
            ]

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

              public var pageInfoF: PageInfoF {
                get {
                  return PageInfoF(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class SearchWorksByTitleQuery: GraphQLQuery {
  /// query SearchWorksByTitle($title: String!) {
  ///   searchWorks(titles: [$title], orderBy: {field: WATCHERS_COUNT, direction: DESC}, first: 30) {
  ///     __typename
  ///     nodes {
  ///       __typename
  ///       ...MinimumWork
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query SearchWorksByTitle($title: String!) { searchWorks(titles: [$title], orderBy: {field: WATCHERS_COUNT, direction: DESC}, first: 30) { __typename nodes { __typename ...MinimumWork } } }"

  public let operationName = "SearchWorksByTitle"

  public var queryDocument: String { return operationDefinition.appending(MinimumWork.fragmentDefinition) }

  public var title: String

  public init(title: String) {
    self.title = title
  }

  public var variables: GraphQLMap? {
    return ["title": title]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("searchWorks", arguments: ["titles": [GraphQLVariable("title")], "orderBy": ["field": "WATCHERS_COUNT", "direction": "DESC"], "first": 30], type: .object(SearchWork.selections)),
    ]

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
      public static let possibleTypes = ["WorkConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
      ]

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
        public static let possibleTypes = ["Work"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(MinimumWork.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

          public var minimumWork: MinimumWork {
            get {
              return MinimumWork(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public final class UpdateStatusMutation: GraphQLMutation {
  /// mutation UpdateStatus($state: StatusState!, $workId: ID!) {
  ///   updateStatus(input: {state: $state, workId: $workId}) {
  ///     __typename
  ///     work {
  ///       __typename
  ///       ...MinimumWork
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "mutation UpdateStatus($state: StatusState!, $workId: ID!) { updateStatus(input: {state: $state, workId: $workId}) { __typename work { __typename ...MinimumWork } } }"

  public let operationName = "UpdateStatus"

  public var queryDocument: String { return operationDefinition.appending(MinimumWork.fragmentDefinition) }

  public var state: StatusState
  public var workId: GraphQLID

  public init(state: StatusState, workId: GraphQLID) {
    self.state = state
    self.workId = workId
  }

  public var variables: GraphQLMap? {
    return ["state": state, "workId": workId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateStatus", arguments: ["input": ["state": GraphQLVariable("state"), "workId": GraphQLVariable("workId")]], type: .object(UpdateStatus.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateStatus: UpdateStatus? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateStatus": updateStatus.flatMap { (value: UpdateStatus) -> ResultMap in value.resultMap }])
    }

    public var updateStatus: UpdateStatus? {
      get {
        return (resultMap["updateStatus"] as? ResultMap).flatMap { UpdateStatus(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateStatus")
      }
    }

    public struct UpdateStatus: GraphQLSelectionSet {
      public static let possibleTypes = ["UpdateStatusPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("work", type: .object(Work.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(work: Work? = nil) {
        self.init(unsafeResultMap: ["__typename": "UpdateStatusPayload", "work": work.flatMap { (value: Work) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var work: Work? {
        get {
          return (resultMap["work"] as? ResultMap).flatMap { Work(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "work")
        }
      }

      public struct Work: GraphQLSelectionSet {
        public static let possibleTypes = ["Work"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(MinimumWork.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

          public var minimumWork: MinimumWork {
            get {
              return MinimumWork(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }
  }
}

public struct EpisodeDetails: GraphQLFragment {
  /// fragment EpisodeDetails on Episode {
  ///   __typename
  ///   id
  ///   annictId
  ///   title
  ///   viewerRecordsCount
  ///   viewerDidTrack
  ///   numberText
  /// }
  public static let fragmentDefinition =
    "fragment EpisodeDetails on Episode { __typename id annictId title viewerRecordsCount viewerDidTrack numberText }"

  public static let possibleTypes = ["Episode"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
    GraphQLField("viewerDidTrack", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("numberText", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, title: String? = nil, viewerRecordsCount: Int, viewerDidTrack: Bool, numberText: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "viewerRecordsCount": viewerRecordsCount, "viewerDidTrack": viewerDidTrack, "numberText": numberText])
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

  public var viewerRecordsCount: Int {
    get {
      return resultMap["viewerRecordsCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerRecordsCount")
    }
  }

  public var viewerDidTrack: Bool {
    get {
      return resultMap["viewerDidTrack"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerDidTrack")
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
}

public struct MinimumWork: GraphQLFragment {
  /// fragment MinimumWork on Work {
  ///   __typename
  ///   id
  ///   annictId
  ///   title
  ///   episodesCount
  ///   watchersCount
  ///   reviewsCount
  ///   seasonName
  ///   seasonYear
  ///   viewerStatusState
  ///   image {
  ///     __typename
  ///     recommendedImageUrl
  ///     twitterAvatarUrl
  ///   }
  /// }
  public static let fragmentDefinition =
    "fragment MinimumWork on Work { __typename id annictId title episodesCount watchersCount reviewsCount seasonName seasonYear viewerStatusState image { __typename recommendedImageUrl twitterAvatarUrl } }"

  public static let possibleTypes = ["Work"]

  public static let selections: [GraphQLSelection] = [
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
    GraphQLField("image", type: .object(Image.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, title: String, episodesCount: Int, watchersCount: Int, reviewsCount: Int, seasonName: SeasonName? = nil, seasonYear: Int? = nil, viewerStatusState: StatusState? = nil, image: Image? = nil) {
    self.init(unsafeResultMap: ["__typename": "Work", "id": id, "annictId": annictId, "title": title, "episodesCount": episodesCount, "watchersCount": watchersCount, "reviewsCount": reviewsCount, "seasonName": seasonName, "seasonYear": seasonYear, "viewerStatusState": viewerStatusState, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
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

  public var image: Image? {
    get {
      return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "image")
    }
  }

  public struct Image: GraphQLSelectionSet {
    public static let possibleTypes = ["WorkImage"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("recommendedImageUrl", type: .scalar(String.self)),
      GraphQLField("twitterAvatarUrl", type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(recommendedImageUrl: String? = nil, twitterAvatarUrl: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "WorkImage", "recommendedImageUrl": recommendedImageUrl, "twitterAvatarUrl": twitterAvatarUrl])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var recommendedImageUrl: String? {
      get {
        return resultMap["recommendedImageUrl"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "recommendedImageUrl")
      }
    }

    public var twitterAvatarUrl: String? {
      get {
        return resultMap["twitterAvatarUrl"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "twitterAvatarUrl")
      }
    }
  }
}

public struct MinimumUser: GraphQLFragment {
  /// fragment MinimumUser on User {
  ///   __typename
  ///   annictId
  ///   name
  ///   username
  ///   avatarUrl
  /// }
  public static let fragmentDefinition =
    "fragment MinimumUser on User { __typename annictId name username avatarUrl }"

  public static let possibleTypes = ["User"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("username", type: .nonNull(.scalar(String.self))),
    GraphQLField("avatarUrl", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(annictId: Int, name: String, username: String, avatarUrl: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "User", "annictId": annictId, "name": name, "username": username, "avatarUrl": avatarUrl])
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
}

public struct MinimumEpisode: GraphQLFragment {
  /// fragment MinimumEpisode on Episode {
  ///   __typename
  ///   id
  ///   annictId
  ///   title
  ///   numberText
  ///   sortNumber
  ///   viewerRecordsCount
  ///   recordCommentsCount
  ///   viewerDidTrack
  /// }
  public static let fragmentDefinition =
    "fragment MinimumEpisode on Episode { __typename id annictId title numberText sortNumber viewerRecordsCount recordCommentsCount viewerDidTrack }"

  public static let possibleTypes = ["Episode"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
    GraphQLField("title", type: .scalar(String.self)),
    GraphQLField("numberText", type: .scalar(String.self)),
    GraphQLField("sortNumber", type: .nonNull(.scalar(Int.self))),
    GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
    GraphQLField("recordCommentsCount", type: .nonNull(.scalar(Int.self))),
    GraphQLField("viewerDidTrack", type: .nonNull(.scalar(Bool.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, title: String? = nil, numberText: String? = nil, sortNumber: Int, viewerRecordsCount: Int, recordCommentsCount: Int, viewerDidTrack: Bool) {
    self.init(unsafeResultMap: ["__typename": "Episode", "id": id, "annictId": annictId, "title": title, "numberText": numberText, "sortNumber": sortNumber, "viewerRecordsCount": viewerRecordsCount, "recordCommentsCount": recordCommentsCount, "viewerDidTrack": viewerDidTrack])
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

  public var sortNumber: Int {
    get {
      return resultMap["sortNumber"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "sortNumber")
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

  public var recordCommentsCount: Int {
    get {
      return resultMap["recordCommentsCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "recordCommentsCount")
    }
  }

  public var viewerDidTrack: Bool {
    get {
      return resultMap["viewerDidTrack"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerDidTrack")
    }
  }
}

public struct PageInfoFrag: GraphQLFragment {
  /// fragment PageInfoFrag on PageInfo {
  ///   __typename
  ///   endCursor
  ///   hasNextPage
  ///   hasPreviousPage
  ///   startCursor
  /// }
  public static let fragmentDefinition =
    "fragment PageInfoFrag on PageInfo { __typename endCursor hasNextPage hasPreviousPage startCursor }"

  public static let possibleTypes = ["PageInfo"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("endCursor", type: .scalar(String.self)),
    GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("hasPreviousPage", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("startCursor", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(endCursor: String? = nil, hasNextPage: Bool, hasPreviousPage: Bool, startCursor: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage, "hasPreviousPage": hasPreviousPage, "startCursor": startCursor])
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

  /// When paginating backwards, are there more items?
  public var hasPreviousPage: Bool {
    get {
      return resultMap["hasPreviousPage"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "hasPreviousPage")
    }
  }

  /// When paginating backwards, the cursor to continue.
  public var startCursor: String? {
    get {
      return resultMap["startCursor"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "startCursor")
    }
  }
}

public struct MinimumRecord: GraphQLFragment {
  /// fragment MinimumRecord on Record {
  ///   __typename
  ///   id
  ///   annictId
  ///   comment
  ///   commentsCount
  ///   createdAt
  ///   likesCount
  ///   ratingState
  ///   user {
  ///     __typename
  ///     ...MinimumUser
  ///   }
  /// }
  public static let fragmentDefinition =
    "fragment MinimumRecord on Record { __typename id annictId comment commentsCount createdAt likesCount ratingState user { __typename ...MinimumUser } }"

  public static let possibleTypes = ["Record"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
    GraphQLField("comment", type: .scalar(String.self)),
    GraphQLField("commentsCount", type: .nonNull(.scalar(Int.self))),
    GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
    GraphQLField("likesCount", type: .nonNull(.scalar(Int.self))),
    GraphQLField("ratingState", type: .scalar(RatingState.self)),
    GraphQLField("user", type: .nonNull(.object(User.selections))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, annictId: Int, comment: String? = nil, commentsCount: Int, createdAt: String, likesCount: Int, ratingState: RatingState? = nil, user: User) {
    self.init(unsafeResultMap: ["__typename": "Record", "id": id, "annictId": annictId, "comment": comment, "commentsCount": commentsCount, "createdAt": createdAt, "likesCount": likesCount, "ratingState": ratingState, "user": user.resultMap])
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

  public var commentsCount: Int {
    get {
      return resultMap["commentsCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "commentsCount")
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

  public var likesCount: Int {
    get {
      return resultMap["likesCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "likesCount")
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

  public var user: User {
    get {
      return User(unsafeResultMap: resultMap["user"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "user")
    }
  }

  public struct User: GraphQLSelectionSet {
    public static let possibleTypes = ["User"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLFragmentSpread(MinimumUser.self),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(annictId: Int, name: String, username: String, avatarUrl: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "User", "annictId": annictId, "name": name, "username": username, "avatarUrl": avatarUrl])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
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

      public var minimumUser: MinimumUser {
        get {
          return MinimumUser(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}

public struct PageInfoF: GraphQLFragment {
  /// fragment PageInfoF on PageInfo {
  ///   __typename
  ///   endCursor
  ///   hasNextPage
  /// }
  public static let fragmentDefinition =
    "fragment PageInfoF on PageInfo { __typename endCursor hasNextPage }"

  public static let possibleTypes = ["PageInfo"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("endCursor", type: .scalar(String.self)),
    GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
  ]

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
