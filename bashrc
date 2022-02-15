cat << EOF
Welcome to your KubeTTY terminal. Happy coding!
EOF

# add Alias definitions.
if [ -f /home/appuser/.bash_aliases ]; then
    . /home/appuser/.bash_aliases
fi

export PS1="\[\e[32m\]kubetty\[\e[m\]> "