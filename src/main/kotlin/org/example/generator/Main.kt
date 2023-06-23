package org.example.generator

import org.jetbrains.research.libsl.LibSL
import java.io.File

fun main() {
    val libsl = LibSL("./src/main/resources/lsl")
    val library = libsl.loadFromFileName("std/ctype.lsl")
    val libraryExtractor = Extractor()
    val cLibrary = libraryExtractor.extract(library)
    val libraryString = cLibrary.generateString()

    val fileName = "./src/main/resources/translated/${library.metadata.name}.c"
    val file = File(fileName)
    if (file.exists()) {
        file.delete()
    }
    file.createNewFile()

    val writer = file.bufferedWriter()
    writer.write(libraryString)
    writer.close()

    //val actionsString = cLibrary.generateActions()
    println(libraryString)
}