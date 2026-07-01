source /usr/share/cachyos-fish-config/cachyos-config.fish
source /home/ktz/.config/fish/conf.d/mise.fish
source /home/ktz/.config/fish/alias.fish

set -gx BROWSER brave
# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/tmp/google-cloud-sdk/path.fish.inc' ]; . '/tmp/google-cloud-sdk/path.fish.inc'; end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/ktz/.lmstudio/bin
# End of LM Studio CLI section

