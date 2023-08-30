from flask import Blueprint, request, jsonify


api = Blueprint('api', __name__)

@api.route('/artists', methods=('GET', 'POST'))

def handle_artists():
    if request.method == 'POST':
        return 'request OK !'
    return jsonify([{'fullname' : 'Brian Adams'}])

