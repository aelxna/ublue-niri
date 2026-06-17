function gc --wraps='git clone' --wraps='git commit -m' --description 'alias gc=git clone'
  git clone $argv
        
end
