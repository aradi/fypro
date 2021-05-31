SCRIPT_DIR=$(dirname ${BASH_SOURCE})

export PYTHONPATH=${SCRIPT_DIR}/src:${PYTHONPATH}
export PATH=${SCRIPT_DIR}/bin:${PATH}
echo "Environment settings for fypro activated"