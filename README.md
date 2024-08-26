**tordl+littleredrooster**



About
-----


-This version of tordl FORKED from https://github.com/mindhuntr/cli-torrent-dl who forked it from https://github.com/mindhuntr/cli-torrent-dl/commits?author=X0R0X -retains the fixes mindhuntr made to Dl1337x + adds my nifty littleredrooster script. 

As of writing this, I haven't really altered tordl at all... yet.. That being said, my contribution will primarily be littleredrooster.
This is the first script I've ever put out there, so hopefully you're b'gawkin' without issues.

<p></p>
<p></p>




**TORDL**
-----

tordl provides convenient and quick way to search torrent magnet links (and run
preferred torrent client) via major torrent sites (ThePirateBay, LimeTorrents,
Zooqle, 1337x, GloTorrents, KickAssTorrents, SolidTorrents, BTDB, TGx, Nyaa by
default) through command line. 



**LITTLE RED ROOSTER BOOSTER** 
-----

Little Red Rooster Booster is a shell script that checks if a selected torrent from tordl is already avail on AllDebrid. If the torrent is already avail, littleredrooster will ask which file you'd like to play from the torrent and streams it through mpv using your AllDebrid account.

<p></p>

**NOTE:**
_YOU MUST HAVE AN API KEY FROM ALLDEBRID OR THIS WILL NOT WORK!
-The log file and your API key MUST BOTH be manually configured in the littleredrooster script, 
or else littleredrooster won't do the thing._


**HOW IT ALL WORKS**
----

1. Once you find the torrent you want with tordl, press enter to select it from within the tordl cli interface.

2. tordl will then invoke littleredrooster, which will open a terminal where littleredrooster will use the magnet link from tordl to check if that torrent is already avail to instant stream from AllDebrid right away. 

![Screenshot_20240825_180555](https://github.com/user-attachments/assets/676cbef7-b1c3-4236-a408-9632fedce318)


4. If the torrent is already avail for instant streaming right away, AllDebrid will return a list of available files from that torrent.

![Screenshot_20240825_181156](https://github.com/user-attachments/assets/c6b95aba-6403-47e8-897d-9a34e5994343)

5. The user will then enter the number for the associated file they want and littleredrooster will ask `y` or `n` to continue/ b'gawk the jawn. It is at this point, the script also deletes the magnet link from your AllDebrid account, as it is no longer needed.

![Screenshot_20240825_173745](https://github.com/user-attachments/assets/2292e719-aaaa-4c1f-b64a-1ab0b9f3b4c0)

6. If the user enters `y` then mpv will open and begin playing the content. If the user enters `n`, the user is offered to close the application or go back to the list of available files.

8. If the torrent is not already avail to instant stream through AllDebrid, littleredrooster will return angry b'gawks, peck at you, and then insult you for your life choices before closing. 

![Screenshot_20240825_181610](https://github.com/user-attachments/assets/4e9a74a5-d104-466e-854f-70914dad3455)




<p></p>
<p></p>




**FUTURE PLANS**

- More sources/ search engines to tordl so the experience is a bit more consistent. With enough sources it casts a wide enough net, where eventually it could be made so the user could check torrents for AllDebrid availability using tordl AT user search (instead of with littleredrooster after the user makes a selection).

- Offline library to save magnet links to peruse your favorites later. 

- More robust episode selection features (Next, previous, replay, select from list, etc).

- Better filtering, such as only show mp4, avi, mkv, mp3, wav etc etc etc.

<p></p>
<p></p>






Installation
------------

### Prerequisites

* Python 3.8+
* curl (littleredrooster)
* jq (littleredrooster)
* mpv (littleredrooster)

### tordl

       $ ./setup.sh

Edit `~/.config/torrentdl/config.json` to customize your preferred torrent 
client (default is littleredrooster).

<p></p>
<p></p>


### littleredrooster

1. Make sure you have mpv, jq, and curl installed. If not run `sudo apt install curl jq mpv`

2. Place the littleredrooster file in your `/usr/local/bin` folder

3. Place the `littleredrooster.log` file wherever you're going to place it.

4. Edit the tordl config:
   By default torld will execute `konsole -e littleredrooster %s`, when a file is selected.
   You MUST change `konsole` in the tordl config.json to whatever termial you use.

6. Configure the littleredrooster file:
   Put your API key in the 5 spots labeled: `YOUR_API_KEY`.
   IMPORTANT: Make sure the path to `littleredrooster.log` is
   correct on line 35 as well as lines 388, 389, and 390 of the script.



<p></p>


Docker
------

Opening magnet links in your preferred torrent client will not work, of course.

### Build

    $ docker build . -t tordl

### Run JSON RPC Server

    $ docker run -p 57000:57000 -it tordl -s



Usage
-----


### CLI

**LITTLEREDROOSTER SPECIFIC** 
<p></p>
Invoke littleredrooster manually:

`littleredrooster "magnet:?xt=urn:btih:487B57A38963B9C0BACD24tq34......."`

OR

`/path/to/littleredrooster "magnet:?xt=urn:btih:487B57A38963B9C0BACD24tq34......."`

**Filtering torrent files with littleredrooster: (line 103)**

Currently written as (shows all files within a torrent): 

`file_urls=($(echo "$file_response" | jq -r '.data.magnets.links[].link'))`

But I've been experimenting with (works... but not always): 

`file_urls=($(echo "$file_response" | jq -r '.data.magnets.links[] | select(.filename | test("^.*\\.((?! doc|docx|pdf|srt|exe|txt|rtf|csv|log|ini|cfg|jpg|png|gif|webp|bmp|svg|mp3|wav|ogg|flac|aac|html|php|js|css|sh|zip|rar|7z|tar|gz|json|yml|xml|py|java|go|php|com).)*$")) | .link'))`


Similarly, this one gets the same result, but from the opposite approach:

`file_urls=($(echo "$file_response" | jq -r '.data.magnets.links[] | select(.filename | test("^.*\\.(mp4|mkv|avi|mov|wmv|flv)(?!.+)")) | .link'))`


---



**TORDL SPECIFIC**

Run search from command line:

    $ tordl debian 8

Exclude search results containing user defined strings:

    $ tordl debian ::-8 ::-7 (...)

Show help:

    $ tordl -h

### Modes

#### API Mode

Run with `-a` or `--api`. In this mode, just print the search result in JSON
format to the standard output and exit. Consider using `-m` or 
`--fetch-missing-magnet-links` in this mode.

#### Browse Mode

* KEY_DOWN, KEY_UP, PAGE_UP, PAGE_DOWN - Navigate
* ENTER - Run torrent client
* SPACE - Open torrent info URL in browser
* ESC - exit
* / - Search
* a - Sort by source (torrent search engine) 
* s - Sort by seeds (default)
* d - Sort by leechers 
* f - Sort by size
* m - Load more search results (if possible)
* p - Search engines selection
* x - Copy magnet link to system clipboard

##### Search

* KEY_DOWN - Move to next in search history
* KEY_UP - Move to previous in search history
* ENTER - Search
* ESC - Exit search

##### Search Engine Selection

* KEY_UP, KEY_DOWN - Navigate
* ENTER, SPACE - Check / Uncheck selected search engine
* ESC - Save and exit engine selection
* BUTTON_OK - Save and exit engine selection
* BUTTON_SAVE - Persist selection in config and exit engine selection

#### I'm Feeling Lucky Mode

Directly downloads and opens torrent client with magnet link from first search
result. Run with `-d` or `--download`.

#### Test Mode

Run with `-t` or `--test-search-engines` to test if all search engines are 
functioning. Consider using `--test-all` to test all search engines, not only
those set up in config.

### RPC

#### RPC Server

Run with `-s` or `--rpc-server` to start RPC Server, see config or `-h`for
settings details. Consider using `-m` or `--fetch-missing-magnet-links` in this
mode. JSON RPC Server follow jsonrpc 2.0 standard. Currently, there is only
one RPC method `search` which expects array of one argument - the search term.

#### RPC Client

Run with `-q` or `--rpc-client`, see `-h` for setting connection details.

JSON Output Format
------------------

```
{
    "result": [
        {
            "name": "Debian 8 7 1 Jessie x64 x86 64 DVD1 ISO Uzerus",
            "links": [
                "https://kickasss.to/debian-8-7-1-jessie-x64-x86_64-dvd1-iso-uzerus-t2086014.html"
            ],
            "magnet_url": "magnet:?xt=urn:btih:40F90995A1C16A1BF454D09907F57700F3E8BD64...",
            "origins": [
                "KAT"
            ],
            "seeds": 2,
            "leeches": 0,
            "size": "3.7GB"
        },
        ...,
        ...,
        ...
}
```

Creating Custom Search Engines
-------------------------------------

See `~/.config/torrentdl/engines.py` and 
`~/.config/torrentdl/config.json#search_engines`.
