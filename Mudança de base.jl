"""
    valor(σ, mantissa, b, E)
Calcula o valor de um número em forma de ponto flutuante
    σ × 0.(a₁a₂…aₖ) × bᴱ,
onde
- `σ` é o sinal do número, e deve ser `-1` ou `1`;
- `b` é a base e deve ser um inteiro tal que 2 ≤ b ≤ 16;
- `E` é o expoente e deve ser inteiro -10 ≤ E ≤ 10;
- `mantissa` é o vetor com elementos inteiros `aᵢ` tal que 0 ≤ aᵢ ≤ b - 1.
Lembre-se que a definição desse número é
    x = σ × bᴱ × ∑ᵢ aᵢ × b⁻ⁱ
Exemplos:
- `valor(1, [1, 1], 2, 3)` corresponde a `(0.11)₂ × 2³ = (0.5 + 0.25) × 8 = 6.0`.
"""
function valor(σ::Int, mantissa::Vector{Int}, b::Int, E::Int)
    x = 0.0
    if (σ < -1)
        error("σ deve ser -1 ou 1")
    elseif σ == 0
        error("σ deve ser -1 ou 1")
    elseif σ > 1
        error("σ deve ser -1 ou 1")
    end
    i=1
    if mantissa == [] 
        error("mantissa não pode ficar vazia")
    end
    reverse(mantissa)
    for i in 2:length(mantissa)
        if mantissa[i] > b - 1
            mantissa[i - 1] += 1
            mantissa[i] -= b
        end
    end
    
    if getindex(mantissa[1]) > b-1
        x += 1
        mantissa[1] -= b
    end
    
    
    if b < 2
        error("b deve ser ≥ 2 e ≤ 16")
    elseif b > 16
        error("b deve ser ≥ 2 e ≤ 16")
    end
    if E < -10
        error("E deve ser ≥ -10 e ≤ 10")
    elseif E > 10
        error("E deve ser ≥ -10 e ≤ 10")
    end
    casas=0.0
    for i = 1:length(mantissa)
        
        casas += float((mantissa[i])*(b^float(-i)))
    end
    
    x +=  σ* b ^ float(E) * casas

    return x
end
"""
    σ, mantissa, b, E = converte(x, b)
Converte o número `x` para a forma de ponto flutuante na base `b`.
- `x` deve ser inteiro entre -50000 e 50000;
- `b` deve ser inteiro entre 2 e 16.
Exemplos:
- `converte(6, 2)` deve retornar `1, [1, 1], 2, 3`.
"""
function converte(x::Int, b::Int)
    if b < 2
        error("b deve ser ≥ 2 e ≤ 16")
    elseif b > 16
        error("b deve ser ≥ 2 e ≤ 16")
    end
    if x < -50000
            error("x deve ser ≥ -50000 e ≤ 50000")
    elseif x > 50000
            error("x deve ser ≥ -50000 e ≤ 50000")
    end
    a= 0.0
    c=0
    L = []
    if x >= 0
        σ = 1
    else
        σ = -1
        x = -x
    end
    while x >= b
        if x >= 0
            c = x % b
        else
            c = x%b
        end
        x = div(x,b)
        L = [c; L]
    
    end
    if x < b
        L = Int[x; L]
    end
    E = length(L)
    return (σ, L, b, E)
    
end