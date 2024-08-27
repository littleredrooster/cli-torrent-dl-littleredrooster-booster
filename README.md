**tordl+littleredrooster**



ABOUT
-----


-This version of tordl FORKED from https://github.com/mindhuntr/cli-torrent-dl who forked it from https://github.com/mindhuntr/cli-torrent-dl/commits?author=X0R0X -retains the fixes mindhuntr made to Dl1337x + adds my nifty littleredrooster script. 

This is purely a vehicle for learning and experimentation to me. My primary contribution will be littleredrooster, 
but I'll be messing with tordl as well over time.

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

1. Once you find the torrent you want with tordl, press enter and tordl will then invoke littleredrooster, which will use the magnet link from tordl to check if that torrent is already avail to instant stream from AllDebrid right away.

2. If the torrent is already avail for instant streaming right away, littleredrooster will return a list of available files from that torrent. 

3. The user will then enter the number for the associated file they want and mpv will open and begin playing the content.
   It is at this point, the script also deletes the no-longer needed magnet link from your AllDebrid account.




![Screenshot_20240825_180555](https://github.com/user-attachments/assets/676cbef7-b1c3-4236-a408-9632fedce318)




![Screenshot_20240825_181156](https://github.com/user-attachments/assets/c6b95aba-6403-47e8-897d-9a34e5994343)


**NOTE:** If a link is not avail from AllDebrid, littleredrooster will return angry b'gawks, peck at you, and then insult you for your life choices before closing.

<p></p>
<p></p>

---


**FUTURE PLANS**

- More sources/ search engines to tordl so the experience is a bit more consistent. With enough sources it casts a wide enough net, where eventually it could be made so the user could check torrents for AllDebrid availability using tordl AT user search (instead of with littleredrooster after the user makes a selection).

- Offline library to save magnet links to peruse your favorites later. 

- More robust episode selection features (Next, previous, replay, select from list, etc).

- Blacklist a magnet link key; there is already some functionality in tordl to exclude sorces, but I'd like a key press for removing specific magnet links. Particularly useful for littleredrooster when going through many torrent files.

- Better filtering for the files WITHIN a torrent, such as only show mp4, avi, mkv, mp3, wav - etc etc etc.
  This would be to avoid populating littleredrooster with non media content such as exe or txt files.

<p></p>
<p></p>






Installation
------------

### Prerequisites

* Python 3.8+
* pip
* virtualenv
* curl
* jq
* mpv

1. Configure the littleredrooster file:
   Put your AllDebrid API key in the 5 spots labeled: `YOUR_API_KEY`.

2. Navigate to the downloaded folder and run `./setup.sh` -You might have to run `sudo chmod +x ./setup.sh` first.


**Optional**

Edit `~/.config/torrentdl/config.json`:

By default tordl will execute `x-terminal-emulator -e littleredrooster %s` when a file is selected.
If tordl isn't openning your prefered emulator by default; change `x-terminal-emulator` 
in the tordl config.json to your preferred emulator.


![Screenshot_20240826_173258](https://github.com/user-attachments/assets/4ee26462-77f1-43e6-9eba-739cef0fb768)


Uninstall
------------

Navigate to the downloaded folder and run `./setup.sh --uninstall`


littleredrooster cli
---

Out of the box, littleredrooster is by default automatically run by tordl whenever selecting a torrent.
But you can also invoke littleredrooster manually:

`littleredrooster "magnet:?xt=urn:btih:487B57A38963B9C0BACD24tq34......."`

OR

`/path/to/littleredrooster "magnet:?xt=urn:btih:487B57A38963B9C0BACD24tq34......."`

**Filtering torrent files with littleredrooster: (line 103)**

Currently written as (shows all files within a torrent): 

`file_urls=($(echo "$file_response" | jq -r '.data.magnets.links[].link'))`

But I've been experimenting with (works... but not always): 

`file_urls=($(echo "$file_response" | jq -r '.data.magnets.links[] | select(.filename | test("^.*\\.((?! doc|docx|pdf|srt|exe|txt|rtf|csv|log|ini|cfg|jpg|png|gif|webp|bmp|svg|mp3|wav|ogg|flac|aac|html|php|js|css|sh|zip|rar|7z|tar|gz|json|yml|xml|py|java|go|php|com).)*$")) | .link'))`



tordl cli
---

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


tordl Docker
------

Opening magnet links with littleredrooster or your preferred torrent client will not work with this.

**Build**

    $ docker build . -t tordl

**Run JSON RPC Server**

    $ docker run -p 57000:57000 -it tordl -s


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
