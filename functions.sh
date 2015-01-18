background_check()
{
    trap 'echo "The provided script does not support non-interactive use."; exit 1' \
	TTIN TTOU
}
