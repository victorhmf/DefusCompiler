void warning_message(int warning_id){
	const char *warning_message[4] = {};
	warning_message[0] = "";
	warning_message[1] = "Wrong identent. Tab missing.";
	warning_message[2] = "Space missing.";
	warning_message[3] = "Comment missing.";

	printf("W0%i: %s\n", warning_id, warning_message[warning_id]);
}