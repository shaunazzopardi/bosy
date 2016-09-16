import XCTest

@testable import BoSy

class BooleanTest: XCTestCase {
    
    func testXnorTseitin() {
        let x = Proposition("x")
        let y = Proposition("y")
        
        let equiv = BinaryOperator(.Xnor, operands:[x, y])
        
        let sat_qbf = Quantifier(.Forall, variables: [x], scope: Quantifier(.Exists, variables: [y], scope: equiv))
        
        let qdimacsVisitor = QDIMACSVisitor(formula: sat_qbf)
        guard let (sat, _) = rareqs(qdimacs: "\(qdimacsVisitor)") else {
            XCTFail()
            return
        }
        XCTAssertEqual(sat, SolverResult.SAT, "\(sat_qbf) === SAT")
        
        let unsat_qbf = Quantifier(.Exists, variables: [x], scope: Quantifier(.Forall, variables: [y], scope: equiv))
        
        let qdimacsVisitor2 = QDIMACSVisitor(formula: unsat_qbf)
        guard let (unsat, _) = rareqs(qdimacs: "\(qdimacsVisitor2)") else {
            XCTFail()
            return
        }
        XCTAssertEqual(unsat, SolverResult.UNSAT, "\(unsat_qbf) === UNSAT")
    }
    
    func testAndTseitin() {
        let x = Proposition("x")
        let y = Proposition("y")
        
        let and = BinaryOperator(.And, operands:[x, y])
        
        let sat_qbf = Quantifier(.Exists, variables: [x, y], scope: and)
        
        let qdimacsVisitor = QDIMACSVisitor(formula: sat_qbf)
        guard let (sat, _) = rareqs(qdimacs: "\(qdimacsVisitor)") else {
            XCTFail()
            return
        }
        XCTAssertEqual(sat, SolverResult.SAT, "\(sat_qbf) === SAT")
        
        let unsat_qbf = Quantifier(.Exists, variables: [x], scope: Quantifier(.Forall, variables: [y], scope: and))
        
        let qdimacsVisitor2 = QDIMACSVisitor(formula: unsat_qbf)
        guard let (unsat, _) = rareqs(qdimacs: "\(qdimacsVisitor2)") else {
            XCTFail()
            return
        }
        XCTAssertEqual(unsat, SolverResult.UNSAT, "\(unsat_qbf) === UNSAT")
    }
    
    func testOrTseitin() {
        let x = Proposition("x")
        let y = Proposition("y")
        
        let or = BinaryOperator(.Or, operands:[x, y])
        
        let sat_qbf = Quantifier(.Exists, variables: [x], scope: Quantifier(.Forall, variables: [y], scope: or))
        
        let qdimacsVisitor = QDIMACSVisitor(formula: sat_qbf)
        guard let (sat, _) = rareqs(qdimacs: "\(qdimacsVisitor)") else {
            XCTFail()
            return
        }
        XCTAssertEqual(sat, SolverResult.SAT, "\(sat_qbf) === SAT")
        
        let unsat_qbf = Quantifier(.Forall, variables: [x, y], scope: or)
        
        let qdimacsVisitor2 = QDIMACSVisitor(formula: unsat_qbf)
        guard let (unsat, _) = rareqs(qdimacs: "\(qdimacsVisitor2)") else {
            XCTFail()
            return
        }
        XCTAssertEqual(unsat, SolverResult.UNSAT, "\(unsat_qbf) === UNSAT")
    }
    
    
    func testImplicationTseitin() {
        let x = Proposition("x")
        let y = Proposition("y")
        
        let implication = BinaryOperator(.Or, operands: [!x, y])
        
        let sat_qbf = Quantifier(.Exists, variables: [x], scope: Quantifier(.Forall, variables: [y], scope: implication))
        
        let qdimacsVisitor = QDIMACSVisitor(formula: sat_qbf)
        guard let (sat, _) = rareqs(qdimacs: "\(qdimacsVisitor)") else {
            XCTFail()
            return
        }
        XCTAssertEqual(sat, SolverResult.SAT, "\(sat_qbf) === SAT")
        
        let unsat_qbf = Quantifier(.Forall, variables: [x, y], scope: implication)
        
        let qdimacsVisitor2 = QDIMACSVisitor(formula: unsat_qbf)
        guard let (unsat, _) = rareqs(qdimacs: "\(qdimacsVisitor2)") else {
            XCTFail()
            return
        }
        XCTAssertEqual(unsat, SolverResult.UNSAT, "\(unsat_qbf) === UNSAT")
    }
}
