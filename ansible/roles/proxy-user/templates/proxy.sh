export http_proxy="{{ proxy_protocol }}://{{ proxy_host }}:{{ proxy_port }}"
export https_proxy="{{ proxy_protocol }}://{{ proxy_host }}:{{ proxy_port }}"

export HTTP_PROXY="{{ proxy_protocol }}://{{ proxy_host }}:{{ proxy_port }}"
export HTTPS_PROXY="{{ proxy_protocol }}://{{ proxy_host }}:{{ proxy_port }}"

export no_proxy="localhost,127.0.0.1"
export NO_PROXY="localhost,127.0.0.1"

