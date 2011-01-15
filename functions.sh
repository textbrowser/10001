background_check()
{
    trap 'echo "Script does not support non-interactive use."; exit 1' \
    TTIN TTOU
}

