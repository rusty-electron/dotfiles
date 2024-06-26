# dotfiles

I now maintain two linux installations, one on my thinkpad and the other on my dell so one use of this repo is to help sync the configs and another reason is to help the general linux TWM audience in case they happen to need my configs.

> Note: I switched to awesomewm in April 2022, so I will stop updating my i3wm configs soon. I also plan to document my awesomewm setup soon.

### good-stuff
* look for good bash aliases - `.bashrc`
* my vim config - `.vimrc`
* neovim config - I now use my fork of [kickstart.nvim](https://github.com/rusty-electron/kickstart.nvim). I previously maintained a `init.lua` file but it is no longer maintained by me.
* my i3 and i3blocks config - `.config/i3/config` & `.config/i3blocks/config`
* alacritty terminal config - `.config/alacritty/alacritty.yaml`
* picom config - `.config/picom.conf`
* minimal configs - `minimal` contains minimal configs for programs like vim, bash shell, etc., so that I can get a workable vim setup, bash aliases without installing plugins and whatnot.
* dunst config - `.config/dunst/dunstr`, use it with a icon pack like [gnome-icon-theme](https://archlinux.org/packages/community/any/gnome-icon-theme/)

### cool scripts in `scripts`
* i3blocks statusbar scripts - `statusbar/`
* doff - system shutdown control menu using dmenu
* dpomo - [currently broken] a bash script that makes use of [this pomodoro timer script](https://github.com/jsspencer/pomo) to provide a dmenu prompt with useful options 
* electron-menu - dmenu prompt for launching my electron-apps
* installdate - create a list of all installed packages sorted by *install date*
* mpdnotify - provides notifications for song change in a *ncmpcpp+mpd* setup
* toggle-X - scripts to toggle program X
* ytp-old - play the best matched video on youtube using `mpv --no-video`. It has been superceded by my new bash alias that allows to choose the preferred video from the search results using [youtube-viewer](https://github.com/trizen/youtube-viewer).
* ytplaypause - this scripts uses `xdotool` to quickly pause/play an youtube video playing in any i3 workspace
* cdfz - quickly change directory using `fzf` and `ripgrep`
* dclipboard - opens a dmenu prompt that offers various actions to perform on clipboard content. Inspired from [bugswriter]'s script
* dmoji - luke's dmenu emoji script
* dmonitor-select - use dmenu to switch between monitor configs
* dpcmanfm - launch `pcmanfm` at a directory chosen via `dmenu`
* drecord - record screen using `ffmpeg` (needs work)
* fixwacom - I use dual monitors and a wacom graphics tablet so this script is used to map the tablet to a single screen.
* infwall - run, wallpaper changes every 4 s, `ctrl-c` when a suitable set of wallpaper appears
* mathq - tool to help practice math so that your brain works the next time you stare at a store cashier.
* ocr-script - use `imagemagick` to recognize text on screen and copy to clipboard. useful for preparing notes from slides or videos.
* tuxil - pipes the output of `tuxi` to the `bat` for automatic paging.
* showbat - loop through each folder(device) in `/sys/class/power_supply/` that has a `capacity` parameter(file) and cats it. Example output showing laptop and keyboard battery level: `5B10W138: 76% Keychron K2: 96%` 

### *cooler* scripts

* `dclipboard`

based on a script by [bugswriter] that copies the content of the clipboard (should be a link to work properly) and offers the following options, you may add your own if you wish.

<img align="center" width="600px" src="https://user-images.githubusercontent.com/22986666/130289020-cf6ab026-bc45-4400-a600-29342c9cd9d0.png"/>

* `conv4wp` or *convert for whatsapp*

```
I record a video
I send it to a friend on Whatsapp
Friend complains it is not working
made this ffmpeg script 
No more problem
```

* `yearc`

prints how much of this year I have wasted

* `chlock` or change lockscreen wallpaper

I use [betterlockscreen] and I like to see random wallpapers on my screen everyday so I have added a `cronjob` to change the lockscreen wallpaper everyday at 18:00 IST. This script is a `crontab` friendly script to do the same. Works on shells too. Don't forget to change the path to your wallpaper directory.

* `junkfolds`

I usually have to temporarily download some files like media from whatsapp or a pdf from a random site so I had a "tmp" folder in my ~/ but after some time, this directory is filled with several old files and it becomes difficult to recover a recently downloaded file - yes I can sort by time but what if I need a file that I downloaded a week ago, yes :facepalm: I can use `fd` with a time filter but what if I don't know that I need the file from "that" particular day, enter `junkfolds`. You are supposed to run this file as a cron/anacron job. It creates a folder with the name format `DD-MMM` in ~/workspace (modifiable in script) everyday and deletes any older folders with this name format if they are empty (to prevent flooding that folder with such files).

You can now easily retrieve temp files according to the date and manually inspect folder contents to prune them.

### rice images

![term-windows](./img/first.jpg)

![neovim](./img/second.png)

[bugswriter]: https://github.com/bugswriter
[betterlockscreen]: https://github.com/betterlockscreen
