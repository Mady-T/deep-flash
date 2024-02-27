import random

def random_sequencer(deck):
    return random.choice([i for i in deck])

#Can impletment caching to improve performance
def simple_spacedrepitition(deck):
    #Weights for item_diff, mem_strength, last_display respectively
    weights=[0.5, -0.8, -1]    #Weights assigned manually. Need to optimize later
    scores=[deck[i]["item_difficulty"]*weights[0]+deck[i]["memory_strength"]*weights[1]+deck[i]["last_display"]*weights[2] for i in deck]
    maxcard = [i for i in deck][scores.index(max(scores))]   #Get card with highest score
    return maxcard