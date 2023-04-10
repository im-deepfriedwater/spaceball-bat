extends RichTextLabel

func set_strikes(number_of_strikes: int):
	var strike_marks := ""
	for i in number_of_strikes:
		strike_marks += "X"
	text = "Strikes: %s" % strike_marks

