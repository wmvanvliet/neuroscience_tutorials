#!/bin/bash
export JUPYTER_ENABLE_LAB=yes
if [ -n "$SESSION_ID" ]; then
	export PYVISTA_TRAME_SERVER_PROXY_PREFIX="/notebooks/${SESSION_ID}/proxy/"
fi
