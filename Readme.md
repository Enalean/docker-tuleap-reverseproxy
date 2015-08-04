Tuleap Reverse Proxy
====================

In front of a tuleap server, aims to aggregate several services

How to run ?
------------

Create the data container, where the conf will stand (do only once):

    $> docker run --name=tuleap-reverseproxy-data -v /reverseproxy_data busybox true

Run the reverse proxy:

    $> docker run -ti --rm --name=reverse-proxy --link tuleap_web_1:tuleap_web --volumes-from tuleap-reverseproxy-data enalean/tuleap-reverseproxy
