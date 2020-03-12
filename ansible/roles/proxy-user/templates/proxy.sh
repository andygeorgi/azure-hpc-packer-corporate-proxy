export http_proxy="{{ proxy_protocol }}://{{ proxy_host }}:{{ proxy_port }}"
export https_proxy="{{ proxy_protocol }}://{{ proxy_host }}:{{ proxy_port }}"

export HTTP_PROXY="{{ proxy_protocol }}://{{ proxy_host }}:{{ proxy_port }}"
export HTTPS_PROXY="{{ proxy_protocol }}://{{ proxy_host }}:{{ proxy_port }}"

export no_proxy="{{ no_proxy }}"
export NO_PROXY="{{ no_proxy }}"

