**tordl+littleredrooster**


About
-----

FORKED from https://github.com/mindhuntr/cli-torrent-dl who forked it from https://github.com/mindhuntr/cli-torrent-dl/commits?author=X0R0X 
-This version retains the fixes mindhuntr made to Dl1337x and adds my littleredrooster script. You can use both tordl and littleredrooster as standalone command line interactions.

This is a hobby, I've enjoyed tordl for a while now and am using it and littleredrooster as platforms to learn and sharpen my beak.
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

Little Red Rooster Booster is extremenly simple. All it does is check if a selected torrent from tordl is already avail on AllDebrid. If the torrent is already avail, littleredrooster will ask which file you'd like to play from the torrent and streams it through mpv using your AllDebrid account.

<p></p>

**NOTE:**
_YOU MUST HAVE AN API KEY FROM ALLDEBRID OR THIS WILL NOT WORK!
-The log file and your API key MUST BOTH be manually configured in the littleredrooster script, 
or else littleredrooster won't do the thing._


**HOW IT ALL WORKS**
----

1. Once you find the torrent you want with tordl, press enter to select it from within the tordl cli interface.

2. tordl will then invoke littleredrooster, which will open a terminal where littleredrooster will use the magnet link from tordl to check if that torrent is already avail to instant stream from AllDebrid right away. 

4. If the torrent is already avail for instant streaming right away, AllDebrid will return a list of available files from that torrent.

5. The user will then select which file from the torrent they want within the list and then littleredrooster will ask `y` or `n` to continue/ b'gawk the jawn now.

6. If the user enters `y` then mpv will open and begin playing the content. If the user selects `n`, then littleredrooster will inform you it has automatically added the magnet link to your AllDebrid account/ rooster boosted the guffin'. Worth noting, link will be 'rooster boosted' whether the user selects `y` or `n`. This is required, otherwise you wouldn't be able to display available files from the torrent.

8. If the torrent is not already avail to instant stream through AllDebrid, littleredrooster will return angry b'gawks, peck at you, and then insult you for your life choices before closing. 

<p></p>
<p></p>

**FUTURE PLANS**

- I want to add more sources/ search engines to tordl so the experience is a bit more consistent. I'd like more resolutions, formats, and language options. A few times I found the links that were unavail to instant stream; -I tried to add them from tordl to AllDebrid manually and there was a small chance they would fail. With enough sources it casts a wide enough net, where eventually it could be made so the user could check torrents for AllDebrid availability using tordl AT user search (insted of with littleredrooster after the user makes a selection).

- I also would like an optional feature that deletes magnet links from your AllDebrid account automatically once you've finished an episode/ season/ movie/ content, etc.

- littleredrooster can now select from multiple espisodes/ versions/ files within a torrent; but will close after that episode plays. So after each episode you have to select the torrent again and reselect the file, which is very quick to do, but an extra step... I am adding more robust episode selection features soon (Next, previous, replay, select from list, and keep the selection screens open after the file is done, etc).

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
   You MUST change `konsole` to whatever termial you use.

6. Configure the littleredrooster file:
   Put your API key in the 4 spots labeled: `YOUR_API_KEY`. Make sure the path to the `littleredrooster.log` file is
   correct on line 4 of the script.


**littleredroster filters files via exclusion: (line 73)**

`file_urls=($(echo "$file_response" | jq -r '.data.magnets.links[] | select(.filename | test("^.*\\.((?! doc|docx|pdf|srt|exe|txt|rtf|csv|log|ini|cfg|jpg|png|gif|webp|bmp|svg|mp3|wav|ogg|flac|aac|html|php|js|css|sh|zip|rar|7z|tar|gz|json|yml|xml|py|java|go|php|com).)*$")) | .link'))`

you can add to or remove from these extentions to get better control of returned files within a torrent. It isn't perfect, but it works most of the time.

If you want to see ALL files withinin the torrents (no filters) use:

`file_urls=($(echo "$file_response" | jq -r '.data.magnets.links[].link'))`


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

<p></p>
<p></p>

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
