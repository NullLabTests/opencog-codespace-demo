# Bash completion for cogcli
# Source this file: source cogcli-completion.bash

_cogcli_completions() {
    local cur prev opts
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="scheme count status query eval create script help"

    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
        return 0
    fi

    case "${prev}" in
        scheme|eval)
            local files=$(ls *.scm 2>/dev/null)
            COMPREPLY=($(compgen -W "${files}" -- "${cur}"))
            ;;
        script)
            local scripts=$(ls demo/*.scm demo/use-cases/*.scm 2>/dev/null)
            COMPREPLY=($(compgen -W "${scripts}" -- "${cur}"))
            ;;
    esac
}

complete -F _cogcli_completions cogcli
