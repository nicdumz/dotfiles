function prompt_pwd --description 'Print the current working directory, shortend to fit the prompt'
    set p (echo $PWD | sed -e "s|^$HOME|~|")
    # Provide customization possibilities for local machines.
    if functions -q prompt_pwd_after
        echo $p | prompt_pwd_after
    else
        echo $p
    end
end
