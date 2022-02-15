export PS1="\[\e[32m\]kubetty\[\e[m\]> "

alias h="helm"
alias k="kubectl"
alias ke="kubectl exec -it"
alias kd="kubectl describe"
alias kl="kubectl logs -f"
alias ktp="kubectl top pods"
alias ktc="kubectl top pods --containers"
alias kgp="kubectl get pods"
alias kgpa="kubectl get pods --all-namespaces"
alias kgd="kubectl get deploy"
alias kgda="kubectl get deploy --all-namespaces"
alias kgs="kubectl get svc"
alias kgsa="kubectl get svc --all-namespaces"
alias kgi="kubectl get ingress"
alias kgia="kubectl get ingress --all-namespaces"