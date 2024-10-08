#!/bin/bash
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
# Log file and output
exec &> >(tee /tmp/littleredrooster.log)

# Retrieve the magnet link
magnet_link="$1"

# Log the received magnet link
echo "Received magnet link:
$magnet_link
"




# API check for AllDebrid instant avail
instant_response=$(curl -s -G --data-urlencode "magnets[]=$magnet_link" "https://api.alldebrid.com/v4/magnet/instant?agent=myAppName&apikey=YOUR_API_KEY" 2>&1)

# API response for instant avail check
echo "Alldebrid API response for instant availability check:
$instant_response
"
# Instant avail truse/ false
instant_bawk=$(echo $instant_response | jq -r '.data.magnets[0].instant')


# Log the Instant avail status
echo "AllDebrid:
$instant_bawk
"


littleredroosterbooster(){
# If jawn is available
if $(echo "$instant_response" | jq -r '.data.magnets[0].instant') = "true"; then





# Use curl to upload the magnet link to Alldebrid
upload_response=$(curl -s -X POST -F "magnets[]=$magnet_link" "https://api.alldebrid.com/v4/magnet/upload?agent=script_uploader&apikey=YOUR_API_KEY" 2>&1)

# API response for the magnet link upload
echo "Alldebrid API response for magnet link upload:
$upload_response
"

# Extract the download ID from magnet link upload
download_id=$(echo $upload_response | jq -r '.data.magnets[0].id')

# Log the extracted download ID
echo "Extracted ID:
$download_id
"



# Use the download ID to fetch the file info json
file_response=$(curl -s -G --data-urlencode "id=$download_id" "https://api.alldebrid.com/v4/magnet/status?agent=myAppName&apikey=YOUR_API_KEY" 2>&1)

# API response for the file json
echo "Alldebrid API response for file URL:"
echo "$file_response"

# Eventually I'll make it so user can filter out non video jawns from the json.
# But for now, eat your content and like it you fuckin' cleptomaniac.



file_urls=($(echo "$file_response" | jq -r '.data.magnets.links[].link'))



# parse file names for jawn selection
join_file_name() {
    local file_name=$1
    # Store each line of the file name into an array
    local file_name_array=($(echo "$file_name" | tr '\n' ' '))
    # Join array elements to form the final file name
    local joined_file_name="$(printf "%s " "${file_name_array[@]}")"
    echo "$joined_file_name"
}


clear


echo -e "
\e[31m
⠀⠀              ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣤⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⡦⣤⣤⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀              ⠀⠀⠀⠀⣀⡤⣴⣶⠞⠋⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠈⠉⠉⠙⠻⢿⣿⣗⡢⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀
              ⠀⠀⠀⣠⢊⣵⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⢭⣳⣮⣳⣄⠀⠀⠀⠀⠀⠀⠀
⠀              ⠀⣼⣿⠏⠀        ⠀'Hey, you. ⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣮⡙⢷⡄⠀⠀⠀⠀⠀
⠀              ⣼⡿⠁⠀⠀ ⠀    You're finally awake.⠀⠀⠀⠈⠻⣟⢦⠙⢦⡀⠀⠀⠀
              ⠀⣿     You were trying to             ⠈⢯⡳⣄⢻⢦⠀⠀
              ⢸⡟        cross the border,right?⠀      ⠹⣾⣾⡄⢳⠀
              ⢸⡇⠀⠀  ⠀⠀    ⠀⠀Walked right into that⠀⠀ ⠀⠀⢻⣻⡇⠀⡇
              ⢸⣿⡄                  Imperial ambush   ⠀⠀⠀⣿⡗⠀⣿
              ⠀⢧⠹⡄         -same as us, and that      ⠀⢀⣾⡇⠀⡏
⠀              ⠈⢢⣘⢢⡀         ⠀ thief over there.'    ⢠⣾⡟⠀⡼⠁
              ⠀⠀⠀⠙⠷⡻⠶⣄⡀⠀                            ⣰⣿⢟⡤⠞⠁⠀
⠀              ⠀⠀⠀⠀⠈⠒⠤⣉⣛⢷⣒⠦⠤⠤⠤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣾⡯⠕⠋⠀⠀⠀⠀
               ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠛⠛⠛⠛⣿⡿⢀⣴⣶⣶⣶⣶⣶⣶⣚⣛⣿⣿⠿⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⢠⣾⣽⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀        ⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠃⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⣤⣴⣿⣧⣴⡆⠀⠀
        ⠀⠀⠀⠀⠠⣤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⢿⠟⢋⣡⢌⠉⠉⠀⠀⠀
            ⠀⠀⠀⠙⢿⣿⣷⣦⢰⣧⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣷⠺⠿⢷⡀⠀⠀
        ⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⢸⣿⣇⠐⣶⡀⠀⠀⠀
        ⠀⠀⠁⣠⠶⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⢀⣼⣿⣿⣦⣈⡁⠀⠀⠀
        ⠀⠀⠀⠀⢠⣾⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⠀⡾⠿⢿⣿⢿⣿⣿⣷⠀⠀⠀
    ⠀    ⠀⠀⠀⠘⠁⣴⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢀⣤⡄⠘⢁⠘⠏⣁⠛⠀⠀⠀
           ⠀⠀⠀⠀⠀⠀⡿⠁⢾⡟⠉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣷⣴⣿⡄⣴⣿⠀⠀⠀⠀
    ⠀          ⠀⠀⠀⠀⠀⠘⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀
    ⠀               ⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⡿⠟⠋⠁⠀⠀⠀⠀⠀⠀
             ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠿⠿⠿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⣠⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⢉⣿⣿⡏⣿⡶⣤⣄⠀

\e[0m"



# List header
list="\033[1m\033[4mExtracted jawn(s):\033[0m"
terminal_width=$(tput cols)
jawn_text="Extracted jawn(s):"
text_length=${#jawn_text}
padding=$(( (terminal_width - text_length) / 2 ))
printf "%*s" $padding ""
echo -e "$list"


# Line Break
echo "
"

# List of jawns
index=1
for ((i = 0; i < ${#file_urls[@]}; i++)); do
    file_name=$(echo "$file_response" | jq -r ".data.magnets.links[$i].filename")
    joined_file_name=$(join_file_name "$file_name")
    echo -e "    \033[1m\033[5m$index\033[0m. $joined_file_name"
    echo
    ((index++))
done


# Prompt the user to select a jawn by index - for some reason had to define text forrmatting here.
BOLD='\033[1m'
NORMAL='\033[0m'
echo -e "${BOLD}Select yer jawn farmer:${NORMAL}"
read -p " " selected_index
selected_url="${file_urls[$(($selected_index - 1))]}"




# Use the selected jawn URL to fetch the streaming URL
streaming_response=$(curl -G --data-urlencode "link=$selected_url" "https://api.alldebrid.com/v4/link/unlock?agent=myAppName&apikey=YOUR_API_KEY" 2>&1)

# API response for the streaming URL
echo "
AllDebrid API response for streaming URL:"
echo "$streaming_response

"
# Extract the streaming url from the jawn url
streaming_url=$(echo "$streaming_response" | grep -Pzo "(?s)\{.*" | jq -r '.data.link')

# Log the extracted streaming URL
echo "Extracted streaming URL:
$streaming_url

"


# Delete the content from AllDebrid library - this is for reasons
delete_jawn=$(curl -G --data-urlencode "id=$download_id" "https://api.alldebrid.com/v4/magnet/delete?agent=myAppName&apikey=YOUR_API_KEY" 2>&1)

# I'm killin' you too, Jim. Fuck it.
echo "
Magent deleted:
$delete_jawn"

clear


echo -e "



\e[31m
        ⠀⠀⠀⠀    ⠀⠀⠀     ⠀⠀⠀⢀⣠⣤⣤⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⡦⣤⣤⣀⣀⣀⣀
⠀⠀            ⠀⠀     ⠀⣀⡤⣴⣶⠞⠋⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠈⠉⠉⠙⠻⢿⣿⣗⡢⢤⣀
⠀⠀⠀                 ⣠⢊⣵⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⢭⣳⣮⣳⣄
    ⠀            ⠀⣼⣿⠏⠀ ⠀⠀                          ⠙⢿⣮⡙⢷⡄
        ⠀        ⣼⡿⠁⠀ ⠀⠀'It's like I told ya-      ⠀ ⠈⠻⣟⢦⠙⢦⡀
                ⠀⣿                  what I said...     ⠈⢯⡳⣄⢻⢦
                ⢸⡟       Steal your face                 ⠹⣾⣾⡄⢳
                ⢸⡇⠀        right off'uh your head-'       ⢻⣻⡇⠀⡇
                ⢸⣿⡄                                      ⠀⣿⡗⠀⣿
                ⠀⢧⠹⡄                                   ⠀⢀⣾⡇⠀⡏
                ⠀⠈⢢⣘⢢⡀         ⠀                       ⢠⣾⡟⠀⡼⠁
                ⠀⠀⠀⠙⠷⡻⠶⣄⡀⠀                            ⣰⣿⢟⡤⠞⠁
        ⠀        ⠀⠀⠀⠀⠈⠒⠤⣉⣛⢷⣒⠦⠤⠤⠤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣾⡯⠕⠋
        ⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠛⠛⠛⠛⣿⡿⢀⣴⣶⣶⣶⣶⣶⣶⣚⣛⣿⣿⠿⠛⠋⠁
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⢠⣾⣽⡿⠛⠁
⠀    ⠀⠀⠀    ⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠿⠋
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠃

    ⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⣤⣴⣿⣧⣴⡆
        ⠀⠀⠀⠀⠠⣤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⢿⠟⢋⣡⢌⠉⠉⠀
            ⠀⠀⠀⠙⢿⣿⣷⣦⢰⣧⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣷⠺⠿⢷⡀
        ⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⢸⣿⣇⠐⣶⡀
        ⠀⠀⠁⣠⠶⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⢀⣼⣿⣿⣦⣈⡁⠀
        ⠀⠀⠀⠀⢠⣾⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⠀⡾⠿⢿⣿⢿⣿⣿⣷
    ⠀    ⠀⠀⠀⠘⠁⣴⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢀⣤⡄⠘⢁⠘⠏⣁⠛
           ⠀⠀⠀⠀⠀⠀⡿⠁⢾⡟⠉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣷⣴⣿⡄⣴⣿
    ⠀         ⠀⠀⠀⠀⠀⠘⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁
    ⠀              ⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⡿⠟⠋⠁
             ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠿⠿⠿⠁
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⣠⣆
            ⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⢉⣿⣿⡏⣿⡶⣤⣄

\e[0m"





echo -e "
    Welcome to the Little Red Rooster Booster!
    Would ya like to b'gawk this jawn now?

    \033[1m\033[5m*peck*\033[0m (y/n) \033[1m\033[5m*peck*\033[0m"
read user_bawk


    if [[ $user_bawk = "y" ]]; then

        # Stream the jawn using mpv
        echo "


        All the pretty 'lil hens know my name!:

        $streaming_url

        "

        # remove --really-quiet for verbose mpv output
        mpv -really-quiet "$streaming_url" 2>&1
        mpv_status=$?

        # Log mpv status)
        echo "






        She layin' them eggs:

        $mpv_status

        "



    else

        clear
        # Fuckin' hippies

        echo "







                  God damn hippies...




        " && sleep 1

    fi

else
    clear

    # this means your magnet link is junk, pick a new one
    echo -e "

    \033[1m*buh'\033[0m\033[1m\033[3mGAAWWWWKKK*\033[0m
    \033[1m*buh'\033[0m\033[1m\033[3mGAAWWWWKKK*\033[0m
    \033[1m*buh'\033[0m\033[1m\033[3mGAAWWWWKKK*\033[0m
    \033[1m*buh'\033[0m\033[1m\033[3mGAAWWWWKKK*\033[0m
    \033[1m*buh'\033[0m\033[1m\033[3mGAAWWWWKKK*\033[0m
    \033[1m*buh'\033[0m\033[1m\033[3mGAAWWWWKKK*\033[0m
    \033[1m*buh'\033[0m\033[1m\033[3mGAAWWWWKKK*\033[0m
    \033[1m*buh'\033[0m\033[1m\033[3mGAAWWWWKKK*\033[0m
    \033[1m*buh'\033[0m\033[1m\033[3mGAAWWWWKKK*\033[0m

    \033[1m\033[5m*peck*\033[0m
           \033[1m\033[5m*peck*\033[0m
                               \033[1m\033[5m*peck*\033[0m
              \033[1m\033[5m*peck*\033[0m      \033[1m\033[5m*peck*\033[0m
\033[1m\033[5m*peck*\033[0m
               \033[1m\033[5m*peck*\033[0m
                                           \033[1m\033[5m*peck*\033[0m
                           \033[1m\033[5m*peck*\033[0m
                                                      \033[1m\033[5m*peck*\033[0m
                 \033[1m\033[5m*peck*\033[0m
     \033[1m\033[5m*peck*\033[0m
                                                  \033[1m\033[5m*peck*\033[0m
                 \033[1m\033[5m*peck*\033[0m


    Don't you EVER suggest this magnet link again you little pop-tart.
    I can't even \033[3mlook\033[0m at you...... \033[1m*BAWK*\033[0m" && sleep 3

fi


    clear

    echo -e "








    Keep b'gawkin'?
    \033[1m\033[5m*peck*\033[0m (y/n) \033[1m\033[5m*peck*\033[0m
    "
    # Are ya winnin' son?
    read jawn_continue

    if [[ $jawn_continue = "y" ]]; then

        clear
        # boop the bawk
        rm /tmp/littleredrooster.log
        touch /tmp/littleredrooster.log
        exec &> >(tee /tmp/littleredrooster.log)


        # But it's the pelvic thrust that really drives you insane...
        littleredroosterbooster

    else

        clear
        echo -e "

        \e[31m
        ⠀⠀⠀⠀    ⠀⠀⠀     ⠀⠀⠀⢀⣠⣤⣤⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⡦⣤⣤⣀⣀⣀⣀
⠀⠀            ⠀⠀     ⠀⣀⡤⣴⣶⠞⠋⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠈⠉⠉⠙⠻⢿⣿⣗⡢⢤⣀
⠀⠀⠀                 ⣠⢊⣵⠞⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⢭⣳⣮⣳⣄
    ⠀            ⠀⣼⣿⠏⠀ ⠀⠀                          ⠙⢿⣮⡙⢷⡄
        ⠀        ⣼⡿⠁⠀ ⠀⠀    'Don't talk to me,       ⠈⠻⣟⢦⠙⢦⡀
                ⠀⣿               or my son-            ⠈⢯⡳⣄⢻⢦
                ⢸⡟                  ever again           ⠹⣾⣾⡄⢳
                ⢸⡇⠀                                       ⢻⣻⡇⠀⡇
                ⢸⣿⡄              -Go'awn GIT!'           ⠀⣿⡗⠀⣿
                ⠀⢧⠹⡄                                   ⠀⢀⣾⡇⠀⡏
                ⠀⠈⢢⣘⢢⡀         ⠀                       ⢠⣾⡟⠀⡼⠁
                ⠀⠀⠀⠙⠷⡻⠶⣄⡀⠀                            ⣰⣿⢟⡤⠞⠁
        ⠀        ⠀⠀⠀⠀⠈⠒⠤⣉⣛⢷⣒⠦⠤⠤⠤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣾⡯⠕⠋
        ⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠛⠛⠛⠛⣿⡿⢀⣴⣶⣶⣶⣶⣶⣶⣚⣛⣿⣿⠿⠛⠋⠁
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⢠⣾⣽⡿⠛⠁
⠀    ⠀⠀⠀    ⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠿⠋
                ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠃

    ⠀⠀⠀⠀    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⣤⣴⣿⣧⣴⡆
        ⠀⠀⠀⠀⠠⣤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⢿⠟⢋⣡⢌⠉⠉⠀
            ⠀⠀⠀⠙⢿⣿⣷⣦⢰⣧⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣷⠺⠿⢷⡀
        ⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⢸⣿⣇⠐⣶⡀
        ⠀⠀⠁⣠⠶⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⢀⣼⣿⣿⣦⣈⡁⠀
        ⠀⠀⠀⠀⢠⣾⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⠀⡾⠿⢿⣿⢿⣿⣿⣷
    ⠀    ⠀⠀⠀⠘⠁⣴⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢀⣤⡄⠘⢁⠘⠏⣁⠛
           ⠀⠀⠀⠀⠀⠀⡿⠁⢾⡟⠉⠻⣿⣿⣿⣿⣿⣿⣿⣿⣷⣴⣿⡄⣴⣿
    ⠀         ⠀⠀⠀⠀⠀⠘⠀⠀⠀⠙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁
    ⠀              ⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⣿⡿⠟⠋⠁
             ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠿⠿⠿⠁
            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⣠⣆
            ⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⢉⣿⣿⡏⣿⡶⣤⣄
        \e[0m

        "
        sleep 3
        return
    fi


}

# LETS DO THE TIME WARP AGAAAAAAIIIINNN
littleredroosterbooster
