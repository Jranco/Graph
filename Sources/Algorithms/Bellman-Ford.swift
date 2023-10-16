//
//  Bellman-Ford.swift
//  Algorithms
//
//  Created by Thomas Segkoulis on 15.10.23.
//

import Foundation
import Graph

public struct BellmanFord<VerticeType: Vertice, EdgeType: WeightedEdge> {
	var graph: GraphBase<VerticeType, EdgeType>
	var source: VerticeType

	public typealias Distance = Double

	public init(graph: GraphBase<VerticeType, EdgeType>, source: VerticeType) {
		self.graph = graph
		self.source = source
	}

	public func execute() throws -> [VerticeType: Vector] {
		guard graph.existsVertice(vertice: source) else {
			throw BellmanFordError.sourceNotPartOfGraph
		}
		/// Initialize distance matrix
		var distance: [VerticeType: Vector] = graph.adjacency.keys.reduce(into: [VerticeType: Vector]()) { partialResult, vertice in
			if vertice == source {
				partialResult[vertice] = .init(distance: 0.0, predecessor: nil)
			} else {
				partialResult[vertice] = .init(distance: .infinity, predecessor: nil)
			}
		}
		
		for _ in 1...graph.adjacency.keys.count - 1 {
			
			BFS(graph: graph).execute(parent: source) { currentVertice in
				if
					let currentVector = distance[currentVertice],
					let edges = graph.adjacency[currentVertice]
				{
					let currentDistance = currentVector.distance
					edges.forEach {
						let tmpDistance = distance[$0.key]?.distance
						let newDistance = currentVertice == source ? $0.value.weight : currentDistance + $0.value.weight
						if
							let tmpDistance = tmpDistance,
							newDistance < tmpDistance
						{
							distance[$0.key] = .init(distance: newDistance, predecessor: currentVertice)
						}
					}
				}
			}
		}
		return distance
	}
}

public extension BellmanFord {
	struct Vector {
		var distance: Distance
		var predecessor: VerticeType?
	}
}

enum BellmanFordError: Error {
	case sourceNotPartOfGraph
}

//function bellmanFord(G, S)
//  for each vertex V in G
//	distance[V] <- infinite
//	  previous[V] <- NULL
//  distance[S] <- 0
//
//  for each vertex V in G
//	for each edge (U,V) in G
//	  tempDistance <- distance[U] + edge_weight(U, V)
//	  if tempDistance < distance[V]
//		distance[V] <- tempDistance
//		previous[V] <- U
//
//  for each edge (U,V) in G
//	If distance[U] + edge_weight(U, V) < distance[V}
//	  Error: Negative Cycle Exists
//
//  return distance[], previous[]
