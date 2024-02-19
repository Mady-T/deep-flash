from flask import Flask, request, jsonify
from modes import random_sequencer, simple_spacedrepitition
from cachetools import TTLCache


app = Flask(__name__)
#cache = TTLCache(maxsize=10, ttl=600)

@app.route('/')
def rootfunc():
    return "<h1>Model Running</h1>"

@app.route('/nextcard', methods=['POST'])
def next_card():
    data=request.json
    id=data.get('id')
    deck=data.get('deck')
    method=data.get('mode', 'random') 
    if 'deck' not in data or 'id' not in data:
        return jsonify({"Error":"deck and id are required fields"})
    if method=='random':return jsonify({"cardid":random_sequencer(deck)})
    elif method=='simplesr':return jsonify({"cardid":simple_spacedrepitition(deck)})
    
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)


