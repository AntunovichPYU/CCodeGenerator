package org.example.generator.syntax

interface Generator {
    fun generateString(): String

    fun formatString(arg: String): String {
        return arg.lines().dropLast(1).joinToString(separator = "\n") { s -> "\t$s" }
    }
}