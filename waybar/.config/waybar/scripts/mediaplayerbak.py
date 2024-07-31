import subprocess
import json

def get_playback_info():
  """
  Retrieves the current playback information from spotify-player.
  """
  # Replace 'spotify-player' with the actual command for your music player
  command = ["spotify_player", "get", "key", "playback"]
  output = subprocess.run(command, capture_output=True, text=True)
  if output.returncode == 0:
    return json.loads(output.stdout)
  else:
    print("Error: Failed to retrieve playback information.")
    return None 

def extract_artist_and_title(playback_info):
  """
  Extracts the artist and song title from the playback information.
  """
  if playback_info is None:
    return None, None

  item = playback_info.get("item")
  if item is None:
    return None, None

  artists = item.get("artists")
  # Handle multiple artists by joining their names into a string
  artist_name = ", ".join([artist["name"] for artist in artists])

  track = item.get("name")
  return artist_name, track

if __name__ == "__main__":
  playback_info = get_playback_info()
  artist_name, song_title = extract_artist_and_title(playback_info)

  if artist_name and song_title:
    print(f"Artist: {artist_name}")
    print(f"Song: {song_title}")
  else:
    print("No information available.")
