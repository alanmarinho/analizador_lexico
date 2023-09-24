# Analisador lexico para linguagem de expressoes aritmeticas

# Crétitos autor original
# Andrei de Araujo Formiga, 2014-07-25

# Modificado por:
# Equipe 04: trabalho computacional 03
# Membros:
# ------------------------------------------------------------------------
# |          Nome                         |         GitHub               |
# ------------------------------------------------------------------------
# | Francisco Erineldo Xavier Filho       |     @erfilho                 |
# | Francisco Alan do Nascimento Marinho  |     @alanmarinho             |
# | Janiel de Oliveira Silva              |     @Janiel-Oliveira         |
# | Rubens Lima Duarte                    |     @                        |
# ------------------------------------------------------------------------
# Ciencia da Computacao
# IFCE - Campus Tianguá

# variaveis globais
codigo = ""
posicao = 0
tamanho = 0

# constantes para valores de operadores
SOMA = 0
SUB = 1
MULT = 2
DIV = 3

# constantes para tipo de token
TOK_NUM = 0
TOK_OP = 1
TOK_PONT = 2

# Operadores validos
operadores = "+-*/"

# constantes para valores de pontuacao (parenteses)
PARENTESE_DIREITA = 0
PARENTESE_ESQUERDA = 1


# Estrutura de um token
class Token:
    def __init__(self, tipo, valor):
        self.tipo = tipo
        self.valor = valor


# le um caractere do codigo e retorna o caractere ou -1 se o fim do codigo foi alcancado
# incrementa a variavel posicao
def le_caractere():
    global codigo, posicao, tamanho
    c = ""

    if posicao < tamanho:
        c = codigo[posicao]
        posicao += 1
    else:
        posicao += 1
    return c


# funcao que faz a analise lexica, retornando o proximo token
def proximo_token():
    global posicao
    c = le_caractere()
    valor = ""

    if posicao > tamanho:
        return None

    while c.isspace():
        c = le_caractere()

    if c.isdigit():
        while c.isdigit():
            valor += c
            c = le_caractere()
        posicao -= 1

        return Token(TOK_NUM, int(valor))
    elif c in operadores:
        return Token(TOK_OP, define_operador(c))
    elif c == "(" or c == ")":
        return Token(TOK_PONT, PARENTESE_ESQUERDA if c == "(" else PARENTESE_DIREITA)
    else:
        return None


# determina se um caractere eh um operador, e retorna o tipo se for, se nao retorna -1
def define_operador(operador):
    switch = {"+": SOMA, "-": SUB, "*": MULT, "/": DIV}

    return switch.get(operador, "NENHUM")


# retorna o nome do operador
def operador_string(operador):
    switch = {SOMA: "SOMA", SUB: "SUB", MULT: "MULT", DIV: "DIV"}

    return switch.get(operador, "NENHUM")


# inicializa a analise lexica do codigo em uma string (preeche as variaveis globais)
def inicializa_analise(entrada):
    global codigo, posicao, tamanho
    codigo = entrada
    tamanho = len(entrada)
    posicao = 0


# Inprime o token
def imprime_token(tok):
    print("Tipo: ", end="")

    if tok.tipo is TOK_NUM:
        print(f"Numero\t -- Valor: {tok.valor}")
    elif tok.tipo is TOK_OP:
        print(f"Operador\t -- Valor: {operador_string(tok.valor)}")
    elif tok.tipo is TOK_PONT:
        if tok.valor == PARENTESE_ESQUERDA:
            print(f"Pontuação\t -- Valor: PARESQ")
        else:
            print(f"Pontuação\t -- Valor: PARDIR")
    else:
        print("TIPO DE TOKEN DESCONHECIOO\n")


# executa o nalizador lexico
def analisador_lexico():
    print("Análise Lexica para Expressoes")
    entrada = input("Expressao: ")
    inicializa_analise(entrada)
    print("\n===== Analise =====")
    while True:
        tok = proximo_token()
        if tok is None:
            break
        imprime_token(tok)


if __name__ == "__main__":
    analisador_lexico()
