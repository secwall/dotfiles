# Machine name.
function box_name {
    hostname -f
}

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}on%{$reset_color%} git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"

PROMPT="\
%{$reset_color%}\
%{$terminfo[bold]%}\
%{$fg[white]%}%n\
@\
$(box_name)\
[%c\
%{$reset_color%}\
${git_info}\
%{$terminfo[bold]%}\
%{$fg[white]%}\
] $ %{$reset_color%}"
