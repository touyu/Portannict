//  This file was automatically generated and should not be edited.

import Apollo

public enum StatusState: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
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
}

public final class GetViewerWorksQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetViewerWorks($state: StatusState) {\n  viewer {\n    __typename\n    works(state: $state, first: 10) {\n      __typename\n      edges {\n        __typename\n        node {\n          __typename\n          title\n          image {\n            __typename\n            recommendedImageUrl\n            twitterAvatarUrl\n          }\n        }\n      }\n    }\n  }\n}"

  public var state: StatusState?

  public init(state: StatusState? = nil) {
    self.state = state
  }

  public var variables: GraphQLMap? {
    return ["state": state]
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
        GraphQLField("works", arguments: ["state": GraphQLVariable("state"), "first": 10], type: .object(Work.selections)),
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
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "WorkConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
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
          public static let possibleTypes = ["WorkEdge"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil) {
            self.init(unsafeResultMap: ["__typename": "WorkEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Work"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
              GraphQLField("image", type: .object(Image.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(title: String, image: Image? = nil) {
              self.init(unsafeResultMap: ["__typename": "Work", "title": title, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
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
        }
      }
    }
  }
}

public final class GetViewerInfoQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetViewerInfo {\n  viewer {\n    __typename\n    watchingCount\n    recordsCount\n    followersCount\n    followingsCount\n    description\n    username\n    name\n    avatarUrl\n  }\n}"

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
        GraphQLField("username", type: .nonNull(.scalar(String.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("avatarUrl", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(watchingCount: Int, recordsCount: Int, followersCount: Int, followingsCount: Int, description: String, username: String, name: String, avatarUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "User", "watchingCount": watchingCount, "recordsCount": recordsCount, "followersCount": followersCount, "followingsCount": followingsCount, "description": description, "username": username, "name": name, "avatarUrl": avatarUrl])
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
  public let operationDefinition =
    "query GetViewerWatchingEpisodes {\n  viewer {\n    __typename\n    works(state: WATCHING, first: 10) {\n      __typename\n      edges {\n        __typename\n        node {\n          __typename\n          title\n          episodes(orderBy: {field: CREATED_AT, direction: DESC}) {\n            __typename\n            edges {\n              __typename\n              node {\n                __typename\n                annictId\n                title\n                viewerRecordsCount\n              }\n            }\n          }\n        }\n      }\n    }\n  }\n}"

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
        GraphQLField("works", arguments: ["state": "WATCHING", "first": 10], type: .object(Work.selections)),
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
          GraphQLField("edges", type: .list(.object(Edge.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "WorkConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
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
          public static let possibleTypes = ["WorkEdge"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("node", type: .object(Node.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(node: Node? = nil) {
            self.init(unsafeResultMap: ["__typename": "WorkEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The item at the end of the edge.
          public var node: Node? {
            get {
              return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "node")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes = ["Work"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("title", type: .nonNull(.scalar(String.self))),
              GraphQLField("episodes", arguments: ["orderBy": ["field": "CREATED_AT", "direction": "DESC"]], type: .object(Episode.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(title: String, episodes: Episode? = nil) {
              self.init(unsafeResultMap: ["__typename": "Work", "title": title, "episodes": episodes.flatMap { (value: Episode) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
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
                GraphQLField("edges", type: .list(.object(Edge.selections))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(edges: [Edge?]? = nil) {
                self.init(unsafeResultMap: ["__typename": "EpisodeConnection", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
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
                public static let possibleTypes = ["EpisodeEdge"]

                public static let selections: [GraphQLSelection] = [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("node", type: .object(Node.selections)),
                ]

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(node: Node? = nil) {
                  self.init(unsafeResultMap: ["__typename": "EpisodeEdge", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                /// The item at the end of the edge.
                public var node: Node? {
                  get {
                    return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
                  }
                  set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "node")
                  }
                }

                public struct Node: GraphQLSelectionSet {
                  public static let possibleTypes = ["Episode"]

                  public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("annictId", type: .nonNull(.scalar(Int.self))),
                    GraphQLField("title", type: .scalar(String.self)),
                    GraphQLField("viewerRecordsCount", type: .nonNull(.scalar(Int.self))),
                  ]

                  public private(set) var resultMap: ResultMap

                  public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                  }

                  public init(annictId: Int, title: String? = nil, viewerRecordsCount: Int) {
                    self.init(unsafeResultMap: ["__typename": "Episode", "annictId": annictId, "title": title, "viewerRecordsCount": viewerRecordsCount])
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
                }
              }
            }
          }
        }
      }
    }
  }
}

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