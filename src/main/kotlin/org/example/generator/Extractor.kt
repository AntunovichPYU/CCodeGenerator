package org.example.generator

import org.example.generator.syntax.*
import org.jetbrains.research.libsl.nodes.*

class Extractor {
    fun extract(lib: Library): LibraryGenerator {
        val types = lib.semanticTypesReferences.map { it.resolveOrError() }.filter { type -> type.isTopLevelType }
        val automaton = lib.automataReferences.map { it.resolveOrError() }.first()
        val automatonVariables = automaton.internalVariables
        val functions = automaton.functions
        val procedures = automaton.procDeclList
        val includes = lib.includes

        return LibraryGenerator(
            includes,
            automatonVariables,
            types,
            procedures,
            functions
        )
    }

}