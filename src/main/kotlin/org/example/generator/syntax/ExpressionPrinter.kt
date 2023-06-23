package org.example.generator.syntax

import org.jetbrains.research.libsl.nodes.*
import org.jetbrains.research.libsl.type.TypeInferrer

object ExpressionPrinter {
    enum class Spaces(val string: String) {
        SPACE("\\t"),
        FORM("\\f"),
        LINE("\\n"),
        CARRIAGE("\\r"),
        TAB("\\t"),
        VERTICAL_TAB("\\v")
    }

    fun printExpressions(expression: Expression, priority: Int = Int.MAX_VALUE): String = buildString {
        when (expression) {
            is BinaryOpExpression -> append(printBinaryOpExpression(expression, priority))
            is ActionExpression -> append(printActionExpression(expression))
            is ProcExpression -> append(printProcExpression(expression))
            is VariableAccess -> append(printVariableAccess(expression))
            is StringLiteral -> append(printStringLiteral(expression))
            is LeftUnaryOpExpression -> append(printLeftUnaryOPExpression(expression))
            is OldValue -> append(printOldValue(expression))
            is RightUnaryOpExpression -> append(printRightUnaryOPExpression(expression))
            is VariableWithInitialValue -> append(printVariableWithInitialValue(expression))
            else -> append(expression.dumpToString())
        }
    }

    private fun printBinaryOpExpression(expression: BinaryOpExpression, priority: Int): String = buildString {
        var leftBracket = ""
        var rightBracket = ""
        val currentPriority = expression.op.priority
        if(currentPriority > priority) {
            leftBracket = "("
            rightBracket = ")"
        }
        append("$leftBracket${printExpressions(expression.left, currentPriority)}")
        append(" ${expression.op.string} ")
        append("${printExpressions(expression.right, currentPriority)}$rightBracket")
    }

    private fun printActionExpression(expression: ActionExpression): String = buildString {
        return printFunctionCall(expression.action.name, expression.action.arguments)
    }

    private fun printProcExpression(expression: ProcExpression): String {
        return printFunctionCall(expression.proc.name, expression.proc.arguments)
    }

    private fun printVariableAccess(expression: VariableAccess): String = buildString {
        val childAccess = expression.childAccess
        val context = expression.variable.context
        val isPointer = TypeInferrer(context).getExpressionType(expression).isPointer
        if (childAccess != null && childAccess !is ArrayAccess) {
            if (isPointer)
                append("${expression.fieldName}->${printExpressions(childAccess)}")
            else
                append(expression.dumpToString())
        } else {
            append(expression.dumpToString())
        }
    }

    private fun printStringLiteral(expression: StringLiteral): String {
        val value = expression.value
        return if (value.length == 1 || Spaces.values().map { it.string }.contains(expression.value))
            "'${value}'"
        else
            "\"$value\""
    }

    private fun printLeftUnaryOPExpression(expression: LeftUnaryOpExpression): String {
        return "${expression.op.string}${printExpressions(expression.value)}"
    }

    private fun printRightUnaryOPExpression(expression: RightUnaryOpExpression): String {
        return "${printExpressions(expression.value)}${expression.op.string}"
    }

    private fun printOldValue(expression: OldValue): String {
        return "old_${printExpressions(expression.value)}"
    }

    private fun printVariableWithInitialValue(expression: VariableWithInitialValue): String {
        val generator = VariableGenerator()
        return generator.printVariableWithInitialValue(expression)
    }



    fun printFunctionCall(name: String, args: List<Expression>?): String {
        return "${name}(${args?.joinToString { printExpressions(it) }})"
    }
}