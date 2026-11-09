#!/usr/bin/env python3
"""Fetch the latest price for a configurable stock ticker and write it to a file.

Intended to be run automatically on Linux, e.g. via cron:
    */5 * * * * /home/ktz/.dotfiles/.scripts/update_stock.py
"""

import json
import os
import urllib.error
import urllib.request
from datetime import datetime, timezone

# ── Configuration ────────────────────────────────────────────────────────────
# Stock ticker to track (e.g. "IBM", "AAPL", "TSLA").
TICKER = "IBM"

# Set this to wherever you want the price file written.
OUTPUT_FILE = os.path.expanduser("~/stock_price.txt")
# ─────────────────────────────────────────────────────────────────────────────

API_URL_TEMPLATE = "https://api.nasdaq.com/api/quote/{ticker}/info?assetclass=stocks"

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


def get_stock_price(ticker):
    """Return the latest last-sale price for *ticker*."""
    url = API_URL_TEMPLATE.format(ticker=ticker.upper())
    data = fetch_json(url)
    price_str = data["data"]["primaryData"]["lastSalePrice"]
    # price_str looks like "$287.56" — strip the dollar sign and commas.
    return float(price_str.replace("$", "").replace(",", ""))


def main():
    now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")

    try:
        price = get_stock_price(TICKER)
    except Exception as exc:  # noqa: BLE001
        price = None
        print(f"Warning: could not fetch {TICKER} price: {exc}")

    if price is not None:
        line = f"{TICKER}: ${price:,.2f} USD"
    else:
        line = f"{TICKER}: unavailable"

    output = [line, f"Updated: {now}"]

    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write("\n".join(output) + "\n")

    print(f"Stock price written to {OUTPUT_FILE}")
    print("\n".join(output))


if __name__ == "__main__":
    main()
