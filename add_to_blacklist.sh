input_file=$1
if [ -z "$input_file" ]; then
	echo "Input file is empty."
	exit
fi

quiet=$2
if [ $quiet = "q" ]; then
	echo "Job will complete in the background using nohup."

	#Get all URLs from file and add them to the gravity database
	while IFS= read -r domain; do
		nohup pihole -b "$domain" -nr &
		done < $input_file

else
	#Get all URLs from file and add them to the gravity database
	while IFS= read -r domain; do
        	echo "Adding $domain to blacklist..."
        	pihole -b "$domain" -nr
        	done < $input_file
fi

echo "Parsing complete for $input_file."
pihole restartdns
exit
