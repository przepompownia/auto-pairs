#!/bin/bash

cd "$(dirname "$0")" || exit 1
. ../app/vimCommand.sh

declare -a vimExecutables

messageFile=/tmp/auto-pairs-tests-vim-messages.log

vimExecutables+=( "$(command -v nvim)" )
# vimExecutables+=( "$(command -v vim)" )

for vimExecutable in "${vimExecutables[@]}"; do
	printf 'Test on %s:\n' "$vimExecutable"
	vimWithAutoPairsOnly "$vimExecutable" \
		--cmd "let g:auto_pairs_test_vim_message_log='${messageFile}'" \
		-S ../app/runner.vim \
		../cases/*.test.vim

	cat $messageFile

	grep -q "0 errors, 0 failures" $messageFile
	status=$?
	rm -f $messageFile

    exit $status
done

exit $status
