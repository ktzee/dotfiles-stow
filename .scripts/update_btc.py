#!/usr/bin/env python3
"""Fetch the current Bitcoin price in USD and write it to a file.

Intended to be run automatically on Linux, e.g. via cron:
    */5 * * * * /home/ktz/.dotfiles/.scripts/update_btc.py
"""

import json
import os
import urllib.error
import urllib.request
from datetime import datetime, timezone

# ── Configuration ────────────────────────────────────────────────────────────
# Set this to wherever you want the price file written.
OUTPUT_FILE = os.path.expanduser(
    "~/.config/noctalia/plugins/not-just-text/btc-price.txt"
)
# ─────────────────────────────────────────────────────────────────────────────

API_URL = "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
        "(KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    ),
    "Accept": "application/json",
}


def fetch_json(url):
    """Fetch JSON from *url* and return it as a Python object."""
    request = urllib.request.Request(url, headers=HEADERS)
    with urllib.request.urlopen(request, timeout=15) as response:
        return json.loads(response.read().decode("utf-8"))


def get_bitcoin_price():
    """Return the current Bitcoin price in USD."""
    data = fetch_json(API_URL)
    return data["bitcoin"]["usd"]


def main():
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")

    try:
        price = get_bitcoin_price()
    except Exception as exc:  # noqa: BLE001
        price = None
        print(f"Warning: could not fetch Bitcoin price: {exc}")

    if price is not None:
        line = f"BTC: ${price:,.2f} USD"
    else:
        line = "BTC: unavailable"

    # output = [line, f"Updated: {now}"]

    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write("\n".join(output) + "\n")

    if price is not None:
        print(f"BTC: ${price:,.2f}")
    else:
        line = "BTC: unavailable"

    # print(f"Bitcoin price written to {OUTPUT_FILE}")
    # print("\n".join(output))


if __name__ == "__main__":
    main()
