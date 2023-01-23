using Flux
using BSON

const comment_text::String = "################################################################################
# Neural network connection values (weights and biases).
################################################################################
# Col  Name       Description
################################################################################
# 1    connection Neural network connection value.
# 2    t          Connection type (a = weight, b = bias).
# 3    index      Index enumerating weights.
# 4    l_s        Starting point layer (end point layer for biases).
# 5    n_s        Starting point neuron in starting layer (end point neuron for biases).
# 6    l_e        End point layer.
# 7    n_e        End point neuron in end layer.
################################################################################
#                      1 2         3     4     5     6     7
#             connection t     index   l_s   n_s   l_e   n_e
############################################################"

function main()
    read_data = BSON.load("3-4-5-1.bson")
    model = read_data[:model]
    open("output.txt", "w") do f
        println(f, comment_text)
        index::Int32 = 1
        for l_s = 1:length(model)
            n_s = 1
            n_e = 1
            number_nurons_next, number_nurons_current = size(model[l_s].weight)
            for neuron in model[l_s].weight
                println(
                    f,
                    "$(neuron)      a       $(index)     $(l_s - 1)    $(n_s)    $(l_s)    $(n_e)",
                )
                index += 1
                n_e += 1
                if n_e == number_nurons_next + 1
                    n_s += 1
                    n_e = 1
                end
            end
        end
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
