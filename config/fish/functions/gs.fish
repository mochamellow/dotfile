function gs --wraps='git status' --wraps='git branch' --description 'alias gs=git status'
  git status $argv
        
end
