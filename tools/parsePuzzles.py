"""
Python code to parse lichess_db_puzzle.csv and output puzzles.dart file to use 
in random puzzle section in our app (https://database.lichess.org/#puzzles)
"""

csv = open("lichess_db_puzzle.csv","r")
dart_file = open("puzzles.dart","a")
games = []
numberOfGames = 1000
for line in csv:
    sa = line.split(",")

    games.append(sa[1]+","+sa[2])
    
    if len(games) == numberOfGames:
        dart_file.write(f"var puzzles = {str(games)};")
        break