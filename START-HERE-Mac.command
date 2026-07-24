#!/bin/bash
# Python for R Users - JSM 2026 Workshop
# Double-click this file to set everything up and start JupyterLab.

# Always work from the folder this file lives in, so that the
# notebooks can find the data/ folder.
cd "$(dirname "$0")" || exit 1

echo
echo "============================================================"
echo "  Python for R Users  -  JSM 2026 Workshop"
echo "============================================================"
echo
echo "This window will set up everything you need and then start"
echo "JupyterLab in your web browser."
echo
echo "The FIRST time you run this, it downloads Python and the"
echo "course packages (a few hundred MB). That can take 5-10"
echo "minutes. Please leave this window open and be patient."
echo "Running it again later starts in just a few seconds."
echo

fail() {
  echo
  echo "------------------------------------------------------------"
  echo " Sorry - $1"
  echo "------------------------------------------------------------"
  echo
  echo " Please email Ethan.Meyers@gmail.com and include a photo or"
  echo " screenshot of this window so I can help you fix it."
  echo
  echo " You can also use Google Colab instead - it needs no setup."
  echo " See the workshop website for the Colab links."
  echo
  read -n 1 -s -r -p "Press any key to close this window..."
  echo
  exit 1
}

# Make sure uv's install folder is visible to this window.
export PATH="$HOME/.local/bin:$PATH"

if ! command -v uv >/dev/null 2>&1; then
  echo "[1/3] Installing uv (this also installs Python for you)..."
  echo
  curl -LsSf https://astral.sh/uv/install.sh | sh || fail "uv could not be installed automatically."
  # uv was just installed - make it visible without restarting.
  export PATH="$HOME/.local/bin:$PATH"
fi

command -v uv >/dev/null 2>&1 || fail "uv could not be found after installing it."

echo
echo "[2/3] Installing the course packages..."
echo
uv sync || fail "the package installation step did not finish."

echo
echo "[3/3] Starting JupyterLab..."
echo
echo "JupyterLab will open in your web browser in a moment."
echo
echo "  *** KEEP THIS WINDOW OPEN while you are working. ***"
echo
echo "When you are finished, close the browser tab and then"
echo "close this window."
echo
uv run jupyter lab

echo
echo "JupyterLab has stopped. You can close this window now."
