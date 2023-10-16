//
//  WeightedEdge.swift
//  Graph
//
//  Created by Thomas Segkoulis on 15.10.23.
//

import Foundation

public protocol WeightedEdge: Edge, Comparable {
	var weight: Double { get }
}
