#Script to simulate a learning process

from collections import Counter
import random
import app
import time
import json
import os

path=os.path.dirname(os.path.abspath(__file__))
deck=json.load(open(os.path.join(path, 'deck.json'), 'r'))

sequencen=50

def main():
    i=0
    sequence=[]
    while(i<sequencen):
        card=app.simple_spacedrepitition(deck)
        deck[card]["last_display"]=time.time()
        deck[card]["memory_strength"]=deck[card]["memory_strength"]-1 if deck[card]["memory_strength"]> 1 else 1
        sequence.append(card)
        i+=1
        print(card)
        time.sleep(0.5)
    print(f"Deck : {deck}")
    print(f"Sequence : {sequence}")
    print("Counter : ", {id: Counter(sequence).get(id, 0) for id in [i for i in deck]})

if __name__ == '__main__':
    main()
