//
//  DemoView.swift
//  SnippetLab
//
//  Created by Nader Alfares on 2/7/26.
//
import SwiftUI

/// Protocol that all demo views should conform to
/// This allows for dynamic instantiation and provides a common interface
protocol DemoView: View {
    init()
}
