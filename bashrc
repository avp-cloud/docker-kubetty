cat << EOF
Welcome to your KubeTTY terminal. Happy coding!
EOF

# add Alias definitions.
if [ -f /root/.bash_aliases ]; then
    . /root/.bash_aliases
fi

export PS1="\[\e[32m\]kubetty\[\e[m\]> "