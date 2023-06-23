package org.example.generator.syntax

import org.jetbrains.research.libsl.type.StructuredType
import org.jetbrains.research.libsl.type.Type

class StructureGenerator(
    private val types: List<Type>
): Generator {
    override fun generateString(): String = buildString {
        for (structure in types) {
            if (structure is StructuredType) {
                val members = structure.entries
                val name: String = structure.name

                append("typedef struct")
                if (members.isNotEmpty()) {
                    appendLine(" {")
                    for (entry in members) {
                        val type = entry.value
                        val entryName = entry.key
                        val pointer = if (type.isPointer) "*" else ""
                        appendLine("\t${type.name} $pointer$entryName;")
                    }
                    appendLine("} $name;")
                } else {
                    appendLine(" $name;")
                }
            }
        }
    }
}