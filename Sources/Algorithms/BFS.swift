//
//  BFS.swift
//  Algorithms
//
//  Created by Thomas Segkoulis on 16.10.23.
//

import Graph

public class BFS<GraphType: Graph> {
	var graph: GraphType
	public typealias Vertice = GraphType.VerticeType
	private var visited: Set<Vertice> = []
	
	public init(graph: GraphType) {
		self.graph = graph
	}

	public func execute(parent: Vertice, blockDidVisit: @escaping (_ vertice: Vertice) -> Void) {
		guard !visited.contains(parent) else {
			return
		}
		blockDidVisit(parent)
		visited.insert(parent)
		graph.adjacency[parent]?.forEach({
			execute(parent: $0.key, blockDidVisit: blockDidVisit)
		})
	}
}
