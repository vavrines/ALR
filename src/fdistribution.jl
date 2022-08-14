using SpecialFunctions: beta

function f_distribution(x, d1, d2)
    nume = sqrt((d1 * x)^d1 * d2^d2 / (d1 * x + d2)^(d1 + d2)) / x * beta(d1 / 2, d2 / 2)
    deno = x * beta(d1 / 2, d2 / 2)

    return nume / deno
end
