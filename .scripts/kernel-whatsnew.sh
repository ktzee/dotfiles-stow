#!/usr/bin/env bash

set -euo pipefail

PKG="linux-cachyos"

installed=$(pacman -Q "$PKG" | awk '{print $2}' | cut -d- -f1)
available=$(pacman -Si "$PKG" | awk '/^Version/ {print $3; exit}' | cut -d- -f1)

version_gt() {
    [[ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | tail -n1)" == "$1" && "$1" != "$2" ]]
}

version_ge() {
    [[ "$1" == "$2" ]] || version_gt "$1" "$2"
}

echo "Installed: $installed"
echo "Available: $available"
echo

#
# Work out which kernel releases we want.
#
if [[ "$installed" == "$available" ]]; then
    echo "No kernel update available."
    echo "Showing release notes for Linux $installed."
    echo

    versions=("$installed")
else
    echo "Showing changes: Linux $installed → $available"
    echo

    major="${available%%.*}"

    index=$(curl -fsSL \
        "https://cdn.kernel.org/pub/linux/kernel/v${major}.x/")

    mapfile -t versions < <(
        printf '%s\n' "$index" |
        grep -oE 'ChangeLog-[0-9]+\.[0-9]+\.[0-9]+' |
        sed 's/ChangeLog-//' |
        sort -Vu |
        while read -r version; do
            if version_gt "$version" "$installed" &&
               version_ge "$available" "$version"; then
                echo "$version"
            fi
        done
    )

    # Fallback in case kernel.org indexing behaves unexpectedly.
    if [[ ${#versions[@]} -eq 0 ]]; then
        versions=("$available")
    fi
fi

#
# Download changelogs.
#
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

for version in "${versions[@]}"; do
    major="${version%%.*}"
    url="https://cdn.kernel.org/pub/linux/kernel/v${major}.x/ChangeLog-${version}"

    echo "Fetching Linux $version..." >&2

    {
        echo
        echo "######## Linux $version ########"
        curl -fsSL "$url"
    } >> "$tmp"
done

echo
echo "Releases:"
printf '  %s\n' "${versions[@]}"
echo

#
# Pull out commit subjects from the kernel changelogs.
#
subjects=$(
    grep '^    [^ ]' "$tmp" |
    sed 's/^    //' |
    grep -v '^$' |
    sort -u
)

show_section() {
    local title="$1"
    local pattern="$2"

    matches=$(
        printf '%s\n' "$subjects" |
        grep -Ei "$pattern" ||
        true
    )

    if [[ -n "$matches" ]]; then
        echo "== $title =="
        printf '  %s\n' "$matches"
        echo
    fi
}

show_section "Graphics / GPU" \
    'drm|amdgpu|radeon|nouveau|nvidia|intel.*graphics|xe:'

show_section "Audio" \
    'snd|alsa|audio|soundwire'

show_section "USB" \
    'usb|xhci|type-c|typec'

show_section "Networking / Wi-Fi / Bluetooth" \
    'wifi|wireless|iwlwifi|ath[0-9]|bluetooth|net:|ethernet'

show_section "Filesystems / Storage" \
    'btrfs|ext4|xfs|f2fs|ntfs|nvme|ata|scsi|block:'

show_section "CPU / Scheduler" \
    'sched|scheduler|x86|amd|intel|cpu'

show_section "Security" \
    'security|vulnerability|cve|selinux|apparmor'

echo "== All changes =="
printf '  %s\n' "$subjects"
