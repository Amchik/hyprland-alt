#!/bin/bash
# Checks packages versions with it's homepage.
# Do `bash check-version.bash --help` for more.

only_failed=0
verbose=0
color=0

while [[ $# -ne 0 ]]; do
    case "$1" in
        --only-failed)
            only_failed=1
            ;;
        --verbose)
            verbose=1
            ;;
        --color)
            color=1
            ;;
        --help)
            echo "Usage: bash check-version.bash [OPTIONS...]"
            echo "Options:"
            echo "    --only-failed   Do not print up to date packages"
            echo "    --verbose       Print all ebuilds for failed package"
            echo "    --color         Pretty output"
            exit 1
            ;;
    esac
    shift 1
done

if [[ $color -eq 1 ]]; then
    COLOR_UPTODATE=$(echo -e '\e[2m')
    COLOR_RED=$(echo -e '\e[1;31m')
    COLOR_BOLD=$(echo -e '\e[1m')
    COLOR_CLEAN=$(echo -e '\e[0m')
fi

ret=0

for pkg in $(ls -d dev-libs/* gui-libs/* gui-wm/*); do
    pkgname=$(basename $pkg)
    ebuilds=($pkg/*.ebuild)
    homepage=$(grep ^HOMEPAGE "${ebuilds[0]}" \
        | sed 's/HOMEPAGE="https:\/\/github.com\/\(.*\)"/\1/')

    # Fetch last tag from github
    last_tag=$(curl -s https://api.github.com/repos/$homepage/tags \
        | jq '.[0].name' \
        | sed 's/"//g;s/^v//')

    # Check ebuild for this tag
    found=0
    for ebuild in $ebuilds; do
        if [[ "$ebuild" = "$pkg/$pkgname-${last_tag}.ebuild" ]]; then
            found=1
            [[ $only_failed -eq 1 ]] || \
                echo "${COLOR_UPTODATE}Package $pkg is up-to-date (${last_tag})${COLOR_CLEAN}"
            break
        fi
    done
    [[ $found -eq 1 ]] && continue
    echo "${COLOR_RED}ERROR:${COLOR_CLEAN}" \
        "Package ${COLOR_BOLD}$pkg${COLOR_CLEAN} is not up-to-date"\
        "(${COLOR_BOLD}${last_tag}${COLOR_CLEAN})"
    ret=1
    if [[ $verbose -eq 1 ]]; then
        for ebuild in $ebuilds; do
            echo "    ${COLOR_UPTODATE}- found $ebuild${COLOR_CLEAN}"
        done
    fi
done

exit $ret
