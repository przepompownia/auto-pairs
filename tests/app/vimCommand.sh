#!/bin/bash
vimWithAutoPairsOnly()
{
    local scriptDir pluginDir vimExecutable pluginFile
    if (( $# < 2 )); then
		echo Two arguments are required: vim executable and the file path.
		return 1
	fi

	scriptDir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
	pluginDir=${scriptDir}/../..
    pluginFile="${pluginDir}/plugin/auto-pairs.vim"
	vimExecutable=${1}
	shift

	$vimExecutable -u NONE -U NONE -N \
		--cmd "set rtp+=${pluginDir}" \
		--cmd "filetype plugin on" \
		--cmd "syntax on" \
		--cmd "set virtualedit+=onemore" \
        --cmd "source ${pluginFile}" \
		"$@"
}
