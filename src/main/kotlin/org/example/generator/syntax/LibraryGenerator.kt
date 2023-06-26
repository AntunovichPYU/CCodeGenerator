package org.example.generator.syntax

import org.jetbrains.research.libsl.nodes.Variable
import org.jetbrains.research.libsl.type.Type
import org.jetbrains.research.libsl.nodes.Function
import org.jetbrains.research.libsl.nodes.ProcDecl

class LibraryGenerator(
    private val includes: List<String> = mutableListOf(),
    private val globalVariables: List<Variable> = mutableListOf(),
    private val structures: List<Type> = mutableListOf(),
    private val procedures: List<ProcDecl> = mutableListOf(),
    private val functions: List<Function> = mutableListOf()
): Generator {
    override fun generateString(): String = buildString {
        if (includes.isNotEmpty()) {
            appendLine(includes.joinToString("\n") { "#include $it"})
            appendLine()
        }

        if (structures.isNotEmpty()) {
            val generator = StructureGenerator(structures)
            appendLine(generator.generateString())
        }

        if (globalVariables.isNotEmpty()) {
            val generator = VariableGenerator(globalVariables)
            appendLine(generator.generateString())
        }

        if (functions.isNotEmpty()) {
            val generator = FunctionGenerator(functions, procedures)
            appendLine(generator.generateString())
        }
    }

    fun generateActions(): String {
        return ActionGenerator().generateString()
    }

    fun generateActionsHeader(): String {
        return ActionGenerator().generateHeader()
    }
}