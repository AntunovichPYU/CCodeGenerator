package org.example.generator.syntax

import org.jetbrains.research.libsl.nodes.FunctionArgument
import org.jetbrains.research.libsl.nodes.Variable
import org.jetbrains.research.libsl.nodes.VariableWithInitialValue

class VariableGenerator(
    private val variables: List<Variable> = mutableListOf()
): Generator {

    override fun generateString(): String = buildString {
        if (variables.isNotEmpty()) {
            when (variables.firstOrNull()) {
                is FunctionArgument -> {
                    append(
                        variables.joinToString(prefix = "(", postfix = ")") {
                            printFunctionArgument(it as FunctionArgument)
                        }
                    )
                }
                is VariableWithInitialValue -> {
                    appendLine(
                        variables.joinToString("\n") {
                            printVariableWithInitialValue(it as VariableWithInitialValue)
                        }
                    )
                }
            }
        }
    }

    private fun printFunctionArgument(variable: FunctionArgument): String = buildString {
        val keywords = variable.annotationUsages
        val type = variable.typeReference
        val pointer = if (type.isPointer) {
            if (keywords.map { it.annotationReference.name }.contains("restrict"))
                "* restrict"
            else
                "*"
        } else {
            ""
        }
        val name = variable.name
        for (keyword in keywords)
            if (keyword.annotationReference.name != "restrict")
                append("${keyword.annotationReference.name} ")
        append("${type.name}$pointer $name")
    }

    fun printVariableWithInitialValue(variable: VariableWithInitialValue): String = buildString {
        val keywords = variable.annotationUsage.map { n -> n.annotationReference.name}
        val constKeyword = if (variable.keyword.name == "VAL") "const " else ""
        val type = variable.typeReference
        val name = variable.name
        val initialValue = variable.initialValue

        if (keywords.isNotEmpty())
            for (keyword in keywords)
                append("$keyword ")
        append(constKeyword)
        append("${type.name} ")
        if (type.isPointer)
            append("*")
        append(name)
        if (initialValue != null) {
            append(" = ${ExpressionPrinter.printExpressions(initialValue)};")
        } else {
            append(";")
        }
    }
}