# By default, Kakoune inserts tabs when you press TAB in insert mode
# and spaces when you press > in normal mode
# This allows you to insert and remove tabs with > and < respectively
hook global WinSetOption filetype=hare %{
  set-option window indentwidth 0
}
