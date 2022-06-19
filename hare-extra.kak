# By default, Kakoune inserts tabs when you press TAB in insert mode
# and spaces when you press > in normal mode
# This allows you to insert and remove tabs with > and < respectively
declare-option bool hare_indent_with_tabs false

evaluate-commands %sh{
    if [ "$kak_opt_hare_indent_with_tabs" = true ]; then
        echo "hook global WinSetOption filetype=hare %{ set-option window indentwidth 0 }"
    fi
}

# Expand from the cursor position to capture the hare identifier at point
define-command -hidden select-hare-identifier %{ evaluate-commands %{
  try %{ execute-keys '<a-i>c[^\w:_],[^\w:_]<ret>' } catch %{ fail "failed to expand selection"}
}}

# Display haredoc output for identifier at point
# TODO:
# - make this asynchronous
# - accomplish expansion + haredoc command w/o without interfering w/ user's
#   current selection
define-command haredoc %{
    evaluate-commands %{
        try %{ select-hare-identifier }
    }
    evaluate-commands %sh{
        output=$(haredoc $kak_selection)
        if [ -z "$output" ]; then
            printf "%s\n" "echo -debug no haredoc"
            exit 1
        else
            printf "%s\n" "info \"$output\""
        fi
    }
}

