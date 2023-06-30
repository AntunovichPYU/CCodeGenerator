package org.example.generator

import org.jetbrains.research.libsl.LibSL
import java.io.File

fun main() {
    val libsl = LibSL("./src/main/resources/lsl")
    val library = libsl.loadFromFileName("std/stdlib.lsl")
    val libraryExtractor = Extractor()
    val cLibrary = libraryExtractor.extract(library)
    val libraryString = cLibrary.generateString()
    val actionsHeader = cLibrary.generateActionsHeader()
    val actionsModule = cLibrary.generateActions()

    val actionsFile = File("./src/main/resources/translated/actions.c")
    val actionsHeaderFile = File("./src/main/resources/translated/actions.h")

    val fileName = "./src/main/resources/translated/${library.metadata.name}.c"
    val file = File(fileName)

    if (file.exists()) {
        file.delete()
    }
    if (actionsFile.exists() || actionsHeaderFile.exists()) {
        actionsFile.delete()
        actionsHeaderFile.delete()
    }
    file.createNewFile()
    actionsFile.createNewFile()
    actionsHeaderFile.createNewFile()

    val writer = file.bufferedWriter()
    val actionsWriter = actionsFile.bufferedWriter()
    val actionsHeaderWriter = actionsHeaderFile.bufferedWriter()

    actionsWriter.write(actionsModule)
    actionsHeaderWriter.write(actionsHeader)
    writer.write(libraryString)

    writer.close()
    actionsWriter.close()
    actionsHeaderWriter.close()

    //val actionsString = cLibrary.generateActions()
    println(libraryString)
}