module MinAtar

using PyCall
using RecipesBase
using Colors
# using ColorSchemes

const games = ["asterix", "breakout", "freeway", "seaquest"]

export MinAtarEnv

mutable struct MinAtarEnv
    gamename::String
    pygame::PyObject  # the pythong game
    pyact::PyObject  # the python env.step function
    pyreset::PyObject # the python env.reset function
    pystate::PyObject # the state array object referenced by the PyArray state.o
    sticky_action_prob::Float64
    difficulty_ramping::Bool
    reward::Float64
    total_reward::Float64
    done::Bool
    colors::Array{RGB{Float64},1}
    function MinAtarEnv(gamename,
                        sticky_action_prob = 0.1,
                        difficulty_ramping = true,
                        random_seed = nothing)

        minitar_env = pyimport("minatar")
        pygame = minitar_env.environment.Environment(gamename, sticky_action_prob, difficulty_ramping, random_seed)
        sns = pyimport("seaborn")
        new(gamename, pygame, pygame.act, pygame.reset,
            pygame.state, sticky_action_prob, difficulty_ramping,
            0.0, 0.0, false,
            [RGB(sns.color_palette("cubehelix", pygame.n_channels)[i]...) for i in 1:pygame.n_channels])
    end
end

act!(env::MinAtarEnv, a) = env.pyact(a)
reset!(env::MinAtarEnv) = env.pyreset()
get_state(env::MinAtarEnv) = env.pystate()
get_state_shape(env::MinAtarEnv) = env.pygame.state_shape()
num_actions(env::MinAtarEnv) = 6
gamename(env::MinAtarEnv) = env.gamename
minimal_action_state(env::MinAtarEnv) = env.pygame.minimal_action_set()

@recipe function f(env::MinAtarEnv)
    ticks := nothing
    foreground_color_border := nothing
    grid := false
    legend := false
    aspect_ratio := 1
    
    screen = fill(Colors.RGB(0.0, 0.0, 0.0), 10, 10)
    state = env.pystate()
    
    for i in 1:size(state)[end]
        screen[findall((x)->x==1.0, state[:,:, i])] .= env.colors[i]
    end
    screen
end

end # module
