function ls --wraps='exa --icons -F -H --group-directories-first --git -1' --wraps='exa --icons -F -H --group-directories-first --git' --description 'alias ls=exa --icons -F -H --group-directories-first --git'
  exa --icons -F -H --group-directories-first --git $argv
        
end
