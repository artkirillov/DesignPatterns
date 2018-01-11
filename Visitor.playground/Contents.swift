import Foundation

class Document {
    
    var title: String
    var created: Date
    var author: String
    
    init(title: String, author: String) {
        self.title = title
        self.created = Date()
        self.author = author
    }
}

final class Report: Document, Visitable {
    
    var illustrations: [Data] = []
    var paragraphs: [String] = []
    var template: [String: String] = [:]
    
    func accept(visitor: Visitor) {
        visitor.visit(doc: self)
    }
}

final class SpreadSheet: Document, Visitable {
    
    var structure: [[String]] = [[]]
    
    func accept(visitor: Visitor) {
        visitor.visit(doc: self)
    }
}

protocol Visitor {
    func visit(doc: Report)
    func visit(doc: SpreadSheet)
}

protocol Visitable {
    func accept(visitor: Visitor)
}

final class HTMLExporter: Visitor {
    
    func visit(doc: Report) {
        print("Export \(doc.title) report to HTML")
    }
    
    func visit(doc: SpreadSheet) {
        print("Export \(doc.title) spreadsheet to HTML")
    }
}

final class PDFExporter: Visitor {
    
    func visit(doc: Report) {
        print("Export report to PDF")
    }
    
    func visit(doc: SpreadSheet) {
        print("Export spreadsheet to PDF")
    }
}

let doc1 = Report(title: "Report 1", author: "John Smith")
let doc2 = Report(title: "Report 2", author: "John Smith")
let doc3 = Report(title: "Report 3", author: "John Smith")

let doc4 = SpreadSheet(title: "SpreadSheet 1", author: "John Appleseed")
let doc5 = SpreadSheet(title: "SpreadSheet 2", author: "John Appleseed")

let htmlExporter = HTMLExporter()
let pdfExporter = PDFExporter()

for doc in [doc1, doc2, doc3] {
    doc.accept(visitor: htmlExporter)
}

for doc in [doc4, doc5] {
    doc.accept(visitor: htmlExporter)
    doc.accept(visitor: pdfExporter)
}
