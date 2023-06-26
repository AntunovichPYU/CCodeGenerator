package org.example.generator.syntax


class ActionGenerator: Generator {
    override fun generateString(): String = buildString{
        appendLine("include \"actions.h\"")
        appendLine()
        appendLine(printCompare())
        appendLine(printConcat())
        appendLine(printReplace())
        appendLine(printCopyString())
        appendLine(printStrLen())
        appendLine(printSearchStr())
    }

    fun generateHeader(): String {
        return "#ifndef ACTIONS_H\n" +
                "#define ACTIONS_H\n" +
                "\n" +
                "char COPY_STRING(char *dst, const char *src, size_t n);\n" +
                "size_t STR_LEN(const char *str)\n" +
                "char *CONCAT(char *dst, const char *src, size_t n)\n" +
                "int COMPARE(const char *s1, const char *s2, size_t n)\n" +
                "char *SEARCH_STR(const char *p, int ch)\n" +
                "void *REPLACE(void *dst, int c, size_t n)\n" +
                "\n" +
                "#endif"
    }

    private fun printCopyString(): String {
        return "char COPY_STRING(char *dst, const char *src, size_t n)\n" +
                "{\n" +
                "\tif (n != 0) {\n" +
                "\t\tchar *d = dst;\n" +
                "\t\tconst char *s = src;\n" +
                "\n" +
                "\t\tdo {\n" +
                "\t\t\tif ((*d++ = *s++) == 0) {\n" +
                "\t\t\t\t/* NUL pad the remaining n-1 bytes */\n" +
                "\t\t\t\twhile (--n != 0)\n" +
                "\t\t\t\t\t*d++ = 0;\n" +
                "\t\t\t\tbreak;\n" +
                "\t\t\t}\n" +
                "\t\t} while (--n != 0);\n" +
                "\t}\n" +
                "\treturn (dst);\n" +
                "}"

    }

    private fun printStrLen(): String {
        return "size_t STR_LEN(const char *str)\n" +
                "{\n" +
                "\tconst char *s;\n" +
                "\n" +
                "\tfor (s = str; *s; ++s)\n" +
                "\t\t;\n" +
                "\treturn (s - str);\n" +
                "}"
    }

    private fun printConcat(): String {
        return "char *CONCAT(char *dst, const char *src, size_t n)\n" +
                "{\n" +
                "\tif (n != 0) {\n" +
                "\t\tchar *d = dst;\n" +
                "\t\tconst char *s = src;\n" +
                "\n" +
                "\t\twhile (*d != 0)\n" +
                "\t\t\td++;\n" +
                "\t\tdo {\n" +
                "\t\t\tif ((*d = *s++) == 0)\n" +
                "\t\t\t\tbreak;\n" +
                "\t\t\td++;\n" +
                "\t\t} while (--n != 0);\n" +
                "\t\t*d = 0;\n" +
                "\t}\n" +
                "\treturn (dst);\n" +
                "}"
    }

    private fun printCompare(): String {
        return "int COMPARE(const char *s1, const char *s2, size_t n)\n" +
                "{\n" +
                "\n" +
                "\tif (n == 0)\n" +
                "\t\treturn (0);\n" +
                "\tdo {\n" +
                "\t\tif (*s1 != *s2++)\n" +
                "\t\t\treturn (*(unsigned char *)s1 - *(unsigned char *)--s2);\n" +
                "\t\tif (*s1++ == 0)\n" +
                "\t\t\tbreak;\n" +
                "\t} while (--n != 0);\n" +
                "\treturn (0);\n" +
                "}"
    }

    private fun printSearchStr(): String {
        return "char *SEARCH_STR(const char *p, int ch)\n" +
                "{\n" +
                "\tfor (;; ++p) {\n" +
                "\t\tif (*p == (char) ch)\n" +
                "\t\t\treturn((char *)p);\n" +
                "\t\tif (!*p)\n" +
                "\t\t\treturn((char *)NULL);\n" +
                "\t}\n" +
                "}"
    }

    private fun printReplace(): String {
        return "void *REPLACE(void *dst, int c, size_t n)\n" +
                "{\n" +
                "\tif (n != 0) {\n" +
                "\t\tunsigned char *d = dst;\n" +
                "\n" +
                "\t\tdo\n" +
                "\t\t\t*d++ = (unsigned char)c;\n" +
                "\t\twhile (--n != 0);\n" +
                "\t}\n" +
                "\treturn (dst);\n" +
                "}"
    }
}