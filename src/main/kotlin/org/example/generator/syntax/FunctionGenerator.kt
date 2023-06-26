package org.example.generator.syntax

import org.jetbrains.research.libsl.context.LslContextBase
import org.jetbrains.research.libsl.nodes.*
import org.jetbrains.research.libsl.type.TypeInferrer
import org.jetbrains.research.libsl.nodes.Function
import org.jetbrains.research.libsl.nodes.references.TypeReference
import org.jetbrains.research.libsl.type.Type

class FunctionGenerator(
    private val functions: List<Function> = mutableListOf(),
    private val subFunctions: List<ProcDecl> = mutableListOf()
): Generator {
    override fun generateString(): String = buildString {
        if (subFunctions.isNotEmpty()) {
            for (sub in subFunctions) {
                val name = sub.name
                val args = sub.args
                val returnType = sub.returnType
                val contracts = sub.contracts
                val requireList = contracts.filter { it.kind == ContractKind.REQUIRES }
                val ensuresList = contracts.filter { it.kind == ContractKind.ENSURES }
                val statementList = sub.statements
                val lslContext = sub.context

                appendLine(printSignature(name, args, returnType))
                appendLine("{")
                appendLine(formatString(printBody(returnType, requireList, ensuresList, statementList, lslContext)))
                appendLine("}")
                appendLine()
            }
        }

        if (functions.isNotEmpty()) {
            for (function in functions) {
                val name = function.name
                val args = function.args
                val returnType = function.returnType
                val contracts = function.contracts
                val requireList = contracts.filter { it.kind == ContractKind.REQUIRES }
                val ensuresList = contracts.filter { it.kind == ContractKind.ENSURES }
                val statementList = function.statements
                val lslContext = function.context

                appendLine(printSignature(name, args, returnType))
                appendLine("{")
                appendLine(formatString(printBody(returnType, requireList, ensuresList, statementList, lslContext)))
                appendLine("}")
                appendLine()
            }
        }
    }

    private fun printSignature(
        name: String,
        args: List<FunctionArgument>,
        returnType: TypeReference?
    ): String = buildString {
        val generator = VariableGenerator(args)
        if (returnType != null) {
            val pointer = if (returnType.isPointer) "*" else ""
            append("${returnType.name}$pointer ")
        }
        else append("void ")
        append(name)
        append(generator.generateString())
    }

    private fun printBody(
        returnType: TypeReference?,
        requireList: List<Contract>,
        ensuresList: List<Contract>,
        statementList: List<Statement>,
        lslContext: LslContextBase
    ): String = buildString {
        if (requireList.isNotEmpty()) appendLine(printRequirements(requireList))
        if (returnType != null) {
            val pointer = if (returnType.isPointer) "*" else ""
            appendLine("${returnType.name}$pointer result;")
        }
        if (ensuresList.isNotEmpty()) {
            for (ensure in ensuresList) {
                val oldValue = searchForOldValue(ensure.expression)
                if (oldValue != null) {
                    appendLine("${TypeInferrer(lslContext).getExpressionType(oldValue).name} old_${oldValue.value} = ${oldValue.value};")
                }
            }
        }
        if (statementList.isNotEmpty()) append(printStatements(statementList))
        if (ensuresList.isNotEmpty()) append(printEnsures(ensuresList))
        if (returnType != null) {
            appendLine()
            appendLine("return result;")
        }
    }

    private fun printRequirements(contracts: List<Contract>): String = buildString {
        for (requirement in contracts) {
            appendLine("//${requirement.dumpToString()}")
            val assert = requirement.expression.dumpToString()
            appendLine("assert($assert);")
        }
    }

    private fun printEnsures(contracts: List<Contract>): String = buildString {
        appendLine()
        for (ensure in contracts) {
            appendLine("//${ensure.dumpToString()}")
            appendLine("assert(${ExpressionPrinter.printExpressions(ensure.expression)});")
        }
    }

    private fun printStatements(statements: List<Statement>): String = buildString {
        for (statement in statements) {
            when (statement) {
                is VariableDeclaration -> {
                    val generator = VariableGenerator()
                    appendLine(generator.printVariableWithInitialValue(statement.variable))
                }
                is Assignment -> {
                    append(ExpressionPrinter.printExpressions(statement.left))
                    appendLine(" = ${ExpressionPrinter.printExpressions(statement.value)};")
                }
                is AssignmentWithCompoundOp -> {
                    val left = statement.left
                    val right = statement.value
                    val op = statement.op.string
                    append(ExpressionPrinter.printExpressions(left))
                    append(" $op ")
                    appendLine("${ExpressionPrinter.printExpressions(right)};")
                }
                is IfStatement -> {
                    appendLine(printIfStatement(statement))
                }
                is Action -> {
                    val name = statement.name
                    val args = statement.arguments
                    appendLine("${ExpressionPrinter.printFunctionCall(name, args)};")
                }
                is Proc -> {
                    val name = statement.name
                    val args = statement.arguments
                    appendLine("${ExpressionPrinter.printFunctionCall(name, args)};")
                }
                is AssignmentWithLeftUnaryOp -> {
                    appendLine("${statement.op.string}${ExpressionPrinter.printExpressions(statement.value)}")
                }
                is AssignmentWithRightUnaryOp -> {
                    appendLine("${ExpressionPrinter.printExpressions(statement.value)}${statement.op.string}")
                }
                else -> {}
            }
        }
    }

    private fun searchForOldValue(expression: Expression): OldValue? {
        var result: OldValue?
        if (expression is BinaryOpExpression) {
            result = searchForOldValue(expression.left)
            if (result == null) result = searchForOldValue(expression.right)
        } else if (expression is OldValue) {
            result = expression
        } else {
            result = null
        }
        return result
    }

    private fun printIfStatement(statement: IfStatement): String = buildString {
        val condition = statement.value
        val ifStatements = statement.ifStatements
        val elseStatements = statement.elseStatements?.statements
        appendLine("if (${ExpressionPrinter.printExpressions(condition)}) {")
        appendLine(formatString(printStatements(ifStatements)))
        append("}")
        if (elseStatements != null) {
            appendLine(" else {")
            appendLine(formatString(printStatements(elseStatements)))
            append("}")
        }
    }

}