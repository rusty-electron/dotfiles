# Hiding Google Meet sharing window

watch [Explainer video](https://youtu.be/SvYOEU_yYEU)

> The given steps are for i3wm but it maybe possible to to do the same on other twms, provided they have functionality similar to scratchpad present in i3wm.
  
## scripts
  * `gms` - [here](master/scripts/gms)
  * `gmeet` - [here](scripts/statusbar/gmeet)
  
## steps:
  
  * add the following rule to `i3 config`
  
    ```
    for_window [title="meet.google.com is sharing your screen."] move scratchpad, exec --no-startup-id pkill -RTMIN+19 i3blocks, exec --no-startup-id ~/myfiles/scripts/gms
    ```
    * replace the `-RTMIN+19` signal to any signal number you want and you can replace `i3blocks` with other statusbar programs like `dwmblocks`, `polybar`, etc.
    * place `gms` script at a desired location and reflect the same change on the above line.
  
  * add `gmeet` block to your statusbar config. see [mine](.config/i3blocks/config)
    ```
    command=~/myfiles/scripts/statusbar/$BLOCK_NAME
  
    [gmeet]
    signal=19
    color=#d90436
    ```
    > don't forget to provide the path to `gmeet script` in statusbar config
  * make sure both the `gms` and `gmeet` scripts are executable
  * done
  
    try sharing your screen on google meet and test it out.
