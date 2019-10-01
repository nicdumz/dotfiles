function prompt_pwd --description 'Print the current working directory, shortend to fit the prompt'
    set p (echo $PWD | sed -e "s|^$HOME|~|")
    # Provide customization possibilities for local machines.
    if functions -q prompt_pwd_after
        prompt_pwd_after $p
    else
        echo "$p "
    end
end
