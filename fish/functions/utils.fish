
function newnote -d "Create a new note"
  set -l dir $HOME/Documents/Notebooks
  set -l name "untitled.md"
  test -z $argv[1] || set -l name "$argv[1]"
  cd $dir && touch $name
  nvim $name
end
