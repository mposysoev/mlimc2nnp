using Flux
using BSON
using Printf

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
read_data = BSON.load("20-30-15-1.bson")
model = read_data[:model]

println(comment_text)

counter::Int32 = 0
index::Int32 = 1

# for i = 1:length(model)
for l_s = 1:1
    n_s = 0
    n_e = 1
    number_nurons_current, number_nurons_next = size(model[l_s].weight)
    # println(number_nurons_current)
    # println(number_nurons_next)
    for neuron in model[l_s].weight[1:60]
        # println(neuron)
        # println(counter)
        # println("$(round(neuron, digits=4))      a       $(index)     $(l_s - 1)    $(n_s)    $(l_s)    $(n_e)")

        @printf("%f                 a         %d      %d      %d      %d      %d \n", 
                abs(neuron), index,
                (l_s - 1), n_s, l_s, n_e)
        counter += 1
        index += 1
        n_e += 1
        if n_e == number_nurons_next + 1
            n_s += 1
            n_e = 1
        end
    end
    
    counter = 0
end

# println(model.weights)
# println(length(model))


end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end


