//
//  ChessPiecesShapes.swift
//  miniChess
//
//  Created by Nader Alfares on 2/2/26.
//
import SwiftUI

// MARK: - Enhanced Pawn Shape
struct PawnShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Base with rounded corners
        path.move(to: CGPoint(x: width * 0.22, y: height * 0.95))
        path.addLine(to: CGPoint(x: width * 0.78, y: height * 0.95))
        path.addQuadCurve(to: CGPoint(x: width * 0.72, y: height * 0.88),
                         control: CGPoint(x: width * 0.76, y: height * 0.92))
        path.addLine(to: CGPoint(x: width * 0.68, y: height * 0.82))
        path.addQuadCurve(to: CGPoint(x: width * 0.32, y: height * 0.82),
                         control: CGPoint(x: width * 0.5, y: height * 0.8))
        path.addLine(to: CGPoint(x: width * 0.28, y: height * 0.88))
        path.addQuadCurve(to: CGPoint(x: width * 0.22, y: height * 0.95),
                         control: CGPoint(x: width * 0.24, y: height * 0.92))
        path.closeSubpath()
        
        // Collar/neck ring
        path.move(to: CGPoint(x: width * 0.36, y: height * 0.82))
        path.addQuadCurve(to: CGPoint(x: width * 0.64, y: height * 0.82),
                         control: CGPoint(x: width * 0.5, y: height * 0.79))
        path.addQuadCurve(to: CGPoint(x: width * 0.62, y: height * 0.75),
                         control: CGPoint(x: width * 0.65, y: height * 0.78))
        path.addQuadCurve(to: CGPoint(x: width * 0.38, y: height * 0.75),
                         control: CGPoint(x: width * 0.5, y: height * 0.73))
        path.addQuadCurve(to: CGPoint(x: width * 0.36, y: height * 0.82),
                         control: CGPoint(x: width * 0.35, y: height * 0.78))
        path.closeSubpath()
        
        // Stem with slight taper
        path.move(to: CGPoint(x: width * 0.4, y: height * 0.75))
        path.addQuadCurve(to: CGPoint(x: width * 0.43, y: height * 0.45),
                         control: CGPoint(x: width * 0.38, y: height * 0.6))
        path.addQuadCurve(to: CGPoint(x: width * 0.57, y: height * 0.45),
                         control: CGPoint(x: width * 0.5, y: height * 0.43))
        path.addQuadCurve(to: CGPoint(x: width * 0.6, y: height * 0.75),
                         control: CGPoint(x: width * 0.62, y: height * 0.6))
        path.closeSubpath()
        
        // Neck narrowing before head
        path.move(to: CGPoint(x: width * 0.44, y: height * 0.45))
        path.addQuadCurve(to: CGPoint(x: width * 0.45, y: height * 0.38),
                         control: CGPoint(x: width * 0.42, y: height * 0.42))
        path.addQuadCurve(to: CGPoint(x: width * 0.55, y: height * 0.38),
                         control: CGPoint(x: width * 0.5, y: height * 0.36))
        path.addQuadCurve(to: CGPoint(x: width * 0.56, y: height * 0.45),
                         control: CGPoint(x: width * 0.58, y: height * 0.42))
        path.closeSubpath()
        
        // Head (sphere)
        let headCenter = CGPoint(x: width * 0.5, y: height * 0.23)
        let headRadius = width * 0.16
        path.addEllipse(in: CGRect(x: headCenter.x - headRadius,
                                  y: headCenter.y - headRadius,
                                  width: headRadius * 2,
                                  height: headRadius * 2))
        
        return path
    }
}

// MARK: - Enhanced Rook Shape
struct RookShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Base with elegance
        path.move(to: CGPoint(x: width * 0.18, y: height * 0.95))
        path.addLine(to: CGPoint(x: width * 0.82, y: height * 0.95))
        path.addQuadCurve(to: CGPoint(x: width * 0.76, y: height * 0.88),
                         control: CGPoint(x: width * 0.8, y: height * 0.92))
        path.addLine(to: CGPoint(x: width * 0.72, y: height * 0.82))
        path.addQuadCurve(to: CGPoint(x: width * 0.28, y: height * 0.82),
                         control: CGPoint(x: width * 0.5, y: height * 0.8))
        path.addLine(to: CGPoint(x: width * 0.24, y: height * 0.88))
        path.addQuadCurve(to: CGPoint(x: width * 0.18, y: height * 0.95),
                         control: CGPoint(x: width * 0.2, y: height * 0.92))
        path.closeSubpath()
        
        // Lower body with curves
        path.move(to: CGPoint(x: width * 0.32, y: height * 0.82))
        path.addQuadCurve(to: CGPoint(x: width * 0.36, y: height * 0.65),
                         control: CGPoint(x: width * 0.3, y: height * 0.74))
        path.addLine(to: CGPoint(x: width * 0.38, y: height * 0.35))
        path.addQuadCurve(to: CGPoint(x: width * 0.32, y: height * 0.28),
                         control: CGPoint(x: width * 0.34, y: height * 0.31))
        
        // Connect to battlements
        path.addLine(to: CGPoint(x: width * 0.32, y: height * 0.25))
        path.addLine(to: CGPoint(x: width * 0.28, y: height * 0.25))
        path.addLine(to: CGPoint(x: width * 0.28, y: height * 0.12))
        path.addLine(to: CGPoint(x: width * 0.38, y: height * 0.12))
        path.addLine(to: CGPoint(x: width * 0.38, y: height * 0.22))
        path.addLine(to: CGPoint(x: width * 0.45, y: height * 0.22))
        path.addLine(to: CGPoint(x: width * 0.45, y: height * 0.12))
        path.addLine(to: CGPoint(x: width * 0.55, y: height * 0.12))
        path.addLine(to: CGPoint(x: width * 0.55, y: height * 0.22))
        path.addLine(to: CGPoint(x: width * 0.62, y: height * 0.22))
        path.addLine(to: CGPoint(x: width * 0.62, y: height * 0.12))
        path.addLine(to: CGPoint(x: width * 0.72, y: height * 0.12))
        path.addLine(to: CGPoint(x: width * 0.72, y: height * 0.25))
        path.addLine(to: CGPoint(x: width * 0.68, y: height * 0.25))
        
        // Right side body
        path.addLine(to: CGPoint(x: width * 0.68, y: height * 0.28))
        path.addQuadCurve(to: CGPoint(x: width * 0.62, y: height * 0.35),
                         control: CGPoint(x: width * 0.66, y: height * 0.31))
        path.addLine(to: CGPoint(x: width * 0.64, y: height * 0.65))
        path.addQuadCurve(to: CGPoint(x: width * 0.68, y: height * 0.82),
                         control: CGPoint(x: width * 0.7, y: height * 0.74))
        path.closeSubpath()
        
        return path
    }
}

// MARK: - Enhanced Knight Shape
struct KnightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Base
        path.move(to: CGPoint(x: width * 0.18, y: height * 0.95))
        path.addLine(to: CGPoint(x: width * 0.82, y: height * 0.95))
        path.addQuadCurve(to: CGPoint(x: width * 0.76, y: height * 0.88),
                         control: CGPoint(x: width * 0.8, y: height * 0.92))
        path.addLine(to: CGPoint(x: width * 0.72, y: height * 0.82))
        path.addQuadCurve(to: CGPoint(x: width * 0.28, y: height * 0.82),
                         control: CGPoint(x: width * 0.5, y: height * 0.8))
        path.addLine(to: CGPoint(x: width * 0.24, y: height * 0.88))
        path.addQuadCurve(to: CGPoint(x: width * 0.18, y: height * 0.95),
                         control: CGPoint(x: width * 0.2, y: height * 0.92))
        path.closeSubpath()
        
        // Horse head profile - traditional knight shape
        path.move(to: CGPoint(x: width * 0.32, y: height * 0.82))
        
        // Lower back of neck
        path.addQuadCurve(to: CGPoint(x: width * 0.35, y: height * 0.70),
                         control: CGPoint(x: width * 0.30, y: height * 0.76))
        
        // Mid back of neck
        path.addQuadCurve(to: CGPoint(x: width * 0.36, y: height * 0.58),
                         control: CGPoint(x: width * 0.32, y: height * 0.64))
        
        // Upper back of neck/mane
        path.addQuadCurve(to: CGPoint(x: width * 0.38, y: height * 0.45),
                         control: CGPoint(x: width * 0.34, y: height * 0.52))
        
        // Crest of mane
        path.addQuadCurve(to: CGPoint(x: width * 0.42, y: height * 0.32),
                         control: CGPoint(x: width * 0.36, y: height * 0.38))
        
        // Top of head behind ears
        path.addQuadCurve(to: CGPoint(x: width * 0.46, y: height * 0.22),
                         control: CGPoint(x: width * 0.40, y: height * 0.27))
        
        // Pointed ear
        path.addLine(to: CGPoint(x: width * 0.50, y: height * 0.15))
        path.addLine(to: CGPoint(x: width * 0.52, y: height * 0.20))
        
        // Forehead
        path.addQuadCurve(to: CGPoint(x: width * 0.58, y: height * 0.24),
                         control: CGPoint(x: width * 0.54, y: height * 0.18))
        
        // Between eyes/bridge of nose
        path.addQuadCurve(to: CGPoint(x: width * 0.68, y: height * 0.30),
                         control: CGPoint(x: width * 0.62, y: height * 0.22))
        
        // Down the nose
        path.addQuadCurve(to: CGPoint(x: width * 0.76, y: height * 0.40),
                         control: CGPoint(x: width * 0.72, y: height * 0.32))
        
        // Nostril area
        path.addQuadCurve(to: CGPoint(x: width * 0.80, y: height * 0.48),
                         control: CGPoint(x: width * 0.80, y: height * 0.43))
        
        // Muzzle/mouth area
        path.addQuadCurve(to: CGPoint(x: width * 0.78, y: height * 0.54),
                         control: CGPoint(x: width * 0.82, y: height * 0.51))
        
        // Under the mouth/lip
        path.addQuadCurve(to: CGPoint(x: width * 0.73, y: height * 0.58),
                         control: CGPoint(x: width * 0.76, y: height * 0.57))
        
        // Chin curve
        path.addQuadCurve(to: CGPoint(x: width * 0.68, y: height * 0.62),
                         control: CGPoint(x: width * 0.71, y: height * 0.60))
        
        // Throat/neck connection
        path.addQuadCurve(to: CGPoint(x: width * 0.62, y: height * 0.68),
                         control: CGPoint(x: width * 0.66, y: height * 0.64))
        
        // Front of neck/chest
        path.addQuadCurve(to: CGPoint(x: width * 0.58, y: height * 0.76),
                         control: CGPoint(x: width * 0.60, y: height * 0.71))
        
        // To base
        path.addQuadCurve(to: CGPoint(x: width * 0.55, y: height * 0.82),
                         control: CGPoint(x: width * 0.57, y: height * 0.79))
        
        path.closeSubpath()
        
        // Eye detail
        let eyeCenter = CGPoint(x: width * 0.64, y: height * 0.36)
        let eyeRadius = width * 0.035
        path.addEllipse(in: CGRect(x: eyeCenter.x - eyeRadius,
                                  y: eyeCenter.y - eyeRadius,
                                  width: eyeRadius * 2,
                                  height: eyeRadius * 2))
        
        // Nostril detail
        let nostrilCenter = CGPoint(x: width * 0.76, y: height * 0.46)
        let nostrilRadius = width * 0.025
        path.addEllipse(in: CGRect(x: nostrilCenter.x - nostrilRadius,
                                  y: nostrilCenter.y - nostrilRadius,
                                  width: nostrilRadius * 2,
                                  height: nostrilRadius * 2))
        
        // Bridle/neck line detail
        path.move(to: CGPoint(x: width * 0.40, y: height * 0.58))
        path.addQuadCurve(to: CGPoint(x: width * 0.55, y: height * 0.68),
                         control: CGPoint(x: width * 0.48, y: height * 0.60))
        
        return path
    }
}

// MARK: - Enhanced Bishop Shape
struct BishopShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Base
        path.move(to: CGPoint(x: width * 0.18, y: height * 0.95))
        path.addLine(to: CGPoint(x: width * 0.82, y: height * 0.95))
        path.addQuadCurve(to: CGPoint(x: width * 0.76, y: height * 0.88),
                         control: CGPoint(x: width * 0.8, y: height * 0.92))
        path.addLine(to: CGPoint(x: width * 0.72, y: height * 0.82))
        path.addQuadCurve(to: CGPoint(x: width * 0.28, y: height * 0.82),
                         control: CGPoint(x: width * 0.5, y: height * 0.8))
        path.addLine(to: CGPoint(x: width * 0.24, y: height * 0.88))
        path.addQuadCurve(to: CGPoint(x: width * 0.18, y: height * 0.95),
                         control: CGPoint(x: width * 0.2, y: height * 0.92))
        path.closeSubpath()
        
        // Lower body with elegant curves
        path.move(to: CGPoint(x: width * 0.32, y: height * 0.82))
        path.addQuadCurve(to: CGPoint(x: width * 0.36, y: height * 0.7),
                         control: CGPoint(x: width * 0.29, y: height * 0.76))
        
        // Narrow waist
        path.addQuadCurve(to: CGPoint(x: width * 0.4, y: height * 0.58),
                         control: CGPoint(x: width * 0.34, y: height * 0.64))
        
        // Widen for middle section
        path.addQuadCurve(to: CGPoint(x: width * 0.42, y: height * 0.48),
                         control: CGPoint(x: width * 0.38, y: height * 0.53))
        
        // Upper narrowing
        path.addQuadCurve(to: CGPoint(x: width * 0.44, y: height * 0.38),
                         control: CGPoint(x: width * 0.40, y: height * 0.43))
        
        // Shoulder area
        path.addQuadCurve(to: CGPoint(x: width * 0.46, y: height * 0.32),
                         control: CGPoint(x: width * 0.43, y: height * 0.35))
        
        // Neck
        path.addLine(to: CGPoint(x: width * 0.465, y: height * 0.26))
        
        // Left side of mitre
        path.addQuadCurve(to: CGPoint(x: width * 0.48, y: height * 0.18),
                         control: CGPoint(x: width * 0.45, y: height * 0.22))
        path.addQuadCurve(to: CGPoint(x: width * 0.5, y: height * 0.08),
                         control: CGPoint(x: width * 0.46, y: height * 0.13))
        
        // Right side of mitre
        path.addQuadCurve(to: CGPoint(x: width * 0.52, y: height * 0.18),
                         control: CGPoint(x: width * 0.54, y: height * 0.13))
        path.addQuadCurve(to: CGPoint(x: width * 0.535, y: height * 0.26),
                         control: CGPoint(x: width * 0.55, y: height * 0.22))
        
        // Right neck
        path.addLine(to: CGPoint(x: width * 0.54, y: height * 0.32))
        
        // Right shoulder
        path.addQuadCurve(to: CGPoint(x: width * 0.56, y: height * 0.38),
                         control: CGPoint(x: width * 0.57, y: height * 0.35))
        
        // Right upper body
        path.addQuadCurve(to: CGPoint(x: width * 0.58, y: height * 0.48),
                         control: CGPoint(x: width * 0.60, y: height * 0.43))
        
        // Right middle
        path.addQuadCurve(to: CGPoint(x: width * 0.60, y: height * 0.58),
                         control: CGPoint(x: width * 0.62, y: height * 0.53))
        
        // Right lower
        path.addQuadCurve(to: CGPoint(x: width * 0.64, y: height * 0.7),
                         control: CGPoint(x: width * 0.66, y: height * 0.64))
        path.addQuadCurve(to: CGPoint(x: width * 0.68, y: height * 0.82),
                         control: CGPoint(x: width * 0.71, y: height * 0.76))
        path.closeSubpath()
        
        // Enhanced mitre top with ball
        let topCenter = CGPoint(x: width * 0.5, y: height * 0.1)
        let topRadius = width * 0.12
        path.addEllipse(in: CGRect(x: topCenter.x - topRadius,
                                  y: topCenter.y - topRadius,
                                  width: topRadius * 2,
                                  height: topRadius * 2))
        
        // Distinctive diagonal slit (bishop's characteristic)
        path.move(to: CGPoint(x: width * 0.41, y: height * 0.06))
        path.addQuadCurve(to: CGPoint(x: width * 0.59, y: height * 0.14),
                         control: CGPoint(x: width * 0.5, y: height * 0.08))
        path.addQuadCurve(to: CGPoint(x: width * 0.59, y: height * 0.17),
                         control: CGPoint(x: width * 0.61, y: height * 0.155))
        path.addQuadCurve(to: CGPoint(x: width * 0.41, y: height * 0.09),
                         control: CGPoint(x: width * 0.5, y: height * 0.15))
        path.closeSubpath()
        
        return path
    }
}

// MARK: - Enhanced Queen Shape
struct QueenShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Wider, more elegant base
        path.move(to: CGPoint(x: width * 0.12, y: height * 0.95))
        path.addLine(to: CGPoint(x: width * 0.88, y: height * 0.95))
        path.addQuadCurve(to: CGPoint(x: width * 0.82, y: height * 0.88),
                         control: CGPoint(x: width * 0.86, y: height * 0.92))
        path.addLine(to: CGPoint(x: width * 0.78, y: height * 0.82))
        path.addQuadCurve(to: CGPoint(x: width * 0.22, y: height * 0.82),
                         control: CGPoint(x: width * 0.5, y: height * 0.8))
        path.addLine(to: CGPoint(x: width * 0.18, y: height * 0.88))
        path.addQuadCurve(to: CGPoint(x: width * 0.12, y: height * 0.95),
                         control: CGPoint(x: width * 0.14, y: height * 0.92))
        path.closeSubpath()
        
        // Graceful body with curves
        path.move(to: CGPoint(x: width * 0.26, y: height * 0.82))
        path.addQuadCurve(to: CGPoint(x: width * 0.32, y: height * 0.65),
                         control: CGPoint(x: width * 0.24, y: height * 0.74))
        path.addQuadCurve(to: CGPoint(x: width * 0.36, y: height * 0.48),
                         control: CGPoint(x: width * 0.30, y: height * 0.57))
        path.addLine(to: CGPoint(x: width * 0.38, y: height * 0.38))
        
        // Connect to crown base
        path.addLine(to: CGPoint(x: width * 0.62, y: height * 0.38))
        path.addLine(to: CGPoint(x: width * 0.64, y: height * 0.48))
        path.addQuadCurve(to: CGPoint(x: width * 0.68, y: height * 0.65),
                         control: CGPoint(x: width * 0.70, y: height * 0.57))
        path.addQuadCurve(to: CGPoint(x: width * 0.74, y: height * 0.82),
                         control: CGPoint(x: width * 0.76, y: height * 0.74))
        path.closeSubpath()
        
        // Ornate crown with five points and decorative spheres
        path.move(to: CGPoint(x: width * 0.32, y: height * 0.38))
        
        // Far left point with ball
        path.addLine(to: CGPoint(x: width * 0.22, y: height * 0.18))
        let ball1Center = CGPoint(x: width * 0.22, y: height * 0.15)
        let ballRadius = width * 0.04
        path.addEllipse(in: CGRect(x: ball1Center.x - ballRadius,
                                  y: ball1Center.y - ballRadius,
                                  width: ballRadius * 2,
                                  height: ballRadius * 2))
        path.move(to: CGPoint(x: width * 0.22, y: height * 0.18))
        path.addLine(to: CGPoint(x: width * 0.36, y: height * 0.32))
        
        // Center-left point with ball
        path.addLine(to: CGPoint(x: width * 0.36, y: height * 0.08))
        let ball2Center = CGPoint(x: width * 0.36, y: height * 0.05)
        path.addEllipse(in: CGRect(x: ball2Center.x - ballRadius,
                                  y: ball2Center.y - ballRadius,
                                  width: ballRadius * 2,
                                  height: ballRadius * 2))
        path.move(to: CGPoint(x: width * 0.36, y: height * 0.08))
        path.addLine(to: CGPoint(x: width * 0.44, y: height * 0.3))
        
        // Center point (tallest) with larger ball
        path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.03))
        let ball3Center = CGPoint(x: width * 0.5, y: height * 0.0)
        let largeBallRadius = width * 0.05
        path.addEllipse(in: CGRect(x: ball3Center.x - largeBallRadius,
                                  y: ball3Center.y - largeBallRadius,
                                  width: largeBallRadius * 2,
                                  height: largeBallRadius * 2))
        path.move(to: CGPoint(x: width * 0.5, y: height * 0.03))
        path.addLine(to: CGPoint(x: width * 0.56, y: height * 0.3))
        
        // Center-right point with ball
        path.addLine(to: CGPoint(x: width * 0.64, y: height * 0.08))
        let ball4Center = CGPoint(x: width * 0.64, y: height * 0.05)
        path.addEllipse(in: CGRect(x: ball4Center.x - ballRadius,
                                  y: ball4Center.y - ballRadius,
                                  width: ballRadius * 2,
                                  height: ballRadius * 2))
        path.move(to: CGPoint(x: width * 0.64, y: height * 0.08))
        path.addLine(to: CGPoint(x: width * 0.64, y: height * 0.32))
        
        // Far right point with ball
        path.addLine(to: CGPoint(x: width * 0.78, y: height * 0.18))
        let ball5Center = CGPoint(x: width * 0.78, y: height * 0.15)
        path.addEllipse(in: CGRect(x: ball5Center.x - ballRadius,
                                  y: ball5Center.y - ballRadius,
                                  width: ballRadius * 2,
                                  height: ballRadius * 2))
        path.move(to: CGPoint(x: width * 0.78, y: height * 0.18))
        path.addLine(to: CGPoint(x: width * 0.68, y: height * 0.38))
        
        path.closeSubpath()
        
        return path
    }
}

// MARK: - Enhanced King Shape
struct KingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        // Royal base (wider and more substantial)
        path.move(to: CGPoint(x: width * 0.12, y: height * 0.95))
        path.addLine(to: CGPoint(x: width * 0.88, y: height * 0.95))
        path.addQuadCurve(to: CGPoint(x: width * 0.82, y: height * 0.88),
                         control: CGPoint(x: width * 0.86, y: height * 0.92))
        path.addLine(to: CGPoint(x: width * 0.78, y: height * 0.82))
        path.addQuadCurve(to: CGPoint(x: width * 0.22, y: height * 0.82),
                         control: CGPoint(x: width * 0.5, y: height * 0.8))
        path.addLine(to: CGPoint(x: width * 0.18, y: height * 0.88))
        path.addQuadCurve(to: CGPoint(x: width * 0.12, y: height * 0.95),
                         control: CGPoint(x: width * 0.14, y: height * 0.92))
        path.closeSubpath()
        
        // Majestic body with curves
        path.move(to: CGPoint(x: width * 0.26, y: height * 0.82))
        path.addQuadCurve(to: CGPoint(x: width * 0.32, y: height * 0.65),
                         control: CGPoint(x: width * 0.24, y: height * 0.74))
        path.addQuadCurve(to: CGPoint(x: width * 0.36, y: height * 0.48),
                         control: CGPoint(x: width * 0.30, y: height * 0.57))
        path.addQuadCurve(to: CGPoint(x: width * 0.38, y: height * 0.32),
                         control: CGPoint(x: width * 0.34, y: height * 0.4))
        
        // Crown base platform
        path.addLine(to: CGPoint(x: width * 0.62, y: height * 0.32))
        
        path.addQuadCurve(to: CGPoint(x: width * 0.64, y: height * 0.48),
                         control: CGPoint(x: width * 0.66, y: height * 0.4))
        path.addQuadCurve(to: CGPoint(x: width * 0.68, y: height * 0.65),
                         control: CGPoint(x: width * 0.70, y: height * 0.57))
        path.addQuadCurve(to: CGPoint(x: width * 0.74, y: height * 0.82),
                         control: CGPoint(x: width * 0.76, y: height * 0.74))
        path.closeSubpath()
        
        // Decorative band at crown base
        path.move(to: CGPoint(x: width * 0.36, y: height * 0.32))
        path.addQuadCurve(to: CGPoint(x: width * 0.64, y: height * 0.32),
                         control: CGPoint(x: width * 0.5, y: height * 0.3))
        path.addQuadCurve(to: CGPoint(x: width * 0.62, y: height * 0.28),
                         control: CGPoint(x: width * 0.64, y: height * 0.3))
        path.addQuadCurve(to: CGPoint(x: width * 0.38, y: height * 0.28),
                         control: CGPoint(x: width * 0.5, y: height * 0.26))
        path.addQuadCurve(to: CGPoint(x: width * 0.36, y: height * 0.32),
                         control: CGPoint(x: width * 0.36, y: height * 0.3))
        path.closeSubpath()
        
        // Ornate cross on top
        // Vertical beam with decorative ends
        path.move(to: CGPoint(x: width * 0.46, y: height * 0.03))
        path.addLine(to: CGPoint(x: width * 0.54, y: height * 0.03))
        path.addLine(to: CGPoint(x: width * 0.54, y: height * 0.28))
        path.addQuadCurve(to: CGPoint(x: width * 0.5, y: height * 0.30),
                         control: CGPoint(x: width * 0.53, y: height * 0.29))
        path.addQuadCurve(to: CGPoint(x: width * 0.46, y: height * 0.28),
                         control: CGPoint(x: width * 0.47, y: height * 0.29))
        path.closeSubpath()
        
        // Horizontal beam
        path.move(to: CGPoint(x: width * 0.35, y: height * 0.13))
        path.addLine(to: CGPoint(x: width * 0.65, y: height * 0.13))
        path.addQuadCurve(to: CGPoint(x: width * 0.65, y: height * 0.19),
                         control: CGPoint(x: width * 0.67, y: height * 0.16))
        path.addLine(to: CGPoint(x: width * 0.35, y: height * 0.19))
        path.addQuadCurve(to: CGPoint(x: width * 0.35, y: height * 0.13),
                         control: CGPoint(x: width * 0.33, y: height * 0.16))
        path.closeSubpath()
        
        // Decorative top finial
        let topBallCenter = CGPoint(x: width * 0.5, y: height * 0.02)
        let topBallRadius = width * 0.045
        path.addEllipse(in: CGRect(x: topBallCenter.x - topBallRadius,
                                  y: topBallCenter.y - topBallRadius,
                                  width: topBallRadius * 2,
                                  height: topBallRadius * 2))
        
        // Side finials on horizontal beam
        let leftBallCenter = CGPoint(x: width * 0.34, y: height * 0.16)
        let sideBallRadius = width * 0.035
        path.addEllipse(in: CGRect(x: leftBallCenter.x - sideBallRadius,
                                  y: leftBallCenter.y - sideBallRadius,
                                  width: sideBallRadius * 2,
                                  height: sideBallRadius * 2))
        
        let rightBallCenter = CGPoint(x: width * 0.66, y: height * 0.16)
        path.addEllipse(in: CGRect(x: rightBallCenter.x - sideBallRadius,
                                  y: rightBallCenter.y - sideBallRadius,
                                  width: sideBallRadius * 2,
                                  height: sideBallRadius * 2))
        
        return path
    }
}

// MARK: - Preview
#Preview("Chess Pieces") {
    VStack(spacing: 20) {
        Text("Chess Pieces Shapes").font(.title)
        
        HStack(spacing: 30) {
            VStack {
                PawnShape()
                    .fill(.black)
                    .frame(width: 60, height: 80)
                Text("Pawn")
            }
            
            VStack {
                RookShape()
                    .fill(.black)
                    .frame(width: 60, height: 80)
                Text("Rook")
            }
            
            VStack {
                KnightShape()
                    .fill(.black)
                    .frame(width: 60, height: 80)
                Text("Knight")
            }
        }
        
        HStack(spacing: 30) {
            VStack {
                BishopShape()
                    .fill(.black)
                    .frame(width: 60, height: 80)
                Text("Bishop")
            }
            
            VStack {
                QueenShape()
                    .fill(.black)
                    .frame(width: 60, height: 80)
                Text("Queen")
            }
            
            VStack {
                KingShape()
                    .fill(.black)
                    .frame(width: 60, height: 80)
                Text("King")
            }
        }
    }
    .padding()
}

