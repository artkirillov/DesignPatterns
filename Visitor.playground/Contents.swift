import Foundation

final class Report: Visitable {
    
    var title: String
    var illustrations: [Data]
    var paragraphs: [String]
    var template: [Int: Int]
    
    init(title: String, illustrations: [Data] = [],
         paragraphs: [String] = [], template: [Int: Int] = [:]) {
        
        self.title = title
        self.illustrations = illustrations
        self.paragraphs = paragraphs
        self.template = template
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(report: self)
    }
}

final class SpreadSheet: Visitable {
    
    var title: String
    var structure: [[String]]
    
    init(title: String, structure: [[String]] = [[]]) {
        self.title = title
        self.structure = structure
    }
    
    func accept(visitor: Visitor) {
        visitor.visit(spreadsheet: self)
    }
}

protocol Visitor {
    func visit(report: Report)
    func visit(spreadsheet: SpreadSheet)
}

protocol Visitable {
    func accept(visitor: Visitor)
}

final class HTMLExporter: Visitor {
    
    func visit(report: Report) {
        print("Export report \"\(report.title)\" to HTML")
    }
    
    func visit(spreadsheet: SpreadSheet) {
        print("Export spreadsheet \"\(spreadsheet.title)\" to HTML")
    }
}

final class PDFExporter: Visitor {
    
    func visit(report: Report) {
        print("Export report \"\(report.title)\" to PDF")
    }
    
    func visit(spreadsheet: SpreadSheet) {
        print("Export spreadsheet \"\(spreadsheet.title)\" to PDF")
    }
}

let report1 = Report(title: "Report 1")
let report2 = Report(title: "Report 2")
let report3 = Report(title: "Report 3")

let spreadsheet1 = SpreadSheet(title: "SpreadSheet 1")
let spreadsheet2 = SpreadSheet(title: "SpreadSheet 2")

let htmlExporter = HTMLExporter()
let pdfExporter = PDFExporter()

let docs: [Visitable] = [report1, report2, report3, spreadsheet1, spreadsheet2]

docs.forEach { $0.accept(visitor: htmlExporter) }

print("-----")

docs.forEach { $0.accept(visitor: pdfExporter) }
