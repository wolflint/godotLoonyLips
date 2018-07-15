extends Node2D

var player_words = [] 
var template = [
		{
		"prompt" : ["name", "thing or a food", "place", "feeling"],
		"story" : "Once upon a time a brave adventurer called %s ate a %s in a %s and felt very %s.",
		},
		{
		"prompt" : ["adjective", "noun", "noun", "feeling"],
		"story" : "In a galaxy far, far away... A %s %s attacked a %s and felt %s...",
		},
		{
		"prompt" : ["name", "thing", "feeling", "action"],
		"story" : "Once upon a time an excellent magician called %s invented a %s which initially surprised all of the peasants. Then peasants were %s and decided to %s the magician.",
		}
]
var current_story

func _ready():
	randomize()
	current_story = template [randi() % template.size()]
	$Blackboard/StoryText.text = "Welcome to Loony Lips! \nWe're going to tell a story and have a great time. \nCan I have a " + current_story.prompt[player_words.size()] + ", please?"
	$Blackboard/TextBox.text = ""

func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		var new_text = $Blackboard/TextBox.get_text()
		_on_TextBox_text_entered(new_text)

func _on_TextBox_text_entered(new_text):
	player_words.append(new_text)
	#$Blackboard/StoryText.text = story % player_words
	$Blackboard/TextBox.text = ""
	print(player_words)
	check_player_word_length()

func is_story_done():
	return player_words.size() == current_story.prompt.size()

func prompt_player():
	$Blackboard/StoryText.text = ("Can I have a " + current_story.prompt[player_words.size()] + ", please?")

func check_player_word_length():
	if is_story_done():
		tell_story()
	else:
		prompt_player()


func tell_story():
	$Blackboard/StoryText.text = current_story.story % player_words
	$Blackboard/TextureButton/ButtonLabel.text = "Again!"
	end_game()

func end_game():
	$Blackboard/TextBox.queue_free()