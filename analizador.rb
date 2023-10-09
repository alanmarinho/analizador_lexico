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

$codigo = ""
$posicao = 0
$tamanho = 0

# constantes para valores de operadores
$SOMA = 0
$SUB = 1
$MULT = 2
$DIV = 3

# constantes para tipo de token
$TOK_NUM =0
$TOK_OP = 1
$TOK_PONT = 2

# Operadores validos
$operadores = "+-*/"

# constantes para valores de pontuação (parenteses)
$PARENTESE_DIREITA = 0
$PARENTESE_ESQUERDA = 1

# Estrutura de um token
class Token
  attr_accessor :tipo, :valor

  def initialize(tipo, valor)
    @tipo = tipo
    @valor = valor
  end
end 

# le um caractere do codigo e retorna o caractere ou -1 se o fim do codigo foi alcancado
# incrementa a variavel posicao
def le_caractere()
  c = ''
  if $posicao < $tamanho
    c = $codigo[$posicao]
    $posicao += 1
  else
    $posicao += 1
  end
  return c
end

#determina se um caractere eh um operador, e retorna o tipo se for, se nao retorna -1
def define_operador(operador)
  case operador
  when "+"
    return $SOMA
  when "-"
    return $SUB
  when "*"
    return $MULT
  when "/"
    return $DIV
  else
    return "NENHUM"
  end
end

# inicializa a analise lexica do codigo em uma string (preeche as variaveis globais)
def inicializa_analise(entrada)
  $codigo = entrada
  $tamanho = $codigo.length
  $posicao = 0
end

# funcao que faz a analise lexica, retornando o proximo token
def proximo_token(tok)
  c = le_caractere()
  valor = ''

  # ignora espacos em branco
  while c == ' '
    c = le_caractere()
  end

  # retorna nil se o fim do codigo foi alcancado
  if $posicao > $tamanho
    return nil
  end
  
  # Definir o tipo para numero, e concatenar os digitos de numeros grandes
  if c.match(/\d+/)
    while c.match(/\d+/)
      valor += c
      c = le_caractere()
    end
    $posicao -= 1
    tok.tipo = $TOK_NUM
    tok.valor = valor.to_i
  # Definir o tipo para operador
  elsif $operadores.include?(c)
      tok.tipo = $TOK_OP
      tok.valor = define_operador(c)
  # Definir o tipo para pontuacao
  elsif c == '(' || c == ')'
      tok.tipo = $TOK_PONT
      if c == '('
        tok.valor = $PARENTESE_ESQUERDA
      else
        tok.valor = $PARENTESE_DIREITA
      end
  # Se nao for nenhum dos tipos validos, retorna nil
  else
    return nil
  end
  # retorna o token
  return tok
end

# retorna o nome do operador
def operador_string(operador)
  case operador
  when $SOMA
    return "SOMA"
  when $SUB
    return "SUB"
  when $MULT
    return "MULT"
  when $DIV
    return "DIV"
  else
    return "NENHUM"
  end
end

# imprime um token
def imprime_token(tok)
  print("Tipo: ");
	
  case tok.tipo
  when $TOK_NUM
    puts("Número\t-- Valor: " + tok.valor.to_s);
  when $TOK_OP
    puts("Operador\t-- Valor: " + operador_string(tok.valor));
  when $TOK_PONT
    puts("Pontuacao\t-- Valor: " + (tok.valor == $PARENTESE_ESQUERDA ? "PARESQ" : "PARDIR"));
  else
    puts("Desconhecido\t -- Valor: " + tok.valor);
  end
end

def main()
  puts ("Análise Léxica para Expressões")
  puts ("Expressão: ")
  entrada = gets.chomp
  tok = Token.new(nil, nil)
  
  inicializa_analise(entrada)

  puts("\n===== Análise =====\n")
  while proximo_token(tok) != nil 
    imprime_token(tok)
  end
end

main()

# exemplo: (12 + (34 - (56 * 78))) / 2