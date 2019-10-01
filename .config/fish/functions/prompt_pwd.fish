function prompt_pwd --description 'Print the current working directory, shortend to fit the prompt'
    set p (echo $PWD | sed -e "s|^$HOME|~|")
    # Provide customization possibilities for local machines.
    if functions -q prompt_pwd_after
        prompt_pwd_after $p
    else
        # u200C is a Zero-Width non-joining character to prevent ligatures.
        printf "$p\u200C"
    end
end
